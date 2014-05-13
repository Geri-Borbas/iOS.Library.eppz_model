//
//  DictionaryReconstructionTests.m
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

#import <XCTest/XCTest.h>

#import "EPPZModel.h"

#import "Player.h"
#import "Player+TestPlayer.h"

#import "Player+Comparison.h"
#import "GameProgress+Comparison.h"
#import "Achivement+Comparison.h"
#import "UIView+Comparison.h"


#pragma mark - Test case


@interface DictionaryReconstructionTests : XCTestCase
@property (nonatomic, strong) Player *player;
@property (nonatomic, weak) Player *invitee;
@end


@implementation DictionaryReconstructionTests


-(void)setUp
{
    [super setUp];
    self.player = [Player testPlayer];
    self.invitee = self.player.invitees[0];
}

-(void)testPlayerComparison
{
    // Create two equal object graph.
    Player *onePlayer = [Player testPlayer];
    Player *anotherPlayer = [Player testPlayer];
    
    XCTAssertEqualObjects(onePlayer,
                          anotherPlayer,
                          @"`Player` comparison should work as expected.");

    // Make some change deep inside.
    [(Achivement*)anotherPlayer.gameProgress.achivements[0] setName:@"Something else!"];

    XCTAssertNotEqualObjects(onePlayer,
                             anotherPlayer,
                             @"`Player` comparison should work as expected.");
    
    // Fix.
    [(Achivement*)anotherPlayer.gameProgress.achivements[0] setName:@"Created!"];
    
    XCTAssertEqualObjects(onePlayer,
                          anotherPlayer,
                          @"`Player` comparison should work as expected.");
}

-(void)testInstanceWithDictionary
{
    // Make sure that representing model attributes for classes is turned on.
    [Player mapper].representModelAttributes = YES;
    [GameProgress mapper].representModelAttributes = YES;
    [Achivement mapper].representModelAttributes = YES;
    
    // Make sure that representing references is turned off.
    [Player mapper].representEveryInstance = NO;
    
    NSDictionary *dictionary = self.player.dictionaryRepresentation;
    Player *player = [Player instanceWithDictionary:dictionary];
    
    BOOL log = YES;
    if (log)
    {
        NSString *libraryFolder = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        [self.player.dictionaryRepresentation.description writeToFile:[libraryFolder stringByAppendingPathComponent:@"self.player.log"] atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
        [player.dictionaryRepresentation.description writeToFile:[libraryFolder stringByAppendingPathComponent:@"player.log"] atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
    
    XCTAssertEqualObjects(self.player,
                          player,
                          @"Original model and represented / reconstructed model should be the same.");
}


@end