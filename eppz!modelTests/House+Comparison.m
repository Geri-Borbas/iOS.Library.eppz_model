//
//  House+Comparison.m
//  eppz!model
//
//  Created by Gardrobe on 13/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "House+Comparison.h"


@implementation House (Comparison)


-(BOOL)isEqual:(House*) another
{
    // Test references.
    __block BOOL cityReferencesTest;
    [self.citizens enumerateObjectsUsingBlock:^(Citizen *eachCitizen, NSUInteger index, BOOL *stop) {
        if (self.city != eachCitizen.city) cityReferencesTest = NO;
    }];
    
    return (
            [self isKindOfClass:another.class] &&
            cityReferencesTest &&
            [self.citizens isEqualToArray:another.citizens]
            );
}


@end
