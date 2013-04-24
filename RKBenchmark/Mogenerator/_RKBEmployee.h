// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RKBEmployee.h instead.

#import <CoreData/CoreData.h>


extern const struct RKBEmployeeAttributes {
    __unsafe_unretained NSString *active;
    __unsafe_unretained NSString *comments;
    __unsafe_unretained NSString *companyID;
    __unsafe_unretained NSString *createdAt;
    __unsafe_unretained NSString *emailAddress;
    __unsafe_unretained NSString *employeeID;
    __unsafe_unretained NSString *hireDate;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *position;
    __unsafe_unretained NSString *salary;
    __unsafe_unretained NSString *terminationDate;
} RKBEmployeeAttributes;

extern const struct RKBEmployeeRelationships {
    __unsafe_unretained NSString *company;
} RKBEmployeeRelationships;

extern const struct RKBEmployeeFetchedProperties {
} RKBEmployeeFetchedProperties;

@class RKBCompany;













@interface RKBEmployeeID : NSManagedObjectID {}
@end

@interface _RKBEmployee : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RKBEmployeeID*)objectID;





@property (nonatomic, strong) NSNumber* active;



@property BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* comments;



//- (BOOL)validateComments:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* companyID;



@property int16_t companyIDValue;
- (int16_t)companyIDValue;
- (void)setCompanyIDValue:(int16_t)value_;

//- (BOOL)validateCompanyID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* emailAddress;



//- (BOOL)validateEmailAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* employeeID;



@property int16_t employeeIDValue;
- (int16_t)employeeIDValue;
- (void)setEmployeeIDValue:(int16_t)value_;

//- (BOOL)validateEmployeeID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* hireDate;



//- (BOOL)validateHireDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* position;



//- (BOOL)validatePosition:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* salary;



@property int16_t salaryValue;
- (int16_t)salaryValue;
- (void)setSalaryValue:(int16_t)value_;

//- (BOOL)validateSalary:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* terminationDate;



//- (BOOL)validateTerminationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) RKBCompany *company;

//- (BOOL)validateCompany:(id*)value_ error:(NSError**)error_;





@end

@interface _RKBEmployee (CoreDataGeneratedAccessors)

@end

@interface _RKBEmployee (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;




- (NSString*)primitiveComments;
- (void)setPrimitiveComments:(NSString*)value;




- (NSNumber*)primitiveCompanyID;
- (void)setPrimitiveCompanyID:(NSNumber*)value;

- (int16_t)primitiveCompanyIDValue;
- (void)setPrimitiveCompanyIDValue:(int16_t)value_;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSString*)primitiveEmailAddress;
- (void)setPrimitiveEmailAddress:(NSString*)value;




- (NSNumber*)primitiveEmployeeID;
- (void)setPrimitiveEmployeeID:(NSNumber*)value;

- (int16_t)primitiveEmployeeIDValue;
- (void)setPrimitiveEmployeeIDValue:(int16_t)value_;




- (NSDate*)primitiveHireDate;
- (void)setPrimitiveHireDate:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePosition;
- (void)setPrimitivePosition:(NSString*)value;




- (NSNumber*)primitiveSalary;
- (void)setPrimitiveSalary:(NSNumber*)value;

- (int16_t)primitiveSalaryValue;
- (void)setPrimitiveSalaryValue:(int16_t)value_;




- (NSDate*)primitiveTerminationDate;
- (void)setPrimitiveTerminationDate:(NSDate*)value;





- (RKBCompany*)primitiveCompany;
- (void)setPrimitiveCompany:(RKBCompany*)value;


@end
