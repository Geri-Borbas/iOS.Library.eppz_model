//
//  EPPZMapper.h
//  eppz!model
//
//  Created by Borbás Geri  on 02/05/14.
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
@compatibility_alias Collections EPPZCollectionEnumerator;

#import "EPPZTracker.h"


/*! Field dictionary entry shortcut */
#define field(field) field : field


@interface EPPZMapper : NSObject


/*! A field name where dictionary representation Unique identifier that identifies the object within the scope of a mapping. Default value is @c @@"_id". */
@property (nonatomic, strong) NSString *modelIdField;

/*! A field name where dictionary representation will store the class name of the model. Default value is @c @@"_type". */
@property (nonatomic, strong) NSString *classNameField;

/*! The date format string to be appllied when representing `NSDate`. */
@property (nonatomic, strong) NSString *dateFormat;

/*! The time zone string to be appllied when representing `NSDate`. */
@property (nonatomic, strong) NSString *timeZone;

/*! The date formatter that is composed from `dateFormat` and `timeZone`. */
@property (nonatomic, readonly) NSDateFormatter *dateFormatter;

/*! Whether to represent model attributes - @c modelId, @c className - or not. Without these values mapper cannot reconstruct objects from dictionaries. Default value is @c YES. */
@property (nonatomic) BOOL representModelAttributes;

/*!
 
 Whether to represent referenced objects. Default value is NO. When turned off, representing
 can result in an endless loop, so only turn off where there are no circular references among
 the modeled fields.
 
 When turned on, referenced objects representation will contain only model attributes.
 
 */
@property (nonatomic) BOOL representReferences;

/*! Field mapper to be used when representing dictionaries from given models. */
@property (nonatomic, strong) EPPZFieldMapper *fieldMapper;
@property (nonatomic, strong) EPPZValueMapper *nilValueMapper;
@property (nonatomic, strong) EPPZValueMapper *defaultValueMapper;
@property (nonatomic, strong) NSDictionary *valueMappersForFields;
@property (nonatomic, strong) NSDictionary *valueMappersForTypeNames;



/*!
 
 Returns a dictionary representation of the given model only with the given fields. @c NSObject
 instances gonna call this method internally, not intended to client use.
 
 @param model
 Model object to be represented.
 
 @param fields
 Either an @c NSArray of fields to be represented, or may pass in an @c NSDictionary with fields,
 and can also passing sub-fields within collections down the line. In the latter case only
 the keys gonna be parsed, the actual values will be dismissed (unless it is a sub-field
 @c NSDictionary).
 
 @param pool
 Object pool tracking the represented objects to resolve cross-references between objects.
 
 */
-(NSDictionary*)_dictionaryRepresentationOfModel:(NSObject*) model fields:(id) fields pool:(NSMutableArray*) pool;

/*!
 
 Initializes the given model with the given dictionary representation (using selected mapper).
 Sets every property that is represented, also create objects down the object graph is not
 existed already.
 
 @param dictionary
 Dictionary holding the representation of the model to be initialized.
 
 @param tracker
 Model tracker tracking the represented objects (keyed by @c modelId) to resolve cross-references between objects.
 
 */
-(void)_initializeModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary tracker:(EPPZTracker*) tracker;

/*!
 
 Configures the given model with the given dictionary representation (using selected mapper).
 Sets every property that is represented, but only on objects that are already living in
 the runtime object graph.
 
 @param dictionary
 Dictionary holding the representation of the model to be initialized.
 
 @param pool
 Object pool tracking the represented objects (keyed by @c modelId) to resolve cross-references between objects.
 
 */
-(void)_configureModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary pool:(NSMutableDictionary*) pool;



#pragma mark - Debug

@property (nonatomic) BOOL writeRepresentationLog;
@property (nonatomic, strong) NSString *logFileDirectory;



@end
