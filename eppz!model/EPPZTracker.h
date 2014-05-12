//
//  EPPZTracker.h
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
-(void)setMasterModel:(NSObject*) masterModel
           forModelId:(NSString*) modelId;

/*! In the end. */
-(void)replaceMasterModels;


@end
