//
//  Player+Comparison.m
//  eppz!model
//
//  Created by Borbás Geri on 05/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "Player+Comparison.h"


@implementation Player (Comparison)


-(BOOL)isEqual:(Player*) another
{
    return (
            [self isKindOfClass:another.class] &&
            [self.UUID isEqualToString:another.UUID] &&
            [self.name isEqualToString:another.name] &&
            [self.email isEqualToString:another.email] &&
            CGSizeEqualToSize(self.size, another.size) &&
            [self.mainView isEqual:another.mainView] &&
            [self.subViews isEqualToArray:another.subViews] &&
            [Player playerArray:self.invitees isEqualToArray:another.invitees] &&
            [self.gameProgress isEqual:another.gameProgress]
            );
}

+(BOOL)playerArray:(NSArray*) players isEqualToArray:(NSArray*) anotherPlayers
{
    __block BOOL isEqual = YES;
    [players enumerateObjectsUsingBlock:^(Player *eachPlayer, NSUInteger index, BOOL *stop)
    {
        Player *anotherPlayer = (anotherPlayers.count > index) ? anotherPlayers[index] : nil;
        BOOL playersAreEqual = [eachPlayer.name isEqualToString:anotherPlayer.name];
        if (playersAreEqual == NO)
        {
            isEqual = NO;
            *stop = YES;
        }   
    }];
    return isEqual;
}


@end
