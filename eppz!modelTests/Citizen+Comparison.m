//
//  Citizen+Comparison.m
//  eppz!model
//
//  Created by Borbás Geri on 13/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
