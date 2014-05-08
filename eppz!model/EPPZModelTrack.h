//
//  EPPZValueReference.h
//  eppz!model
//
//  Created by Gardrobe on 09/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPPZModelTrack : NSObject


/*! Actual model to be tracked. */
@property (nonatomic, weak) NSObject *model;

/*! Owner that holds the reference to the model to be tracked */
@property (nonatomic, weak) NSObject *owner;

/*! The field in which owner references the model. */
@property (nonatomic, strong) NSString *field;

/*! Replace the model (so in the owner) with a new instance. */
-(void)replaceModel:(NSObject*) model;


#pragma mark - Creation

/*! Create a track for the given model in the given owner. */
+(instancetype)track:(NSObject*) model owner:(NSObject*) owner field:(NSString*) field;


@end
