//
//  EPPZValueMapper.m
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

#import "EPPZValueMapper.h"


@implementation EPPZValueMapper


-(id)representValue:(id) runtimeValue
{ return runtimeValue; }

-(id)reconstructValue:(id) representedValue
{ return representedValue; }


/*
 
 -(id)representationValueForRuntimeValue:(id) value
 {
 #warning Hook in representers!
 return value;
 }
 
 -(NSDictionary*)representersForPropertyNames
 {
 return @{
 
 @"threeValue" : [EPPZMapper mapperForTypeName:@"NSArray"
 representer:^id(NSArray *value){
 if (value.count < 3) return nil; // Checks
 return [value componentsJoinedByString:@","];
 }
 reconstructor:^id(NSString *value){
 return [value componentsSeparatedByString:@","];
 }]
 
 };
 }
 
 -(NSArray*)representersForTypeNames
 {
 return @[
 
 [EPPZMapper mapperForTypeName:@"NSArray"
 representer:^id(NSArray *value){
 
 NSMutableArray *representation = [NSMutableArray new];
 [value enumerateObjectsUsingBlock:^(id eachValue, NSUInteger idx, BOOL *stop){
 
 // Represent each array member as well.
 [representation addObject:[self representationValueForRuntimeValue:eachValue]];
 
 }];
 return [NSArray arrayWithArray:representation];
 
 }
 reconstructor:^id(NSString *value) { return value; }],
 
 [EPPZMapper mapperForTypeName:@"NSString"
 representer:^id(NSString *value) { return value; }
 reconstructor:^id(NSString *value) { return value; }],
 
 [EPPZMapper mapperForTypeName:@"float"
 representer:^id(float value){
 return @(value);
 }
 reconstructor:^float(NSNumber *representation){
 return representation.floatValue;
 }],
 
 ];
 }
 */

@end
