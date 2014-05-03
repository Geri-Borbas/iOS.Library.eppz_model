//
//  Player.h
//  eppz!model
//
//  Created by Gardrobe on 02/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EPPZModel.h"
#import "GameProgress.h"


@interface Player : NSObject

    <EPPZModel>


@property (nonatomic, strong) NSString *UUID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;

@property (nonatomic) CGSize size;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSArray *friends; // `Players`

@property (nonatomic, strong) GameProgress *gameProgress;


@end
