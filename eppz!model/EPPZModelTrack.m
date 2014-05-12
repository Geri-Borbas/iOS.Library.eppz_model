//
//  EPPZValueReference.m
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

#import "EPPZModelTrack.h"
#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel.h"
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

-(void)replaceModelWithMasterModel:(NSObject*) masterModel
{
    // Only if we have replacement.
    if (masterModel == nil) return;
    
    // Set in owner's defined field.
    if (self.type == EPPZModelTrackTypeField)
    { [self.owner setValue:masterModel forKeyPath:self.field]; }
    
    // Set in owner's defined collection in field.
    if (self.type == EPPZModelTrackTypeCollection)
    {
        [self.owner setValue:[self collectionByReplaceModel:masterModel
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


@end
