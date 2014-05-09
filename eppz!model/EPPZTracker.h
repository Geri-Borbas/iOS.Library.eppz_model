//
//  EPPZTracker.h
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPPZModelTrack.h"


@interface EPPZTracker : NSObject


/*! Track that a model is being reconstructed (indexed on @c modelId). */
-(void)trackModel:(NSObject*) model
       forModelId:(NSString*) modelId;

/*! Track that a model has been set as a reference in an owner. */
-(void)trackModel:(NSObject*) model
       forModelId:(NSString*) modelId
            owner:(NSObject*) owner
            field:(NSString*) field;

/*! Track that a model has been set as as a reference in the given owner's collection (either @c NSArray, @c NSDictionary, @c NSSet or @c NSOrderedSet). */
-(void)trackModelInCollection:(NSObject*) model
                   forModelId:(NSString*) modelId
                        owner:(NSObject*) owner
                        field:(NSString*) field;


/*! Returns a model for the given @c modelId if tracked any (return @c nil if not tracked yet). */
-(NSObject*)modelForModelId:(NSString*) modelId;

/*!
 
 Replace tracked model with a new instance. Also replace every reference that
 points to the model so far in the reconstructed object graph.
 
 */
-(void)setReplacementModel:(NSObject*) model forModelId:(NSString*) modelId;

/*! In the end. */
-(void)replaceModels;


@end
