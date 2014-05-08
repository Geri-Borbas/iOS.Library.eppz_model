//
//  PropertyInspectionTestsModel.h
//  eppz!model
//
//  Created by orbás Geri  on 02/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


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
@property (nonatomic, strong) NSString *stringProperty;
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