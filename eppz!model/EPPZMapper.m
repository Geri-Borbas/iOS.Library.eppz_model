//
//  EPPZMapper.m
//  eppz!model
//
//  Created by orbás Geri  on 02/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZMapper.h"
#import "NSObject+EPPZModel.h"


@interface EPPZMapper ()
@property (nonatomic, strong) EPPZValueMapper *defaultValueMapper;
@end


@implementation EPPZMapper


#pragma mark - Default mappers

-(id)init
{
    if (self = [super init])
    {
        // Field mapper.
        self.fieldMapper = [FieldMapper new];
        
        // Default (straight) value mapper.
        self.defaultValueMapper = [ValueMapper new];
        
        // Value mapper.
        self.valueMappersForTypeNames =
        @{
          
          @"NSNull" : [ValueMapper representer:^id(id runtimeValue) {
                                       return @"<null>";
                                   } reconstructor:^id(id representedValue) {
                                       return [NSNull null];
                                   }],
          
          @"CGSize" : [ValueMapper  type:@"CGSize"
                             representer:^id(id runtimeValue) {
                                 return NSStringFromCGSize([runtimeValue CGSizeValue]);
                             } reconstructor:^id(id representedValue) {
                                 return [NSValue valueWithCGSize:CGSizeFromString((NSString*)representedValue)];
                             }],
          
          
          /*
          @"NSArray" : [ValueMapper valueMapperWithRepresenter:^id(id runtimeValue)
                        {
                            return @"array";
                        }
                                                 reconstructor:^id(id representedValue)
                        {
                            return [NSArray array];
                        }],
          */
          
          };
    }
    return self;
}


#pragma mark - Representation

-(NSDictionary*)dictionaryRepresentationOfModel:(NSObject*) model fields:(NSArray*) fields
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    // Create representation for each property using representers.
    [fields enumerateObjectsUsingBlock:^(NSString *eachField, NSUInteger index, BOOL *stop)
    {
        // Check for property.
        if ([model.propertyNames containsObject:eachField] == NO)
        { WARNING_AND_VOID(@"Can't find field `%@` on <%@> to represent.", eachField, model.className); }
        
        // Get value mapper (for filed, then for type as a fallback).
        EPPZValueMapper *valueMapper = [self valueMapperForField:eachField];
        if (valueMapper == self.defaultValueMapper)
        {
            NSString *typeName = [model typeOfPropertyNamed:eachField];
            valueMapper = [self valueMapperForTypeName:typeName];
        }
        
        // Represented value.
        id eachValue = [model valueForKey:eachField];
        if (eachValue == nil) valueMapper = [self valueMapperForTypeName:@"NSNull"]; // `null` values represented with `NSNull` mapper
        id eachRepresentation = [valueMapper representValue:eachValue];
        
        // Represented field.
        NSString *eachRepresentedField = [self.fieldMapper representationFieldForField:eachField];
        
        // Set.
        [dictionary setObject:eachRepresentation forKey:eachRepresentedField];
    }];
    
    return dictionary;
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
    
    return [self.valueMappersForTypeNames objectForKey:typeName];
}


#pragma mark - Reconstruction

-(void)configureModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary
{
    // Do.
}


@end
