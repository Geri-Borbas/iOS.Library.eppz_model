//
//  GameProgress.h
//  eppz!model
//
//  Created by Gardrobe on 02/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPPZModel.h"


@class Player;


@interface GameProgress : NSObject

    <EPPZModel>


@property (nonatomic, weak) Player *player;
@property (nonatomic, strong) NSArray *achivements;


@end
