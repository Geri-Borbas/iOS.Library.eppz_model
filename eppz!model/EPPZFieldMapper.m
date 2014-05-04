//
//  EPPZFieldMapper.m
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

#import "EPPZFieldMapper.h"
#import "NSObject+EPPZModel_inspecting.h"


@interface EPPZFieldMapper ()
@property (nonatomic, strong) NSDictionary *representationFieldMap;
@property (nonatomic, strong) NSDictionary *runtimeFieldMap;
@end


@implementation EPPZFieldMapper


#pragma mark - Creation

+(instancetype)map:(NSDictionary*) representationFieldMap
{ return [self fieldMapperWithRepresentationFieldMap:representationFieldMap]; }

+(instancetype)fieldMapperWithRepresentationFieldMap:(NSDictionary*) representationFieldMap
{
    EPPZFieldMapper *instance = [self new];
    instance.representationFieldMap = representationFieldMap;
    return instance;
}


#pragma mark - Field maps

-(BOOL)isCustomized
{ return (self.representationFieldMap != nil); }

-(void)setRepresentationFieldMap:(NSDictionary*) representationFieldMap
{
    NSMutableDictionary *representationFieldMap_ = [NSMutableDictionary new];
    NSMutableDictionary *runtimeFieldMap_ = [NSMutableDictionary new];
    
    // Create two-way index.
    [representationFieldMap enumerateKeysAndObjectsUsingBlock:^(NSString *eachRuntimeField, NSString *eachRepresentationField, BOOL *stop)
    {
        // Validate each.
        if ([eachRuntimeField isKindOfClass:[NSString class]] == NO)
        { WARNING_AND_VOID(EPPZFieldMapperWarningNonStringObject, eachRuntimeField.className); }
        
        if ([eachRepresentationField isKindOfClass:[NSString class]] == NO)
        { WARNING_AND_VOID(EPPZFieldMapperWarningNonStringObject, eachRepresentationField.className); }
            
        // Collect each direction otherwise.
        [representationFieldMap_ setObject:eachRepresentationField forKey:eachRuntimeField];
        [runtimeFieldMap_ setObject:eachRuntimeField forKey:eachRepresentationField];
        
    }];
    
    // Set.
    _representationFieldMap = [NSDictionary dictionaryWithDictionary:representationFieldMap_];
    _runtimeFieldMap = [NSDictionary dictionaryWithDictionary:runtimeFieldMap_];
}


#pragma mark - Accessors

-(NSArray*)runtimeFields
{ return self.representationFieldMap.allKeys; }

-(NSArray*)representationFields
{ return self.runtimeFieldMap.allKeys; }

-(NSString*)representationFieldForField:(NSString*) runtimeField
{
    // Unchanged if no mapping.
    if (self.representationFieldMap == nil) return runtimeField;
    
    // Unchanged if no counterpart.
    if ([[self.representationFieldMap allKeys] containsObject:runtimeField] == NO)
    {
        WARNING(EPPZFieldMapperWarningNoRepresentedCounterpart, runtimeField);
        return runtimeField;
    }
    
    // Return counterpart.
    return [self.representationFieldMap objectForKey:runtimeField];
}

-(NSString*)runtimeFieldForField:(NSString*) representationField
{
    // Unchanged if no mapping.
    if (self.runtimeFieldMap == nil) return representationField;
    
    // Unchanged if no counterpart.
    if ([[self.runtimeFieldMap allKeys] containsObject:representationField] == NO)
    {
        WARNING(@"No runtime field counterpart for representation field `%@`.", representationField);
        return representationField;
    }
    
    // Return counterpart.
    return [self.runtimeFieldMap objectForKey:representationField];
}

@end
