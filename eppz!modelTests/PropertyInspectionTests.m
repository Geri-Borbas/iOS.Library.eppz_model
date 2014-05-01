//
//  NSObject+EPPZModel_tests.m
//  eppz!model
//
//  Created by Gardrobe on 01/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "EPPZModel.h"


#pragma mark - Test model

typedef struct
{
    int number;
    char character;
} PropertyInspectionTestsStruct;


@interface PropertyInspectionTestsModel : NSObject


#pragma mark - Basic C types

@property (nonatomic) char charProperty;
@property (nonatomic) int intProperty;
@property (nonatomic) short shortProperty;
@property (nonatomic) long longProperty;
@property (nonatomic) long long longLongProperty;

@property (nonatomic) unsigned char unsignedCharProperty;
@property (nonatomic) unsigned int unsignedIntProperty;
@property (nonatomic) unsigned short unsignedShortProperty;
@property (nonatomic) unsigned long unsignedLongProperty;
@property (nonatomic) unsigned long long unsignedLongLongProperty;

@property (nonatomic) float floatProperty;
@property (nonatomic) double doubleProperty;
@property (nonatomic) char *characterStringProperty;


#pragma mark - Basic C type pointers

@property (nonatomic) char *charPointerProperty;
@property (nonatomic) int *intPointerProperty;
@property (nonatomic) short *shortPointerProperty;
@property (nonatomic) long *longPointerProperty;
@property (nonatomic) long long *longLongPointerProperty;

@property (nonatomic) unsigned char *unsignedCharPointerProperty;
@property (nonatomic) unsigned int *unsignedIntPointerProperty;
@property (nonatomic) unsigned short *unsignedShortPointerProperty;
@property (nonatomic) unsigned long *unsignedLongPointerProperty;
@property (nonatomic) unsigned long long *unsignedLongLongPointerProperty;

@property (nonatomic) float *floatPointerProperty;
@property (nonatomic) double *doublePointerProperty;
@property (nonatomic) void *voidPointerProperty;
@property (nonatomic) char **characterStringPointerProperty;


#pragma mark - Basic Objective-C types

@property (nonatomic) id idProperty;
@property (nonatomic) Class classProperty;
@property (nonatomic) SEL selectorProperty;


#pragma mark - Platform abstracted types

@property (nonatomic) UInt16 uInt16Property;
@property (nonatomic) Float64 float64Property;


#pragma mark - CoreGraphics struct types

@property (nonatomic) CGPoint pointProperty;
@property (nonatomic) CGSize sizeProperty;
@property (nonatomic) CGVector vectorProperty;
@property (nonatomic) CGRect rectProperty;


#pragma mark - Struct types

@property (nonatomic) PropertyInspectionTestsStruct structProperty;


@end


@implementation PropertyInspectionTestsModel
@end


#pragma mark - Test case

@interface PropertyInspectionTests : XCTestCase
@property (nonatomic, strong) PropertyInspectionTestsModel *model;
@end


@implementation PropertyInspectionTests


-(void)setUp
{
    [super setUp];
    self.model = [PropertyInspectionTestsModel instance];
}

-(void)testClassOfPropertyNamed
{
    /*
    XCTAssertEqualObjects(self.model.className,
                          @"PropertyInspectionTestsModel",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model classOfPropertyNamed:@"viewProperty"],
                          [UIView class],
                          PropertyInspectionShouldWork);
    */
}

-(void)testTypeOfPropertyNamed
{
    NSDictionary *assertations = @{
                                   
                                   @"charProperty" : @"char",
                                   @"intProperty" : @"int",
                                   @"shortProperty" : @"short",
                                   @"longProperty" : @"long",
                                   @"longLongProperty" : @"long long",
                                   @"unsignedCharProperty" : @"unsigned char",
                                   @"unsignedIntProperty" : @"unsigned int",
                                   @"unsignedShortProperty" : @"unsigned short",
                                   @"unsignedLongProperty" : @"unsigned long",
                                   @"unsignedLongLongProperty" : @"unsigned long long",
                                   @"floatProperty" : @"float",
                                   @"doubleProperty" : @"double",
                                   @"characterStringProperty" : @"char*",
                                   
                                   @"charPointerProperty" : @"char*",
                                   @"intPointerProperty" : @"int*",
                                   @"shortPointerProperty" : @"short*",
                                   @"longPointerProperty" : @"long*",
                                   @"longLongPointerProperty" : @"long long*",
                                   @"unsignedCharPointerProperty" : @"char*", // Same as character string!
                                   @"unsignedIntPointerProperty" : @"unsigned int*",
                                   @"unsignedShortPointerProperty" : @"unsigned short*",
                                   @"unsignedLongPointerProperty" : @"unsigned long*",
                                   @"unsignedLongLongPointerProperty" : @"unsigned long long*",
                                   @"floatPointerProperty" : @"float*",
                                   @"doublePointerProperty" : @"double*",
                                   @"characterStringPointerProperty" : @"char**",
                                   
                                   @"idProperty" : @"id",
                                   @"classProperty" : @"Class",
                                   @"selectorProperty" : @"SEL",
                                   
                                   @"uInt16Property" : @"unsigned short",
                                   @"float64Property" : @"double",
                                   
                                   @"pointProperty" : @"CGPoint",
                                   @"sizeProperty" : @"CGSize",
                                   @"vectorProperty" : @"CGVector",
                                   @"rectProperty" : @"CGRect",
                                   
                                   @"structProperty" : @"struct"
                                   
                                   };
    
    // Assert each above.
    [assertations enumerateKeysAndObjectsUsingBlock:^(NSString *eachPropertyName, NSString *eachAssertedTypeName, BOOL *stop)
    {
        XCTAssertEqualObjects([self.model typeOfPropertyNamed:eachPropertyName],
                              eachAssertedTypeName,
                              @"Type of property `%@` should return `%@`.", eachPropertyName, eachAssertedTypeName);
    }];
    
    XCTAssertNil([self.model typeOfPropertyNamed:@"Non-existing property name"],
                 @"Type of unknown property should return `nil` with a warning.");
}


@end
