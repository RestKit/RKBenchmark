// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RKBCompany.h instead.

#import <CoreData/CoreData.h>


extern const struct RKBCompanyAttributes {
    __unsafe_unretained NSString *active;
    __unsafe_unretained NSString *companyID;
    __unsafe_unretained NSString *foundingDate;
    __unsafe_unretained NSString *industry;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *taxID;
    __unsafe_unretained NSString *url;
} RKBCompanyAttributes;

extern const struct RKBCompanyRelationships {
    __unsafe_unretained NSString *employees;
} RKBCompanyRelationships;

extern const struct RKBCompanyFetchedProperties {
} RKBCompanyFetchedProperties;

@class RKBEmployee;









@interface RKBCompanyID : NSManagedObjectID {}
@end

@interface _RKBCompany : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RKBCompanyID*)objectID;





@property (nonatomic, strong) NSNumber* active;



@property BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* companyID;



@property int16_t companyIDValue;
- (int16_t)companyIDValue;
- (void)setCompanyIDValue:(int16_t)value_;

//- (BOOL)validateCompanyID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* foundingDate;



//- (BOOL)validateFoundingDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* industry;



//- (BOOL)validateIndustry:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* taxID;



@property int16_t taxIDValue;
- (int16_t)taxIDValue;
- (void)setTaxIDValue:(int16_t)value_;

//- (BOOL)validateTaxID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *employees;

- (NSMutableSet*)employeesSet;





@end

@interface _RKBCompany (CoreDataGeneratedAccessors)

- (void)addEmployees:(NSSet*)value_;
- (void)removeEmployees:(NSSet*)value_;
- (void)addEmployeesObject:(RKBEmployee*)value_;
- (void)removeEmployeesObject:(RKBEmployee*)value_;

@end

@interface _RKBCompany (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;




- (NSNumber*)primitiveCompanyID;
- (void)setPrimitiveCompanyID:(NSNumber*)value;

- (int16_t)primitiveCompanyIDValue;
- (void)setPrimitiveCompanyIDValue:(int16_t)value_;




- (NSDate*)primitiveFoundingDate;
- (void)setPrimitiveFoundingDate:(NSDate*)value;




- (NSString*)primitiveIndustry;
- (void)setPrimitiveIndustry:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveTaxID;
- (void)setPrimitiveTaxID:(NSNumber*)value;

- (int16_t)primitiveTaxIDValue;
- (void)setPrimitiveTaxIDValue:(int16_t)value_;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;





- (NSMutableSet*)primitiveEmployees;
- (void)setPrimitiveEmployees:(NSMutableSet*)value;


@end
