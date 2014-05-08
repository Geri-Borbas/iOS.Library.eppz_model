//
//  EPPZMapper.m
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

#import "EPPZMapper.h"
#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel_mapping.h"
#import "EPPZMapper+Default.h"


typedef void (^EPPZMapperFieldEnumeratingBlock)(NSString *eachField, NSDictionary *eachSubFields);


@interface EPPZMapper ()
@end


@implementation EPPZMapper


#pragma mark - Date formatter

-(NSDateFormatter*)dateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:self.dateFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:self.timeZone]];
    return dateFormatter;
}


#pragma mark - Representation

-(void)setNilValueMapper:(EPPZValueMapper*) nilValueMapper
{
    _nilValueMapper = nilValueMapper;

    // Validate.
    if ([nilValueMapper.representerBlock(nil) isKindOfClass:[NSString class]] == NO)
    {
        [NSException exceptionWithName:@"Invalid `nil` value mapper."
                                reason:@"A `nil` representer should always return an NSString"
                              userInfo:nil];
    }
}

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
    [self enumerateFields:fields :^(NSString *eachField, NSDictionary *eachSubFields)
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
            eachValue = [Collections processCollection:eachValue processingBlock:^id(id eachCollectionKey, id eachCollectionValue)
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

-(void)enumerateFields:(id) fields :(EPPZMapperFieldEnumeratingBlock) enumeratingBlock
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

-(void)_initializeModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary pool:(NSMutableDictionary *)pool
{
    // Track that model is being represented.
    [pool setObject:model forKey:[self modelIdInDictionaryRepresentationIfAny:dictionary]];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *eachField, id eachRepresentedValue, BOOL *stop)
    {
        NSString *eachReconstructedField = [self.fieldMapper runtimeFieldForField:eachField];
        
        id eachValue;
        
        // Reconstruct `<EPPZModel>` representations.
        if ([self isValueRepresentedEPPZModel:eachRepresentedValue])
        { eachValue = [self reconstructEPPZModel:eachRepresentedValue pool:pool]; }
        
        // Reconstruct an arbitrary value.
        else
        {
            eachValue = [self reconstructSingleValue:eachRepresentedValue
                                               model:model
                                               field:eachReconstructedField
                                                pool:pool];
        }
        
        [self tryToSetValue:eachValue forKey:eachReconstructedField onModel:model];
    }];
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

-(id)reconstructEPPZModel:(id) dictionaryRepresentation pool:(NSMutableDictionary*) pool
{
    id reconstructedValue;
    
    NSString *modelId = [dictionaryRepresentation objectForKey:self.modelIdField];
    NSString *className = [dictionaryRepresentation objectForKey:self.classNameField];
    Class class = NSClassFromString(className);
    
    // Lookup pool.
    BOOL alreadyReconstructed = [[pool allKeys] containsObject:modelId];
    if (alreadyReconstructed)
    {
        // Select object from pool.
        reconstructedValue = [pool objectForKey:modelId];
    }
    else
    {
        // Create new instance.
        reconstructedValue = [class new];
        
        // Reconstruct.
        [reconstructedValue _initializeWithDictionary:dictionaryRepresentation pool:pool];
        
        // Track that model is being represented.
        // [pool setObject:reconstructedValue forKey:modelId];
    }
    
    return reconstructedValue;
}

-(id)reconstructCollection:(id) collection model:(id) model field:(NSString*) field pool:(NSMutableDictionary*) pool
{
    return [Collections processCollection:collection processingBlock:^id(NSString *eachCollectionKey, NSObject *eachRepresentedCollectionValue)
    {
        // Look into dictionaries for `<EPPZModel>` representations.
        if ([self isValueRepresentedEPPZModel:eachRepresentedCollectionValue])
        { return [self reconstructEPPZModel:eachRepresentedCollectionValue pool:pool]; }
        
        // Reconstruct a single value.
        return [self reconstructSingleValue:eachRepresentedCollectionValue
                                      model:model
                                      field:field
                                       pool:pool];
    }];
}

-(id)reconstructSingleValue:(id) value model:(id) model field:(NSString*) field pool:(NSMutableDictionary*) pool
{
    // If is a collection.
    if ([Collections isCollection:value])
    { return [self reconstructCollection:value model:model field:field pool:pool]; }
    
    // Get value mapper (for field, then for type prefix as a fallback).
    EPPZValueMapper *valueMapper = [self valueMapperForField:field];
    if (valueMapper == self.defaultValueMapper)
    {
        NSString *typeName = [EPPZValueMapper typeNameOfRepresentation:value];
        if (typeName != nil) valueMapper = [self valueMapperForTypeName:typeName];
    }
    
    // Check for null.
    if ([self isValueNilRepresentation:value])
    { valueMapper = self.nilValueMapper; }
     
    // Return reconstruction or the value itself if no any mapper.
    return (valueMapper != nil) ? [valueMapper reconstructValue:value] : value;
}

-(BOOL)isValueNilRepresentation:(id) value
{
    if ([value isKindOfClass:[NSString class]] == NO) return NO;
    if ([value isEqualToString:self.nilValueMapper.representerBlock(nil)] == NO) return NO;
    return YES;
}

-(void)_configureModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary pool:(NSMutableDictionary*) pool
{
    #warning Implement configuring!
}

-(void)tryToSetValue:(id) value forKey:(NSString*) key onModel:(NSObject*) model
{
    @try { [model setValue:value forKeyPath:key]; }
    @catch (NSException *exception)
    {
        // Raise warnings beside model attribute exceptions (as they probably exist only in representations).
        if ([key isEqualToString:self.modelIdField] || [key isEqualToString:self.classNameField]) return;
        WARNING_AND_VOID(@"Can't set field `%@` on <%@> to reconstruct.", key, model.className);
    }
    @finally {}
}


@end
