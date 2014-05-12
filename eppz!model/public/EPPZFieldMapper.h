//
//  EPPZFieldMapper.h
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


static NSString *const EPPZFieldMapperWarningNonStringObject = @"Representation field map cannot contain non-string object <%@>.";
static NSString *const EPPZFieldMapperWarningNoRepresentedCounterpart = @"No represented field counterpart for runtime field `%@`.";
static NSString *const EPPZFieldMapperWarningNoRuntimeCounterpart = @"No runtime field counterpart for representation field `%@`.";


@interface EPPZFieldMapper : NSObject


/*!
 
 Returns a field mapper object initialized with the given fields.
 
 @param fields
 An array that shows which field are to be represented in further representations. Represented
 fields name will be the same as runtime fields. If you need a mapping between runtime an
 representation field names, use @c +fieldMapperWithRepresentationFieldMap: or @c +map:.
 
 */
+(instancetype)fieldMapperWithFields:(NSArray*) fields;

/*! A short alias for @c +fieldMapperWithFields: factory method. */
+(instancetype)fields:(NSArray*) fields;

/*!
 
 Returns a field mapper object initialized with the given field map.
 
 @param representationFieldMap
 A dictionary to map runtime field names (on the left) to representation
 field names (on the right). Representation field names stands for keys
 in further dictionary representations.
 
 */
+(instancetype)fieldMapperWithRepresentationFieldMap:(NSDictionary*) representationFieldMap;

/*! A short alias for @c +fieldMapperWithRepresentationFieldMap: factory method. */
+(instancetype)map:(NSDictionary*) representationFieldMap;

/*! Returns YES if any map is contained within. */
@property (nonatomic, readonly) BOOL isCustomized;



#pragma mark - Accessors

/*! List of runtime fields. */
-(NSArray*)runtimeFields;

/*! List of representation fields. */
-(NSArray*)representationFields;

/*! Returns the representation field counterpart for a given runtime field. */
-(NSString*)representationFieldForField:(NSString*) runtimeField;

/*! Returns the runtime field counterpart for a given representation field. */
-(NSString*)runtimeFieldForField:(NSString*) representationField;


@end
