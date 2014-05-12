//
//  EPPZMapper+Accessors.h
//  eppz!model
//
//  Created by Borbás Geri on 12/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZMapper.h"


typedef void (^EPPZMapperFieldEnumeratingBlock)(NSString *eachField, NSDictionary *eachSubFields);


/*!
 
 Features of @c EPPZMapper to be used internally while representing models from @c NSDictionary
 representations. Methods here not meant for public use.
 
 */
@interface EPPZMapper (Accessors)


#pragma mark - Field enumerator

/*!
 
 Enumerates fields in the given @c fields collection either it is an @c NSArray
 or an @c NSDictionary.
 
 */
-(void)enumerateFields:(id) fields enumeratingBlock:(EPPZMapperFieldEnumeratingBlock) enumeratingBlock;


#pragma mark - Value mapper accessors

@property (nonatomic, strong) EPPZValueMapper *defaultValueMapper;

/*! Select a value mapper for a given @c field. */
-(EPPZValueMapper*)valueMapperForField:(NSString*) field;

/*! Select a value mapper for a given type name. */
-(EPPZValueMapper*)valueMapperForTypeName:(NSString*) typeName;


#pragma mark - Reconstruction

/*! Check if a value is the representation of a @c nil value using mapper's @c nilValueMapper. */
-(BOOL)isValueNilRepresentation:(id) value;

/* Look for a valid @c modelId within a dictionary representation. */
-(NSString*)modelIdInDictionaryRepresentationIfAny:(NSDictionary*) dictionary;

/*! Check if a value represents an @c <EPPZModel> (look for valid model attributes within). */
-(BOOL)isValueRepresentedEPPZModel:(id) value;


@end
