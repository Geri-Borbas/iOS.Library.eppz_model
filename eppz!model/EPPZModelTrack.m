//
//  EPPZValueReference.m
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZModelTrack.h"


@implementation EPPZModelTrack


#pragma mark - Creation

+(instancetype)track:(NSObject*) model owner:(NSObject*) owner field:(NSString*) field
{
    EPPZModelTrack *instance = [self new];
    instance.model = model;
    instance.owner = owner;
    instance.field = field;
    return instance;
}


#pragma mark - Replace model

-(void)replaceModel:(NSObject*) model
{
    // Set model in owner.
    [self.owner setValue:model forKeyPath:self.field];
    
    // So here.
    self.model = model;
}


@end
