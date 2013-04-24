// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RKBEmployee.m instead.

#import "_RKBEmployee.h"

const struct RKBEmployeeAttributes RKBEmployeeAttributes = {
    .active = @"active",
    .comments = @"comments",
    .companyID = @"companyID",
    .createdAt = @"createdAt",
    .emailAddress = @"emailAddress",
    .employeeID = @"employeeID",
    .hireDate = @"hireDate",
    .name = @"name",
    .position = @"position",
    .salary = @"salary",
    .terminationDate = @"terminationDate",
};

const struct RKBEmployeeRelationships RKBEmployeeRelationships = {
    .company = @"company",
};

const struct RKBEmployeeFetchedProperties RKBEmployeeFetchedProperties = {
};

@implementation RKBEmployeeID
@end

@implementation _RKBEmployee

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Employee";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:moc_];
}

- (RKBEmployeeID*)objectID {
    return (RKBEmployeeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

    if ([key isEqualToString:@"activeValue"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"active"];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
        return keyPaths;
    }
    if ([key isEqualToString:@"companyIDValue"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"companyID"];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
        return keyPaths;
    }
    if ([key isEqualToString:@"employeeIDValue"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"employeeID"];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
        return keyPaths;
    }
    if ([key isEqualToString:@"salaryValue"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"salary"];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
        return keyPaths;
    }

    return keyPaths;
}




@dynamic active;



- (BOOL)activeValue {
    NSNumber *result = [self active];
    return [result boolValue];
}

- (void)setActiveValue:(BOOL)value_ {
    [self setActive:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveActiveValue {
    NSNumber *result = [self primitiveActive];
    return [result boolValue];
}

- (void)setPrimitiveActiveValue:(BOOL)value_ {
    [self setPrimitiveActive:[NSNumber numberWithBool:value_]];
}





@dynamic comments;






@dynamic companyID;



- (int16_t)companyIDValue {
    NSNumber *result = [self companyID];
    return [result shortValue];
}

- (void)setCompanyIDValue:(int16_t)value_ {
    [self setCompanyID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCompanyIDValue {
    NSNumber *result = [self primitiveCompanyID];
    return [result shortValue];
}

- (void)setPrimitiveCompanyIDValue:(int16_t)value_ {
    [self setPrimitiveCompanyID:[NSNumber numberWithShort:value_]];
}





@dynamic createdAt;






@dynamic emailAddress;






@dynamic employeeID;



- (int16_t)employeeIDValue {
    NSNumber *result = [self employeeID];
    return [result shortValue];
}

- (void)setEmployeeIDValue:(int16_t)value_ {
    [self setEmployeeID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveEmployeeIDValue {
    NSNumber *result = [self primitiveEmployeeID];
    return [result shortValue];
}

- (void)setPrimitiveEmployeeIDValue:(int16_t)value_ {
    [self setPrimitiveEmployeeID:[NSNumber numberWithShort:value_]];
}





@dynamic hireDate;






@dynamic name;






@dynamic position;






@dynamic salary;



- (int16_t)salaryValue {
    NSNumber *result = [self salary];
    return [result shortValue];
}

- (void)setSalaryValue:(int16_t)value_ {
    [self setSalary:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSalaryValue {
    NSNumber *result = [self primitiveSalary];
    return [result shortValue];
}

- (void)setPrimitiveSalaryValue:(int16_t)value_ {
    [self setPrimitiveSalary:[NSNumber numberWithShort:value_]];
}





@dynamic terminationDate;






@dynamic company;








@end
