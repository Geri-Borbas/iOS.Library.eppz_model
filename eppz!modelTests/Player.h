//
//  Player.h
//  eppz!model
//
//  Created by Gardrobe on 02/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPPZModel.h"
#import "GameProgress.h"


@interface Player : NSObject

    <EPPZModel>


@property (nonatomic, strong) NSString *UUID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) GameProgress *gameProgress;


@end
