//
//  EPPZMapper+Representation.m
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

#import "EPPZMapper+Representation.h"
#import "EPPZMapper+Debug.h"
#import "EPPZMapper+Accessors.h"

#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel_mapping.h"
#import "NSObject+EPPZModel_mapping_internal.h"


@implementation EPPZMapper (Representation)


-(NSDictionary*)_dictionaryRepresentationOfModel:(NSObject*) model fields:(id) fields pool:(NSMutableArray*) pool;
{
    // Represent only `<EPPZModel>` conforming objects.
    if ([model conformsToProtocol:@protocol(EPPZModel)] == NO)
    {
        WARNING(@"Object <%@> not conforms to <EPPZModel>, returning empty dictionary representation.", self.className);
        return @{};
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    // Model attributes (if not turned off).
    if (self.representModelAttributes)
    {
        [dictionary setObject:model.modelId forKey:self.modelIdField];
        [dictionary setObject:model.className forKey:self.classNameField];
    }
    
    // Reference tracking.
    
    if ([model isKindOfClass:NSClassFromString(@"Achivement")])
    {
        
    }
    
    // Turn of object tracking if explicitly requested.
    if (self.representReferences) pool = nil;
    
    // If already represented (so tracked in pool).
    BOOL alreadyRepresented = [pool containsObject:model.modelId];
    if (alreadyRepresented) { return dictionary; } // Only model attributes gets represented.
    else { [pool addObject:model.modelId]; } // Track is being represented otherwise.
    
    
    // If no fields sent, represent everything.
    if (fields == nil)
    {
        EPPZFieldMapper *fieldMapper = model.class.mapper.fieldMapper;
        fields = (fieldMapper.isCustomized) ? fieldMapper.runtimeFields : model.propertyNames;
    }
    
    // Create representation for each property using representers.
    [self enumerateFields:fields enumeratingBlock:^(NSString *eachField, NSDictionary *eachSubFields)
    {
         // Check for property at all.
         if ([model respondsToSelector:NSSelectorFromString(eachField)] == NO)
         { WARNING_AND_VOID(@"Can't find field `%@` on <%@> to represent.", eachField, model.className); }
         
         // Get value.
         id eachValue = [model valueForKey:eachField];
         
         // Represent collection.
         if ([Collections isCollection:eachValue])
         {
             // Process each value within.
             eachValue = [Collections processCollection:eachValue processingBlock:^id(NSUInteger eachCollectionIndex, id eachCollectionKey, id eachCollectionValue)
                          {
                              // Represent as dictionary if an `<EPPZModel>` inside.
                              if ([eachCollectionValue conformsToProtocol:@protocol(EPPZModel)])
                              {
                                  NSObject *eachObject = (NSObject*)eachCollectionValue;
                                  return [eachObject _dictionaryRepresentationOfFields:eachSubFields pool:pool];
                              }
                              
                              // Or represent single value.
                              return [self representValue:eachCollectionValue
                                                    model:model
                                                    field:eachField
                                                subFields:eachSubFields
                                        isCollectionValue:YES
                                                     pool:pool];
                              
                          }];
         }
         
         // Represent single value.
         NSString *eachRepresentedField = [self.fieldMapper representationFieldForField:eachField];
         id eachRepresentedValue = [self representValue:eachValue
                                                  model:model
                                                  field:eachField
                                              subFields:eachSubFields
                                      isCollectionValue:NO
                                                   pool:pool];
         
         // Set.
         [dictionary setObject:eachRepresentedValue forKey:eachRepresentedField];
         
         // Debug.
         if (self.writeRepresentationLog)
         {
             static int counter;
             counter++;
             NSString *fileName = FORMAT(@"%i <%@> (%@).log", counter, model.className, model.modelId);
             [dictionary.description writeToFile:[self.logFileDirectory stringByAppendingPathComponent:fileName] atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
         }
     }];
    
    return dictionary;
}

-(id)representValue:(id) value
              model:(id) model
              field:(NSString*) field
          subFields:(id) subfields
  isCollectionValue:(BOOL) isCollectionValue
               pool:(NSMutableArray*) pool
{
    // Represent `<EPPZModel>` values first (with their own mapper).
    if ([value conformsToProtocol:@protocol(EPPZModel)])
    {
        NSObject *object = (NSObject*)value;
        return [object _dictionaryRepresentationOfFields:subfields pool:pool];
    }
    
    // Get value mapper (for field, then for type as a fallback).
    EPPZValueMapper *valueMapper = [self valueMapperForField:field];
    if (valueMapper == self.defaultValueMapper)
    {
        // Get typeName for the field.
        NSString *typeName = [model typeOfPropertyNamed:field];
        
        // Or get typeName for the value itself if it is a value within collection.
        if (isCollectionValue)
        { typeName = NSStringFromClass([value class]); }
        
        valueMapper = [self valueMapperForTypeName:typeName];
    }
    
    // Pass fields to value mapper if any.
    valueMapper.fields = subfields;
    
    // Represent value.
    if (value == nil) return [NSNull null]; // valueMapper = self.nilValueMapper; // `nil` values represented with `nil` mapper
    id representation = [valueMapper representValue:value];
    
    return representation;
}


@end
