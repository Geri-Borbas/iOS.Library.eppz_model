//
//  EPPZCollectionEnumerator.h
//  eppz!model
//
//  Created by Borbás Geri  on 04/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>


typedef void (^EPPZCollectionValueEnumeratingBlock)(id eachValue);
typedef id (^EPPZCollectionValueProcessingBlock)(id eachValue);


@interface EPPZCollectionEnumerator : NSObject


/*! Returns YES if the value is either @c NSArray, @c NSDictionary, @c NSSet or @c NSOrderedSet. */
+(BOOL)isCollection:(id) value;

/*! Enumerates each value in the collection. */
+(void)enumerateCollection:(id) collection enumeratingBlock:(EPPZCollectionValueEnumeratingBlock) enumeratingBlock;

/*!
 
 Returns a new collection with the processed values. Processed
 values should be returned from the processing block.
 
 */
+(id)processCollection:(id) collection processingBlock:(EPPZCollectionValueProcessingBlock) processingBlock;


@end
