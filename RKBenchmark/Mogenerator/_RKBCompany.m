// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RKBCompany.m instead.

#import "_RKBCompany.h"

const struct RKBCompanyAttributes RKBCompanyAttributes = {
    .active = @"active",
    .companyID = @"companyID",
    .foundingDate = @"foundingDate",
    .industry = @"industry",
    .name = @"name",
    .taxID = @"taxID",
    .url = @"url",
};

const struct RKBCompanyRelationships RKBCompanyRelationships = {
    .employees = @"employees",
};

const struct RKBCompanyFetchedProperties RKBCompanyFetchedProperties = {
};

@implementation RKBCompanyID
@end

@implementation _RKBCompany

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Company";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Company" inManagedObjectContext:moc_];
}

- (RKBCompanyID*)objectID {
    return (RKBCompanyID*)[super objectID];
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
    if ([key isEqualToString:@"taxIDValue"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"taxID"];
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





@dynamic foundingDate;






@dynamic industry;






@dynamic name;






@dynamic taxID;



- (int16_t)taxIDValue {
    NSNumber *result = [self taxID];
    return [result shortValue];
}

- (void)setTaxIDValue:(int16_t)value_ {
    [self setTaxID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTaxIDValue {
    NSNumber *result = [self primitiveTaxID];
    return [result shortValue];
}

- (void)setPrimitiveTaxIDValue:(int16_t)value_ {
    [self setPrimitiveTaxID:[NSNumber numberWithShort:value_]];
}





@dynamic url;






@dynamic employees;


- (NSMutableSet*)employeesSet {
    [self willAccessValueForKey:@"employees"];

    NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"employees"];

    [self didAccessValueForKey:@"employees"];
    return result;
}







@end
