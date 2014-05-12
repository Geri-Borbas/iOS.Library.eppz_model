//
//  EPPZMapper+Accessors.m
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

#import "EPPZMapper+Accessors.h"
#import "EPPZSwizzler.h"


@implementation EPPZMapper (Accessors)
@dynamic defaultValueMapper;


#pragma mark - Synthesize properties

+(void)load
{
    [EPPZSwizzler synthesizePropertyNamed:@"defaultValueMapper"
                                   ofKind:[EPPZValueMapper class]
                                 forClass:[EPPZMapper class]
                               withPolicy:retain];
}

#pragma mark - Field enumerator

-(void)enumerateFields:(id) fields enumeratingBlock:(EPPZMapperFieldEnumeratingBlock) enumeratingBlock
{
    if ([fields isKindOfClass:[NSArray class]])
    {
        NSArray *array = (NSArray*)fields;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         { enumeratingBlock(obj, nil); }];
    }
    
    if ([fields isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dictionary = (NSDictionary*)fields;
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
         { enumeratingBlock(key, obj); }];
    }
}


#pragma mark - Value mapper accessors

-(EPPZValueMapper*)valueMapperForField:(NSString*) field
{
    // Checks.
    if (field == nil) return self.defaultValueMapper;
    if (self.valueMappersForFields == nil) return self.defaultValueMapper;
    if ([[self.valueMappersForFields allKeys] containsObject:field] == NO) return self.defaultValueMapper;
    
    return [self.valueMappersForFields objectForKey:field];
}

-(EPPZValueMapper*)valueMapperForTypeName:(NSString*) typeName
{
    // Checks.
    if (typeName == nil) return self.defaultValueMapper;
    if (self.valueMappersForTypeNames == nil) return self.defaultValueMapper;
    if ([[self.valueMappersForTypeNames allKeys] containsObject:typeName] == NO) return self.defaultValueMapper;
    
    // Check for aliases.
    id valueMapper = [self.valueMappersForTypeNames objectForKey:typeName];
    if ([valueMapper isKindOfClass:[NSString class]])
    { return [self valueMapperForTypeName:(NSString*)valueMapper]; }
    
    return (EPPZValueMapper*)valueMapper;
}


#pragma mark - Reconstruction

-(BOOL)isValueNilRepresentation:(id) value
{
    if ([value isKindOfClass:[NSString class]] == NO) return NO;
    if ([value isEqualToString:self.nilValueMapper.representerBlock(nil)] == NO) return NO;
    return YES;
}

-(NSString*)modelIdInDictionaryRepresentationIfAny:(NSDictionary*) dictionary
{
    if ([dictionary isKindOfClass:[NSDictionary class]] == NO) return @"";
    if ([[dictionary allKeys] containsObject:self.modelIdField] == NO) return @"";
    NSString *modelId = [dictionary objectForKey:self.modelIdField];
    if ([modelId isKindOfClass:[NSString class]] == NO) return @"";
    return modelId;
}

-(BOOL)isValueRepresentedEPPZModel:(id) value
{
    // Look for `<EPPZModel>` representations.
    
    // Is `NSDictionary`.
    if ([value isKindOfClass:[NSDictionary class]] == NO) return NO;
    NSDictionary *eachRepresentationDictionary = (NSDictionary*)value;
    
    // Has `modelId` key.
    if ([[eachRepresentationDictionary allKeys] containsObject:self.modelIdField] == NO) return NO;
    NSString *modelId = [eachRepresentationDictionary objectForKey:self.modelIdField];
    
    // Has `modelId` value.
    if ([modelId isKindOfClass:[NSString class]] == NO) return NO;
    if (modelId == nil) return NO;
    
    // Has `modelId` key.
    if ([[eachRepresentationDictionary allKeys] containsObject:self.classNameField] == NO) return NO;
    NSString *className = [eachRepresentationDictionary objectForKey:self.classNameField];
    
    // Has `modelId` value.
    if ([className isKindOfClass:[NSString class]] == NO) return NO;
    if (className == nil) return NO;
    
    // Is class present.
    Class class = NSClassFromString(className);
    if (class == nil) return NO;
    
    // Phew, we can reconstruct like that.
    return YES;
}


@end
