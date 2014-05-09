//
//  EPPZValueReference.m
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZModelTrack.h"
#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel_mapping.h"
#import "EPPZCollectionEnumerator.h"


typedef enum
{
    EPPZModelTrackTypeDefault,
    EPPZModelTrackTypeField,
    EPPZModelTrackTypeCollection
} EPPZModelTrackType;


@interface EPPZModelTrack ()

@property (nonatomic) EPPZModelTrackType type;
@property (nonatomic, weak) NSObject *owner;
@property (nonatomic, strong) NSString *field;

@end



@implementation EPPZModelTrack


#pragma mark - Creation

+(instancetype)trackModel:(NSObject*) model
{
    EPPZModelTrack *instance = [self new];
    instance.model = model;
    instance.type = EPPZModelTrackTypeDefault;
    return instance;
}

+(instancetype)trackModel:(NSObject*) model
                    owner:(NSObject*) owner
                    field:(NSString*) field
{
    EPPZModelTrack *instance = [self new];
    instance.model = model;
    instance.owner = owner;
    instance.field = field;
    instance.type = EPPZModelTrackTypeField;
    return instance;
}

+(instancetype)trackModelInCollection:(NSObject*) model
                                owner:(NSObject*) owner
                                field:(NSString*) field
{
    EPPZModelTrack *instance = [self new];
    instance.model = model;
    instance.owner = owner;
    instance.field = field;
    instance.type = EPPZModelTrackTypeCollection;
    return instance;
}


#pragma mark - Replace model

-(void)replaceModel
{
    // Only if we have replacement.
    if (self.replacementModel == nil) return;
    
    // Set in owner's defined field.
    if (self.type == EPPZModelTrackTypeField)
    { [self.owner setValue:self.replacementModel forKeyPath:self.field]; }
    
    // Set in owner's defined collection in field.
    if (self.type == EPPZModelTrackTypeCollection)
    {
        #warning Add @try!
        [self.owner setValue:[self collectionByReplaceModel:self.replacementModel
                                               inCollection:[self.owner valueForKey:self.field]]
                forKeyPath:self.field];
    }
}

-(id)collectionByReplaceModel:(NSObject*) replacementModel
                 inCollection:(id) collection
{
    return [Collections processCollection:collection processingBlock:^id(NSUInteger eachIndex, NSString *eachKey, NSObject *eachValue)
    {
        // Return model to replace with.
        if ([eachValue.modelId isEqualToString:replacementModel.modelId])
        { return replacementModel; }
        
        // Else return original value.
        return eachValue;
    }];
}

#pragma mark - Debug

-(NSString*)description
{ return [NSString stringWithFormat:@"<EPPZModelTrack> <%@> (%@).%@ %@ = <%@> (%@)",
          self.owner.className,
          self.owner.modelId,
          self.field,
          (self.type == EPPZModelTrackTypeCollection) ? @"(collection)" : @"",
          self.model.className,
          self.model.modelId]; }


@end
