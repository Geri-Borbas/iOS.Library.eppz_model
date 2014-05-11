//
//  EPPZValueReference.h
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPPZModelTrack : NSObject


/*! The tracked model. */
@property (nonatomic, weak) NSObject *model;

/*! Replace the tracked reference of the model with @c masterModel. */
-(void)replaceModelWithMasterModel:(NSObject*) masterModel;


#pragma mark - Creation

/*! Create a single track of the model. */
+(instancetype)trackModel:(NSObject*) model;

/*! Create a track for the given model in the given owner. */
+(instancetype)trackModel:(NSObject*) model
                    owner:(NSObject*) owner
                    field:(NSString*) field;

/*! Create a track for the given model in the given owner's collection (either @c NSArray, @c NSDictionary, @c NSSet or @c NSOrderedSet). */
+(instancetype)trackModelInCollection:(NSObject*) model
                                owner:(NSObject*) owner
                                field:(NSString*) field;


@end
