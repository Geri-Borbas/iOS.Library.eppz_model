//
//  EPPZTracker.m
//  eppz!model
//
//  Created by Borbás Geri on 01/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZTracker.h"
#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel.h"


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
