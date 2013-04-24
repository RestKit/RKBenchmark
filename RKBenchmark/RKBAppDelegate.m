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
    employeeMapping.identificationAttributes = @[ @"employeeID" ];
    
    RKEntityMapping *companyMapping = [[RKEntityMapping alloc] initWithEntity:self.managedObjectModel.entitiesByName[@"Company"]];
    companyMapping.identificationAttributes = @[ @"companyID" ];
    [companyMapping addAttributeMappingsFromDictionary:@{
     @"active": @"active",
     @"company_id": @"companyID",
     @"founding_date": @"foundingDate",
     @"industry": @"industry",
     @"name": @"name",
     @"tax_id": @"taxID",
     @"url": @"url" }];
    
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
                                                     withMapping:employeeMapping
                                                         keyPath:@"employees"
                                                           error:&error];
        NSAssert(count == 5000 && error == nil, @"Import failed: %@", error);
        BOOL success = [importer finishImporting:&error];
        NSAssert(success, @"Failed to finish import due to error: %@", error);
    };
    void (^importFiveThousandEmployeesWithNestedCompanies)(RKManagedObjectImporter *) = ^(RKManagedObjectImporter *importer) {
        NSError *error = nil;
        NSUInteger count = [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"employees_with_nested_companies" ofType:@"json"]
                                                     withMapping:employeeMapping
                                                         keyPath:@"employees"
                                                           error:&error];
        NSAssert(count == 5000 && error == nil, @"Import failed: %@", error);
        BOOL success = [importer finishImporting:&error];
        NSAssert(success, @"Failed to finish import due to error: %@", error);
    };
    void (^importFiveThousandEmployeesWithThreeHundredAndFiftyConnectedCompanies)(RKManagedObjectImporter *) = ^(RKManagedObjectImporter *importer) {
        NSError *error = nil;
        NSUInteger count = [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"employees_and_companies" ofType:@"json"]
                                                     withMapping:employeeMapping
                                                         keyPath:@"employees"
                                                           error:&error];
        NSAssert(count == 5000 && error == nil, @"Import of %d employees failed: %@", count, error);
        count = [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"employees_and_companies" ofType:@"json"]
                                          withMapping:companyMapping
                                              keyPath:@"companies"
                                                error:&error];
        NSAssert(count == 350 && error == nil, @"Import of %d companies failed: %@", count, error);
        BOOL success = [importer finishImporting:&error];
        NSAssert(success, @"Failed to finish import due to error: %@", error);
    };
    
    // Benchmark on a dispatch queue for easy thread separation in Instruments
    dispatch_queue_t benchmarkingQueue = dispatch_queue_create("org.restkit.benchmarking", NULL);
    dispatch_async(benchmarkingQueue, ^{        
        // Benchmark Attributes Only
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
        
        
        // Benchmark Nested Relationships
        [employeeMapping addRelationshipMappingWithSourceKeyPath:@"company" mapping:companyMapping];        
        [self benchmarkImportWithName:@"Import 5000 Employees with Nested Company via In Memory Store + Fetch Request Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                            configure:setFetchRequestCache
                            benchmark:importFiveThousandEmployeesWithNestedCompanies];
        [self benchmarkImportWithName:@"Import 5000 Employees with Nested Company via In Memory Store + In Memory Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                            configure:setInMemoryCache
                            benchmark:importFiveThousandEmployeesWithNestedCompanies];
        [self benchmarkImportWithName:@"Import 5000 Employees with Nested Company via In Memory Store + nil Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                            configure:setNilCache
                            benchmark:importFiveThousandEmployeesWithNestedCompanies];
        
        [self benchmarkImportWithName:@"Import 5000 Employees with Nested Company via SQLite Store + Fetch Request Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                            configure:setFetchRequestCache
                            benchmark:importFiveThousandEmployeesWithNestedCompanies];
        [self benchmarkImportWithName:@"Import 5000 Employees with Nested Company via SQLite Store + In Memory Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                            configure:setInMemoryCache
                            benchmark:importFiveThousandEmployeesWithNestedCompanies];
        [self benchmarkImportWithName:@"Import 5000 Employees with Nested Company via SQLite Store + nil Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                            configure:setNilCache
                            benchmark:importFiveThousandEmployeesWithNestedCompanies];
        
        // Benchmark Connected Relationships
        // NOTE: You cannot map an object with connections with a `nil` cache
        RKRelationshipMapping *companyMapping = [employeeMapping propertyMappingsBySourceKeyPath][@"company"];
        [employeeMapping removePropertyMapping:companyMapping];
        [employeeMapping addConnectionForRelationship:@"company" connectedBy:@"companyID"];
        [self benchmarkImportWithName:@"Import 5000 Employees with Connected Company via In Memory Store + Fetch Request Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                            configure:setFetchRequestCache
                            benchmark:importFiveThousandEmployeesWithThreeHundredAndFiftyConnectedCompanies];
        [self benchmarkImportWithName:@"Import 5000 Employees with Connected Company via In Memory Store + In Memory Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                            configure:setInMemoryCache
                            benchmark:importFiveThousandEmployeesWithThreeHundredAndFiftyConnectedCompanies];
        
        [self benchmarkImportWithName:@"Import 5000 Employees with Connected Company via SQLite Store + Fetch Request Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                            configure:setFetchRequestCache
                            benchmark:importFiveThousandEmployeesWithThreeHundredAndFiftyConnectedCompanies];
        [self benchmarkImportWithName:@"Import 5000 Employees with Connected Company via SQLite Store + In Memory Cache"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeSQLite
                            configure:setInMemoryCache
                            benchmark:importFiveThousandEmployeesWithThreeHundredAndFiftyConnectedCompanies];
        
        // Benchmark Attributes w/ Modification Detection Enabled
        employeeMapping.identificationAttributes = @[ @"employeeID" ];
        employeeMapping.modificationKey = @"createdAt";
        [self benchmarkImportWithName:@"Import 5000 Employees twice with In Memory Store, In Memory Cache + Modification Key"
                  persistentStoreType:RKBenchmarkPersistentStoreTypeInMemory
                            configure:setInMemoryCache
                            benchmark:^(RKManagedObjectImporter *importer) {
                                [RKBenchmark report:@"Initial Import" executionBlock:^{
                                    importFiveThousandEmployees(importer);
                                }];
                                [RKBenchmark report:@"Secondary Import" executionBlock:^{
                                    importFiveThousandEmployees(importer);
                                }];
                                importFiveThousandEmployees(importer);
                            }];
        
        exit(0);
    });
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
