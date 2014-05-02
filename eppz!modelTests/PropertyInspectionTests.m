//
//  NSObject+EPPZModel_tests.m
//  eppz!model
//
//  Created by Borbás Geri on 01/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <XCTest/XCTest.h>
#import "EPPZModel.h"
#import "PropertyInspectionTestsModel.h"


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
     XCTAssertEqualObjects([self.model classOfPropertyNamed:@"stringProperty"],
                           [NSString class],
                           @"Class of property `stringProperty` should return `[NSString class]`.");
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
                                   @"stringProperty" : @"NSString",
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
