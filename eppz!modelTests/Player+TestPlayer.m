//
//  Player+TestPlayer.m
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

#import "Player+TestPlayer.h"


#define VIEW_WITH_SIZE(...) [[UIView alloc] initWithFrame:(CGRect){CGPointZero, __VA_ARGS__}]


@implementation Player (TestPlayer)


#pragma mark - Defaults for test

+(instancetype)testPlayer
{
    // Player.
    Player *player = [Player new];
    player.UUID = @"1";
    player.name = @"Bruce";
    player.email = @"bruce@wayne.com";
    player.creationDate = [NSDate dateWithTimeIntervalSince1970:1];
    player.key = [@"wayne" dataUsingEncoding:NSUTF8StringEncoding];
    
    player.size = (CGSize){ 10.0, 10.0 };
    player.mainView = VIEW_WITH_SIZE(40.0, 40.0);
    player.subViews = @[ VIEW_WITH_SIZE(50.0, 50.0), VIEW_WITH_SIZE(60.0, 60.0), VIEW_WITH_SIZE(70.0, 70.0) ];
    
        // Invitee.
        Player *invitee = [Player new];
        invitee.UUID = @"2";
        invitee.name = @"Alfred";
        invitee.email = @"alfred@wayne.com";
        invitee.creationDate = [NSDate dateWithTimeIntervalSince1970:2];
        invitee.key = [@"pennyworth" dataUsingEncoding:NSUTF8StringEncoding];
    
        invitee.size = (CGSize){ 5.0, 5.0 };
        invitee.mainView = VIEW_WITH_SIZE(20.0, 20.0);
        invitee.subViews = @[ VIEW_WITH_SIZE(25.0, 25.0), VIEW_WITH_SIZE(30.0, 30.0), VIEW_WITH_SIZE(35.0, 35.0) ];
    
        // Add.
        player.invitees = @[ invitee ];
    
    // Game progress 1 for `self.player`.
    GameProgress *gameProgress_1 = [GameProgress new];
    gameProgress_1.player = player;
    player.gameProgress = gameProgress_1;
    
        // Achivements.
        Achivement *achivement_1 = [Achivement new];
        achivement_1.name = @"Created!";
        achivement_1.description = @"Gained when player is allocated in memory.";
        achivement_1.value = 10.0;
        
        Achivement *achivement_2 = [Achivement new];
        achivement_2.name = @"Social!";
        achivement_2.description = @"Gained when player invites a friend.";
        achivement_2.value = 20.0;
    
        // Add.
        gameProgress_1.achivements = @[ achivement_1, achivement_2 ];
    
        // Game progess 2 for `invitee`.
        GameProgress *gameProgress_2 = [GameProgress new];
        gameProgress_2.player = invitee;
        invitee.gameProgress = gameProgress_2;
        
            // Achivements.
            Achivement *achivement_3 = [Achivement new];
            achivement_3.name = @"Guest!";
            achivement_3.description = @"Gained when player has accepted an invitation.";
            achivement_3.value = 20.0;
    
        // Add.
        gameProgress_2.achivements = @[ achivement_1, achivement_3 ];
    
    // Achivement references.
    achivement_1.players = @[ player, invitee ];
    achivement_2.players = @[ player ];
    achivement_3.players = @[ invitee ];
    
    return player;
}


@end
