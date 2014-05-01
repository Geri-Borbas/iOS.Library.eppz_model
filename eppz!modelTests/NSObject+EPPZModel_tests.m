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


#define PropertyInspectionShouldWork @"[NSObject typeOfPropertyNamed:] should work as expected."


#pragma mark - Test model

typedef struct
{
    int number;
    char character;
} PropertyInspectionTestsStruct;


@interface PropertyInspectionTestsModel : NSObject


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
@property (nonatomic) void *voidPointerProperty;
@property (nonatomic) char *characterStringProperty;

@property (nonatomic) id idProperty;
@property (nonatomic) Class classProperty;
@property (nonatomic) SEL selectorProperty;


@property (nonatomic) UInt16 uInt16Property;
@property (nonatomic) Float64 float64Property;
@property (nonatomic) PropertyInspectionTestsStruct structProperty;


@property (nonatomic, strong) UIView *viewProperty;


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

-(void)testClassName
{
    XCTAssertEqualObjects(self.model.className,
                          @"PropertyInspectionTestsModel",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model classOfPropertyNamed:@"viewProperty"],
                          [UIView class],
                          PropertyInspectionShouldWork);
}

-(void)testTypeOfPropertyNamed
{
    XCTAssertNil([self.model typeOfPropertyNamed:@"integerProperty"],
                 PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"intProperty"],
                          @"int",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"shortProperty"],
                          @"short",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"longProperty"],
                          @"long",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"longLongProperty"],
                          @"long long",
                          PropertyInspectionShouldWork);
    
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"unsignedCharProperty"],
                          @"unsigned char",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"unsignedIntProperty"],
                          @"unsigned int",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"unsignedShortProperty"],
                          @"unsigned short",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"unsignedLongProperty"],
                          @"unsigned long",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"unsignedLongLongProperty"],
                          @"unsigned long long",
                          PropertyInspectionShouldWork);
    
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"floatProperty"],
                          @"float",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"doubleProperty"],
                          @"double",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"voidPointerProperty"],
                          @"void*",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"characterStringProperty"],
                          @"char*",
                          PropertyInspectionShouldWork);
    
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"idProperty"],
                          @"id",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"classProperty"],
                          @"Class",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"selectorProperty"],
                          @"SEL",
                          PropertyInspectionShouldWork);
    
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"uInt16Property"],
                          @"unsigned short",
                          PropertyInspectionShouldWork);
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"float64Property"],
                          @"double",
                          PropertyInspectionShouldWork);
    
    
    XCTAssertEqualObjects([self.model typeOfPropertyNamed:@"structProperty"],
                          @"struct",
                          PropertyInspectionShouldWork);
}


@end
