//
//  EPPZMapper.h
//  eppz!model
//
//  Created by Borbás Geri on 02/05/14.
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

#import "EPPZFieldMapper.h"
@compatibility_alias FieldMapper EPPZFieldMapper;

#import "EPPZValueMapper.h"
@compatibility_alias ValueMapper EPPZValueMapper;

#import "EPPZCollectionEnumerator.h"

#import "EPPZTracker.h"


/*! Field dictionary entry shortcut */
#define field(field) field : field


/*!
 
 An object that stores mapping characteristics. See property documentations
 for details.
 
 */
@interface EPPZMapper : NSObject


#pragma mark - Mapping attributes

/*!
 
 A field name where dictionary representation stores unique identifier that
 identifies the object within the scope of a mapping (known as @c modelId).
 Default value is @c @@"_id".
 
 */
@property (nonatomic, strong) NSString *modelIdField;

/*!
 
 A field name where dictionary representation stores the class name of the model.
 Default value is @c @@"_type".
 
 */
@property (nonatomic, strong) NSString *classNameField;

/*!
 
 The date format string to be appllied when representing `NSDate`.
 
 */
@property (nonatomic, strong) NSString *dateFormat;

/*!
 
 The time zone string to be appllied when representing `NSDate`.
 
 */
@property (nonatomic, strong) NSString *timeZone;

/*!
 
 The date formatter that is composed from `dateFormat` and `timeZone`.
 
 */
@property (nonatomic, readonly) NSDateFormatter *dateFormatter;

/*!
 
 Whether to represent model attributes (known as @c modelId and @c className)
 or not. Without these values mapper cannot reconstruct objects from dictionaries.
 Default value is @c YES.
 
 */
@property (nonatomic) BOOL representModelAttributes;

/*!
 
 Whether to represent referenced objects. Default value is NO. When turned off,
 representing can result in an endless loop, so only turn off where there are no
 circular references among the modeled fields.
 
 When turned on, referenced objects representation will contain only model
 attributes (known as @c modelId and @c className).
 
 */
@property (nonatomic) BOOL representReferences;


/*! Field mapper to be used when representing dictionaries from given models. */
@property (nonatomic, strong) EPPZFieldMapper *fieldMapper;
@property (nonatomic, strong) EPPZValueMapper *nilValueMapper;
@property (nonatomic, strong) EPPZValueMapper *defaultValueMapper;
@property (nonatomic, strong) NSDictionary *valueMappersForFields;
@property (nonatomic, strong) NSDictionary *valueMappersForTypeNames;


@end
