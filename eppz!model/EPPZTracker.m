//
//  EPPZTracker.m
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZTracker.h"


@interface EPPZTracker ()
@property (nonatomic, strong) NSMutableDictionary *modelTracksForModelIds;
@end



@implementation EPPZTracker


#pragma mark - Creation

-(instancetype)init
{
    if (self = [super init])
    { self.modelTracksForModelIds = [NSMutableDictionary new]; }
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
    [[self modelTracksForModelId:modelId] addObject:track];
    NSLog(@"%@", self.modelTracksForModelIds);
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

-(void)replaceModel:(NSObject*) model forModelId:(NSString*) modelId
{
    // Replace model in every track (so in references).
    NSMutableArray *tracks = [self modelTracksForModelId:modelId];
    [tracks enumerateObjectsUsingBlock:^(EPPZModelTrack *eachModelTrack, NSUInteger idx, BOOL *stop)
    { [eachModelTrack replaceModel:model]; }];
}


@end
