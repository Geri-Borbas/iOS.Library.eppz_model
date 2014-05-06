//
//  EPPZCollectionEnumerator.m
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

#import "EPPZCollectionEnumerator.h"


@implementation EPPZCollectionEnumerator

+(BOOL)isCollection:(id) value
{
    return ([value isKindOfClass:[NSArray class]] ||
            [value isKindOfClass:[NSDictionary class]] ||
            [value isKindOfClass:[NSSet class]] ||
            [value isKindOfClass:[NSOrderedSet class]]);
}

+(void)enumerateCollection:(id) collection enumeratingBlock:(EPPZCollectionValueEnumeratingBlock) enumeratingBlock
{
    if ([collection isKindOfClass:[NSArray class]])
    {
        NSArray *array = (NSArray*)collection;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        { enumeratingBlock(obj); }];
    }
    
    if ([collection isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dictionary = (NSDictionary*)collection;
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        { enumeratingBlock(obj); }];
    }
    
    if ([collection isKindOfClass:[NSSet class]])
    {
        NSSet *set = (NSSet*)collection;
        [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
        { enumeratingBlock(obj); }];
    }
    
    if ([collection isKindOfClass:[NSOrderedSet class]])
    {
        NSOrderedSet *orderedSet = (NSOrderedSet*)collection;
        [orderedSet enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        { enumeratingBlock(obj); }];
    }
}

+(id)processCollection:(id) collection processingBlock:(EPPZCollectionValueProcessingBlock) processingBlock
{
    if ([collection isKindOfClass:[NSArray class]])
    {
        NSArray *array = (NSArray*)collection;
        NSMutableArray *mutable = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            id _obj = processingBlock(nil, obj);
            if (_obj != nil)
            { [mutable addObject:_obj]; }
        }];
        return [NSArray arrayWithArray:mutable];
    }
    
    if ([collection isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dictionary = (NSDictionary*)collection;
        NSMutableDictionary *mutable = [NSMutableDictionary new];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        {
            id _obj = processingBlock(key, obj);
            if (_obj != nil)
            { [mutable setObject:_obj forKey:key]; }
        }];
        return [NSDictionary dictionaryWithDictionary:mutable];
    }
    
    if ([collection isKindOfClass:[NSSet class]])
    {
        NSSet *set = (NSSet*)collection;
        NSMutableSet *mutable = [NSMutableSet new];
        [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
        {
            id _obj = processingBlock(nil, obj);
            if (_obj != nil)
            { [mutable addObject:_obj]; }
        }];
        return [NSSet setWithSet:mutable];
    }
    
    if ([collection isKindOfClass:[NSOrderedSet class]])
    {
        NSOrderedSet *orderedSet = (NSOrderedSet*)collection;
        NSMutableOrderedSet *mutable = [NSMutableOrderedSet new];
        [orderedSet enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            id _obj = processingBlock(nil, obj);
            if (_obj != nil)
            { [mutable addObject:_obj]; }
        }];
        return [NSOrderedSet orderedSetWithOrderedSet:mutable];
    }
    
    // Return `nil` if it is not a collection.
    return nil;
}


@end
