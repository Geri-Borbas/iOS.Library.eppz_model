//
//  NSObject+EPPZModel_mapping.h
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

#import <Foundation/Foundation.h>
#import "EPPZMapper.h"


@interface NSObject (EPPZModel_mapping)


#pragma mark - Mappers

/*! A mapper that specifies how the model is represented, reconstructed. */
+(EPPZMapper*)defaultMapper;

/*!
 
 Currently selected mapper that specifies how the model is represented,
 reconstructed. If not set already, falls back to @c +defaultMapper.
 
 */
+(EPPZMapper*)mapper;
-(void)setMapper:(EPPZMapper*) mapper;


#pragma mark - Representation (runtime to dictionary)

/*! Returns a dictionary representation (using selected mapper). */
-(NSDictionary*)dictionaryRepresentation;

/*! Returns a dictionary representation only with the given fields (properties) using selected mapper. */
-(NSDictionary*)dictionaryRepresentationOfFields:(NSArray*) fields;


#pragma mark - Reconstruction (dictionary to runtime)

/*!
 
 Creates an instance with the given dictionary representation (using @c defaultMapper).
 Uses @c +instance to create a new instance.
 
 */
+(instancetype)instanceWithDictionary:(NSDictionary*) dictionary;

/*! Configures an instance with the given dictionary representation (using selected mapper). */
-(void)configureWithDictionary:(NSDictionary*) dictionary;


@end
