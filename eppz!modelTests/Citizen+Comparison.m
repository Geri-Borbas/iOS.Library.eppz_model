//
//  Citizen+Comparison.m
//  eppz!model
//
//  Created by Gardrobe on 13/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "Citizen+Comparison.h"


@implementation Citizen (Comparison)


-(BOOL)isEqual:(Citizen*) another
{
    // Test references.
    __block BOOL cityReferencesTest = YES;
    __block BOOL houseReferencesTest = YES;
    [self.neighbours enumerateObjectsUsingBlock:^(Citizen *eachNeighbour, NSUInteger index, BOOL *stop) {
        if (self.city != eachNeighbour.city) cityReferencesTest = NO;
        if (self.house != eachNeighbour.house) houseReferencesTest = NO;
    }];
    
    __block BOOL neighbourNamesAreEqual;
    [self.neighbours enumerateObjectsUsingBlock:^(Citizen *eachNeighbour, NSUInteger index, BOOL *stop)
    {
        Citizen *eachOtherNeighbour;
        if (another.neighbours.count > index)
        { eachOtherNeighbour = another.neighbours[index]; }
        
        if ([eachNeighbour.name isEqualToString:eachOtherNeighbour.name] == NO) neighbourNamesAreEqual = NO;
    }];
    
    return (
            [self isKindOfClass:another.class] &&
            [self.name isEqualToString:another.name] &&
            cityReferencesTest &&
            houseReferencesTest &&
            neighbourNamesAreEqual
            );
}


@end
