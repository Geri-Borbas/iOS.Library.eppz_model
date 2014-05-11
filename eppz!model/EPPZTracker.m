//
//  EPPZTracker.m
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZTracker.h"
#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel_mapping.h"


@interface EPPZTracker ()
@property (nonatomic, strong) NSMutableDictionary *modelTracksForModelIds;
@property (nonatomic, strong) NSMutableDictionary *masterModelsForModelIds;
@end



@implementation EPPZTracker


#pragma mark - Creation

-(instancetype)init
{
    if (self = [super init])
    {
        self.modelTracksForModelIds = [NSMutableDictionary new];
        self.masterModelsForModelIds = [NSMutableDictionary new];
    }
    return self;
}


#pragma mark - Tracks accessors

-(BOOL)hasModelTrackedForModelId:(NSString*) modelId
{ return [[self.modelTracksForModelIds allKeys] containsObject:modelId]; }

-(NSMutableArray*)modelTracksForModelId:(NSString*) modelId
{
    if ([self hasModelTrackedForModelId:modelId] == NO)
    { [self.modelTracksForModelIds setObject:[NSMutableArray new] forKey:modelId]; };

    return [self.modelTracksForModelIds objectForKey:modelId];
}

-(void)addTrack:(EPPZModelTrack*) track forModelId:(NSString*) modelId
{
    NSMutableArray *tracks = [self modelTracksForModelId:track.model.modelId];
    [tracks addObject:track];
}


#pragma mark - Tracking

-(void)trackModel:(NSObject*) model
       forModelId:(NSString*) modelId
{ [self addTrack:[EPPZModelTrack trackModel:model] forModelId:modelId]; }

-(void)trackModel:(NSObject*) model
       forModelId:(NSString*) modelId
            owner:(NSObject*) owner
            field:(NSString*) field
{ [self addTrack:[EPPZModelTrack trackModel:model owner:owner field:field] forModelId:modelId]; }

-(void)trackModelInCollection:(NSObject*) model
                   forModelId:(NSString*) modelId
                        owner:(NSObject*) owner
                        field:(NSString*) field
{ [self addTrack:[EPPZModelTrack trackModelInCollection:model owner:owner field:field] forModelId:modelId]; }

-(NSObject*)modelForModelId:(NSString*) modelId
{
    // Return model of first track.
    EPPZModelTrack *track = [self modelTracksForModelId:modelId].firstObject;
    return track.model;
}

-(void)setMasterModel:(NSObject*) masterModel forModelId:(NSString*) modelId
{
    // Checks.
    if (masterModel == nil) return;
    if (modelId == nil) return;
    
    [self.masterModelsForModelIds setObject:masterModel forKey:modelId];
}

-(void)replaceMasterModels
{
    [self.masterModelsForModelIds enumerateKeysAndObjectsUsingBlock:^(NSString *eachModelId, NSObject *eachMasterModel, BOOL *stop)
    {
        
        NSMutableArray *eachModelTracks = [self modelTracksForModelId:eachModelId];
        [eachModelTracks enumerateObjectsUsingBlock:^(EPPZModelTrack *eachModelTrack, NSUInteger index, BOOL *stop)
        { [eachModelTrack replaceModelWithMasterModel:eachMasterModel]; }];
    }];
}


@end
