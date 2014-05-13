//
//  City+Comparison.m
//  eppz!model
//
//  Created by Gardrobe on 13/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "City+Comparison.h"


@implementation City (Comparison)


-(BOOL)isEqual:(City*) another
{
    return (
            [self isKindOfClass:another.class] &&
            [self.houses isEqualToArray:another.houses]
            );
}


@end
