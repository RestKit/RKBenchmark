//
//  RKBAppDelegate.m
//  RKBenchmark
//
//  Created by Blake Watters on 4/24/13.
//  Copyright (c) 2013 RestKit. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <RestKit/Testing/RKBenchmark.h>
#import "RKBAppDelegate.h"

static void RKBDeleteFileAtPath(NSString *path)
{
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (fileExists) {
        NSError *error;
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        NSCAssert(success, @"Failed to remove existing store with error: %@", error);
    }
}

typedef NS_ENUM(NSUInteger, RKBenchmarkPersistentStoreType) {
    RKBenchmarkPersistentStoreTypeInMemory,
    RKBenchmarkPersistentStoreTypeSQLite
};

@interface RKBAppDelegate ()
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) RKEntityMapping *employeeMapping;
@end

@implementation RKBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Configure RestKit
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelOff);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);
    RKLogConfigureByName("RestKit/Search", RKLogLevelOff);
    
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RKBenchmark" ofType:@"momd"]];
    self.managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    
    RKEntityMapping *employeeMapping = [[RKEntityMapping alloc] initWithEntity:self.managedObjectModel.entitiesByName[@"Employee"]];
    [employeeMapping addAttributeMappingsFromDictionary:@{
     @"active": @"active",
     @"comments": @"comments",
     @"company_id": @"companyID",
     @"created_at": @"createdAt",
     @"email_address": @"emailAddress",
     @"employee_id": @"employeeID",
     @"hire_date": @"hireDate",
     @"name": @"name",
     @"position": @"position",
     @"salary": @"salary",
     @"termination_date": @"terminationDate"}];
    self.employeeMapping = employeeMapping;
    
    // Execute Benchmarks
    void (^setFetchRequestCache)(RKManagedObjectImporter *) = ^(RKManagedObjectImporter *importer) {
        importer.managedObjectCache = [RKFetchRequestManagedObjectCache new];
    };
    void (^setInMemoryCache)(RKManagedObjectImporter *) = ^(RKManagedObjectImporter *importer) {
        importer.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:importer.managedObjectContext];
    };
    void (^setNilCache)(RKManagedObjectImporter *) = ^(RKManagedObjectImporter *importer) {
        importer.managedObjectCache = nil;
    };
    void (^importFiveThousandEmployees)(RKManagedObjectImporter *) = ^(RKManagedObjectImporter *importer) {
        NSError *error = nil;
        NSUInteger count = [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"employees" ofType:@"json"]
                                                     withMapping:self.employeeMapping
                                                         keyPath:@"employees"
                                                           error:&error];
        NSAssert(count == 5000 && error == nil, @"Import failed: %@", error);
    };    
    
    [self benchmarkImportWithName:@"Import 5000 Employees with In Memory Store + Fetch Request Cache"
              persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                        configure:setFetchRequestCache
                        benchmark:importFiveThousandEmployees];
    [self benchmarkImportWithName:@"Import 5000 Employees with In Memory Store + In Memory Cache"
              persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                        configure:setInMemoryCache
                        benchmark:importFiveThousandEmployees];
    [self benchmarkImportWithName:@"Import 5000 Employees with In Memory Store + nil Cache"
              persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                        configure:setNilCache
                        benchmark:importFiveThousandEmployees];
    
    [self benchmarkImportWithName:@"Import 5000 Employees with SQLite Store + Fetch Request Cache"
              persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                        configure:setFetchRequestCache
                        benchmark:importFiveThousandEmployees];
    [self benchmarkImportWithName:@"Import 5000 Employees with SQLite Store + In Memory Cache"
              persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                        configure:setInMemoryCache
                        benchmark:importFiveThousandEmployees];
    [self benchmarkImportWithName:@"Import 5000 Employees with SQLite Store + nil Cache"
              persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                        configure:setNilCache
                        benchmark:importFiveThousandEmployees];
    
    exit(0);
    return YES;
}

- (void)benchmarkImportWithName:(NSString *)name persistentStoreType:(RKBenchmarkPersistentStoreType)storeType configure:(void(^)(RKManagedObjectImporter *importer))configure benchmark:(void(^)(RKManagedObjectImporter *importer))benchmark
{
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSPersistentStore *persistentStore = nil;
    if (storeType == RKBenchmarkPersistentStoreTypeInMemory) {
        NSError *error = nil;
        persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
        NSAssert(persistentStore, @"Failed to add In Memory Store: %@", error);
    } else if (RKBenchmarkPersistentStoreTypeSQLite) {
        NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKBenchmarking.sqlite"];
        RKBDeleteFileAtPath(storePath);
        NSError *error = nil;
        persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
        NSAssert(persistentStore, @"Failed to add In Memory Store: %@", error);
    }
    RKManagedObjectImporter *importer = [[RKManagedObjectImporter alloc] initWithPersistentStore:persistentStore];
    if (configure) configure(importer);
    [RKBenchmark report:name executionBlock:^{
        benchmark(importer);
    }];
}

@end
