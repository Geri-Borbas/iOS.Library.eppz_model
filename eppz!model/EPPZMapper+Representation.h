//
//  EPPZMapper+Representation.h
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


/*!
 
 Features of @c EPPZMapper to be used internally while representing models to @c NSDictionary
 representations. Methods here not meant for public use.
 
 */
@interface EPPZMapper (Representation)


/*!
 
 Returns a dictionary representation of the given model (only with the given fields).
 
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


@end
