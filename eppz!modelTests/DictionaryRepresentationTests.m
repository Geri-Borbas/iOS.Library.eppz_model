//
//  DictionaryRepresentationTests.m
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


#define _null_ [NSNull null]


#pragma mark - Test case


@interface DictionaryRepresentationTests : XCTestCase
@property (nonatomic, strong) Player *player;
@end


@implementation DictionaryRepresentationTests


-(void)setUp
{
    [super setUp];
    
    // Model.
    self.player = [Player instance];
    self.player.UUID = @"42";
    self.player.name = @"Bruce";
    self.player.email = @"bruce.wayne@wayne.com";
}

-(void)testSetMapper
{
    EPPZMapper *onePlayerMapper = [EPPZMapper new];
    [Player setMapper:onePlayerMapper];
    
    XCTAssertEqual(Player.mapper,
                   onePlayerMapper,
                   @"Mapper should be set on class.");
    
    EPPZMapper *otherPlayerMapper = [EPPZMapper new];
    [Player setMapper:otherPlayerMapper];
    
    XCTAssertEqual(Player.mapper,
                   otherPlayerMapper,
                   @"Mapper should be set on class.");
    
    EPPZMapper *oneGameProgressMapper = [EPPZMapper new];
    [GameProgress setMapper:oneGameProgressMapper];
    
    XCTAssertEqual(GameProgress.mapper,
                   oneGameProgressMapper,
                   @"Mapper should be set on class.");
    
    EPPZMapper *otherGameProgressMapper = [EPPZMapper new];
    [GameProgress setMapper:otherGameProgressMapper];
    
    XCTAssertEqual(GameProgress.mapper,
                   otherGameProgressMapper,
                   @"Mapper should be set on class.");
}

-(void)testDefaultMapper
{
    // Assert.
    NSDictionary *dictionary = self.player.dictionaryRepresentation;
    NSDictionary *assertation = @{
                                  
                                  @"UUID" : @"42",
                                  @"name" : @"Bruce",
                                  @"email" : @"bruce.wayne@wayne.com",
                                  
                                  @"size" : @"CGSize:{0, 0}",
                                  @"color" : @"<null>",
                                  
                                  @"friends" : @"<null>",
                                  @"gameProgress" : @"<null>",
                                  
                                  };
    
    XCTAssertEqualObjects(dictionary,
                          assertation,
                          @"Dictionary representation should be equal to asserted dictionary.");
}

-(void)testFieldMapper
{
    // Set custom field mapper for class.
    [Player mapper].fieldMapper =
    [EPPZFieldMapper map:@{
                           
                           @"UUID" : @"player_uuid",
                           @"name" : @"player_name",
                           @"email" : @"player_email",
                           
                           @"friends" : @"player_friends",
                           @"gameProgress" : @"player_game_progress"
                           
                           }];
    
    // Assert.
    NSDictionary *dictionary = self.player.dictionaryRepresentation;
    NSDictionary *assertation = @{
                                  
                                  @"player_uuid" : @"42",
                                  @"player_name" : @"Bruce",
                                  @"player_email" : @"bruce.wayne@wayne.com",
                                  @"player_friends" : @"<null>",
                                  @"player_game_progress" : @"<null>",
                                  
                                  };
    
    XCTAssertEqualObjects(dictionary,
                          assertation,
                          @"Dictionary representation should be equal to asserted dictionary.");
    
    // Switch back to default mapper.
    [Player mapper].fieldMapper = [EPPZFieldMapper new];
}

-(void)testDictionaryRepresentationOfFields
{
    NSDictionary *dictionary = [self.player
                                dictionaryRepresentationOfFields:@[
                                                                   @"name",
                                                                   @"email"
                                                                   ]];
}

-(void)testDictionaryRepresentationOfFieldsWithSubFields
{
    NSDictionary *dictionary = [self.player
                                dictionaryRepresentationOfFields:@{
                                                                   field(@"name"),
                                                                   field(@"email"),
                                                                   @"firends" : @{
                                                                           field(@"email"),
                                                                           field(@"email")
                                                                           }
                                                                   }];
}
                                

@end

