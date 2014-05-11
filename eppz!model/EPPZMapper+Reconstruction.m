//
//  EPPZMapper+Reconstruction.m
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

#import "EPPZMapper+Reconstruction.h"
#import "EPPZMapper+Debug.h"
#import "EPPZMapper+Accessors.h"

#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel_mapping.h"
#import "NSObject+EPPZModel_mapping_internal.h"


@implementation EPPZMapper (Reconstruction)


#pragma mark - Reconstruction

-(void)_initializeModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary tracker:(EPPZTracker*) tracker
{
    // Track that model is being represented.
    NSString *modelId = [self modelIdInDictionaryRepresentationIfAny:dictionary];
    
    // Overwrite `modelId` with the one stored in representation.
    model.modelId = modelId;
    
    // Track.
    [tracker trackModel:model
             forModelId:modelId];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *eachField, id eachRepresentedValue, BOOL *stop)
     {
         // Map `field`.
         NSString *eachReconstructedField = [self.fieldMapper runtimeFieldForField:eachField];
         
         id eachValue;
         
         // Reconstruct `<EPPZModel>` representations.
         if ([self isValueRepresentedEPPZModel:eachRepresentedValue])
         { eachValue = [self reconstructEPPZModel:eachRepresentedValue tracker:tracker]; }
         
         // Reconstruct an arbitrary value.
         else
         {
             eachValue = [self reconstructSingleValue:eachRepresentedValue
                                                model:model
                                                field:eachReconstructedField
                                              tracker:tracker];
         }
         
         // Set.
         [self tryToSetValue:eachValue forKey:eachReconstructedField onModel:model];
         
         // Track reference if `<EPPZModel>` has set.
         if ([self isValueRepresentedEPPZModel:eachRepresentedValue])
         {
             [tracker trackModel:eachValue
                      forModelId:[(NSObject*)eachValue modelId]
                           owner:model
                           field:eachReconstructedField];
         }
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

-(id)reconstructEPPZModel:(id) dictionaryRepresentation tracker:(EPPZTracker*) tracker
{
    NSObject *reconstructedValue;
    
    // Get model attributes from dictionary representation.
    NSString *modelId = [dictionaryRepresentation objectForKey:self.modelIdField];
    NSString *className = [dictionaryRepresentation objectForKey:self.classNameField];
    Class class = NSClassFromString(className);
    
    // Lookup tracker.
    BOOL notTrackedYet = ([tracker modelForModelId:modelId] == nil);
    BOOL onlyReferenceRepresentation = ([dictionaryRepresentation allKeys].count <= 2);
    
    if (notTrackedYet)
    {
        // Reconstruct instance (get added to tracker inside).
        reconstructedValue = [class _instanceWithDictionary:dictionaryRepresentation tracker:tracker];
    }
    
    else
    {
        if (onlyReferenceRepresentation)
        {
            // Get instance from tracker (either main, or partial reconstruction).
            reconstructedValue = [tracker modelForModelId:modelId];
        }
        
        else // Probably the main representation
        {
            // Reconstruct main instance, replace in tracker.
            reconstructedValue = [class _instanceWithDictionary:dictionaryRepresentation tracker:tracker];
            
            // Set main representation as replacement model.
            [tracker setMasterModel:reconstructedValue forModelId:modelId];
        }
    }
    
    return reconstructedValue;
}

-(id)reconstructCollection:(id) collection model:(id) model field:(NSString*) field tracker:(EPPZTracker*) tracker
{
    return [Collections processCollection:collection processingBlock:^id(NSUInteger eachCollectionIndex, NSString *eachCollectionKey, NSObject *eachRepresentedCollectionValue)
            {
                // Look into dictionaries for `<EPPZModel>` representations.
                if ([self isValueRepresentedEPPZModel:eachRepresentedCollectionValue])
                {
                    NSObject *eachCollectionValue = [self reconstructEPPZModel:eachRepresentedCollectionValue tracker:tracker];
                    
                    
                    
                    // Track model (in collection).
                    [tracker trackModelInCollection:eachCollectionValue
                                         forModelId:eachCollectionValue.modelId
                                              owner:model
                                              field:field];
                    
                    return eachCollectionValue;
                }
                
                // Reconstruct a single value.
                return [self reconstructSingleValue:eachRepresentedCollectionValue
                                              model:model
                                              field:field
                                            tracker:tracker];
            }];
}

-(id)reconstructSingleValue:(id) value model:(id) model field:(NSString*) field tracker:(EPPZTracker*) tracker
{
    // If is a collection.
    if ([Collections isCollection:value])
    { return [self reconstructCollection:value model:model field:field tracker:tracker]; }
    
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

-(void)tryToSetValue:(id) value forKey:(NSString*) key onModel:(NSObject*) model
{
    @try { [model setValue:value forKeyPath:key]; }
    @catch (NSException *exception)
    {
        // Raise warnings beside model attribute exceptions (as they probably exist only in representations).
        if ([key isEqualToString:self.modelIdField] || [key isEqualToString:self.classNameField]) return;
        WARNING_AND_VOID(@"Can't set field `%@` on <%@> to reconstruct.", key, model.className);
    }
    @finally { }
}



@end
