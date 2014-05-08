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
#import "Player+TestPlayer.h"


#pragma mark - Test case


@interface DictionaryRepresentationTests : XCTestCase
@property (nonatomic, strong) Player *player;
@property (nonatomic, weak) Player *invitee;
@end


@implementation DictionaryRepresentationTests


-(void)setUp
{
    [super setUp];
    self.player = [Player testPlayer];
    self.invitee = self.player.invitees[0];
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
    // Make sure that representing model attributes for classes is turned on.
    [Player mapper].representModelAttributes = YES;
    [GameProgress mapper].representModelAttributes = YES;
    [Achivement mapper].representModelAttributes = YES;
    
    // Make sure that representing references is turned off.
    [Player mapper].representReferences = NO;
    
    // Set timezone to `UTC+0`.
    [Player mapper].timeZone = @"UTC";
    
    // File logging.
    BOOL log = NO;
    if (log)
    {
        NSString *libraryFolder = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        [Player mapper].writeRepresentationLog = YES;
        [GameProgress mapper].writeRepresentationLog = YES;
        [Achivement mapper].writeRepresentationLog = YES;
        [Player mapper].logFileDirectory = libraryFolder;
        [GameProgress mapper].logFileDirectory = libraryFolder;
        [Achivement mapper].logFileDirectory = libraryFolder;
    }
    
    // Job.
    NSDictionary *dictionary = self.player.dictionaryRepresentation;
    NSDictionary *assertation = @{
                                  
                                  // Model attributes.
                                  @"_id" : self.player.modelId, // `modelId` created from runtime hash by default (changes on every test)
                                  @"_type" : @"Player",
                                  
                                  // Arbitrary values, no value mapping.
                                  @"UUID" : @(1),
                                  @"name" : @"Bruce",
                                  @"email" : @"bruce@wayne.com",
                                  @"creationDate" : @"NSDate:1970-01-01 00:00:01 +0000",
                                  @"key" : @"NSData:d2F5bmU=",
                                  
                                  // `CGRect` value represented with default value mapping for type.
                                  @"size" : @"CGSize:{10, 10}",
                                  
                                  // `UIView` objects conforming `<EPPZModel>` with custom field mapping (representing only `frame`).
                                  @"mainView" : @{
                                          @"_id" : self.player.mainView.modelId,
                                          @"_type" : @"UIView",
                                          @"frame" : @"CGRect:{{0, 0}, {40, 40}}"
                                          },
                                  
                                  // `NSArray` collection with `<EPPZModel>` conforming objects within (same as `UIView` above).
                                  @"subViews" : @[
                                          @{
                                              @"_id" : [self.player.subViews[0] modelId],
                                              @"_type" : @"UIView",
                                              @"frame" : @"CGRect:{{0, 0}, {50, 50}}"
                                              },
                                          @{
                                              @"_id" : [self.player.subViews[1] modelId],
                                              @"_type" : @"UIView",
                                              @"frame" : @"CGRect:{{0, 0}, {60, 60}}"
                                              },
                                          @{
                                              @"_id" : [self.player.subViews[2] modelId],
                                              @"_type" : @"UIView",
                                              @"frame" : @"CGRect:{{0, 0}, {70, 70}}"
                                              }
                                          ],
                                  
                                  // `NSArray` collection with `<EPPZModel>` conforming objects within (same as the `Player` represented).
                                  @"invitees" : @[
                                          @{
                                              @"_id" : self.invitee.modelId,
                                              @"_type" : @"Player",
                                              @"UUID" : @(2),
                                              @"name" : @"Alfred",
                                              @"email" : @"alfred@wayne.com",
                                              @"creationDate" : @"NSDate:1970-01-01 00:00:02 +0000",
                                              @"key" : @"NSData:cGVubnl3b3J0aA==",
                                              @"size" : @"CGSize:{5, 5}",
                                              @"mainView" : @{
                                                      @"_id" : self.invitee.mainView.modelId,
                                                      @"_type" : @"UIView",
                                                      @"frame" : @"CGRect:{{0, 0}, {20, 20}}"
                                                      },
                                              @"subViews" : @[
                                                      @{
                                                          @"_id" : [self.invitee.subViews[0] modelId],
                                                          @"_type" : @"UIView",
                                                          @"frame" : @"CGRect:{{0, 0}, {25, 25}}"
                                                          },
                                                      @{
                                                          @"_id" : [self.invitee.subViews[1] modelId],
                                                          @"_type" : @"UIView",
                                                          @"frame" : @"CGRect:{{0, 0}, {30, 30}}"
                                                          },
                                                      @{
                                                          @"_id" : [self.invitee.subViews[2] modelId],
                                                          @"_type" : @"UIView",
                                                          @"frame" : @"CGRect:{{0, 0}, {35, 35}}"
                                                          }
                                                      ],
                                              
                                              // `nil` value represented with default value mapping for type.
                                              @"invitees" : @"<null>",
                                              
                                              // Property holding `<EPPZModel> conforming object (`GameProgress`).
                                              @"gameProgress" : @{
                                                      @"_id" : self.invitee.gameProgress.modelId,
                                                      @"_type" : @"GameProgress",

                                                      // Referenced object has only model attributes.
                                                      @"player" : @{
                                                              @"_id" : self.invitee.modelId,
                                                              @"_type" : @"Player",
                                                              },
                                                      
                                                      // `NSArray` collection with `<EPPZModel>` conforming objects within (`Achivement`).
                                                      @"achivements" : @[
                                                              @{
                                                                  @"_id" : [self.invitee.gameProgress.achivements[0] modelId],
                                                                  @"_type" : @"Achivement",
                                                                  @"players" : @[
                                                                          @{
                                                                              @"_id" : self.player.modelId,
                                                                              @"_type" : @"Player"
                                                                              },
                                                                          @{
                                                                              @"_id" : self.invitee.modelId,
                                                                              @"_type" : @"Player"
                                                                              }
                                                                          ],
                                                                  @"name" : @"Created!",
                                                                  @"definition" : @"Gained when player is allocated in memory.",
                                                                  @"value" : @(10)
                                                                  },
                                                              @{
                                                                  @"_id" : [self.invitee.gameProgress.achivements[1] modelId],
                                                                  @"_type" : @"Achivement",
                                                                  @"players" : @[
                                                                          @{
                                                                              @"_id" : self.invitee.modelId,
                                                                              @"_type" : @"Player"
                                                                              }
                                                                          ],
                                                                  @"name" : @"Guest!",
                                                                  @"definition" : @"Gained when player has accepted an invitation.",
                                                                  @"value" : @(20)
                                                                  }
                                                              ]
                                                      }
                                              }
                                          ],
                                  @"gameProgress" : @{
                                          @"_id" : self.player.gameProgress.modelId,
                                          @"_type" : @"GameProgress",
                                          @"player" : @{
                                                  @"_id" : self.player.modelId,
                                                  @"_type" : @"Player",
                                                  },
                                          
                                          // `NSArray` collection with `<EPPZModel>` conforming objects within (`Achivement`).
                                          @"achivements" : @[
                                                  @{
                                                      @"_id" : [self.player.gameProgress.achivements[0] modelId],
                                                      @"_type" : @"Achivement"
                                                      },
                                                  @{
                                                      @"_id" : [self.player.gameProgress.achivements[1] modelId],
                                                      @"_type" : @"Achivement",
                                                      @"players" : @[
                                                              @{
                                                                  @"_id" : self.player.modelId,
                                                                  @"_type" : @"Player"
                                                                  }
                                                              ],
                                                      @"name" : @"Social!",
                                                      @"definition" : @"Gained when player invites a friend.",
                                                      @"value" : @(20)
                                                      }
                                                  ]
                                          }
                                  };
    
    if (log)
    {
        [Player mapper].writeRepresentationLog = NO;
        [GameProgress mapper].writeRepresentationLog = NO;
        [Achivement mapper].writeRepresentationLog = NO;
    }
    
    XCTAssertEqualObjects(dictionary.description,
                          assertation.description,
                          @"Dictionary representation should be equal to asserted dictionary.");
}

-(void)testFieldMapper
{
    // Set custom field mapper for class.
    [Player mapper].fieldMapper =
    [EPPZFieldMapper map:@{
                           @"UUID" : @"player_uuid",
                           @"name" : @"player_name",
                           @"email" : @"player_email"
                           }];
    
    // Turn of representing model attributes for `Player`.
    [Player mapper].representModelAttributes = NO;
    
    NSDictionary *dictionary = self.player.dictionaryRepresentation;
    NSDictionary *assertation = @{
                                  @"player_uuid" : @"1",
                                  @"player_name" : @"Bruce",
                                  @"player_email" : @"bruce@wayne.com"
                                  };
    
    XCTAssertEqualObjects(dictionary,
                          assertation,
                          @"Dictionary representation should be equal to asserted dictionary.");
    
    // Switch back to default mapper.
    [Player mapper].fieldMapper = [EPPZFieldMapper new];
}

-(void)testDictionaryRepresentationOfFields
{
    // Turn of representing model attributes for `Player`.
    [Player mapper].representModelAttributes = NO;
    
    NSDictionary *dictionary = [self.player
                                dictionaryRepresentationOfFields:@[
                                                                   @"name",
                                                                   @"email"
                                                                   ]];
    NSDictionary *assertation = @{
                                  @"name" : @"Bruce",
                                  @"email" : @"bruce@wayne.com",
                                  };
    
    XCTAssertEqualObjects(dictionary.description,
                          assertation.description,
                          @"Dictionary representation should be equal to asserted dictionary.");
}

-(void)testDictionaryRepresentationOfFieldsWithSubFields_1
{
    // Turn of representing model attributes for `Player`.
    [Player mapper].representModelAttributes = NO;
    
    NSDictionary *dictionary = [self.player
                                dictionaryRepresentationOfFields:@{
                                                                   field(@"name"),
                                                                   field(@"email"),
                                                                   @"invitees" : @{
                                                                           field(@"name"),
                                                                           field(@"email")
                                                                           }
                                                                   }];
    NSDictionary *assertation = @{
                                  @"name" : @"Bruce",
                                  @"email" : @"bruce@wayne.com",
                                  @"invitees" : @[
                                          @{
                                              @"name" : @"Alfred",
                                              @"email" : @"alfred@wayne.com",
                                              }
                                          ]
                                  };
    
    XCTAssertEqualObjects(dictionary.description,
                          assertation.description,
                          @"Dictionary representation should be equal to asserted dictionary.");
}

-(void)testDictionaryRepresentationOfFieldsWithSubFields_2
{
    // Turn of representing model attributes for every class.
    [Player mapper].representModelAttributes = NO;
    [GameProgress mapper].representModelAttributes = NO;
    [Achivement mapper].representModelAttributes = NO;
    
    // Turn on representing references (as it is safe when there are no circular references among fields).
    [Player mapper].representReferences = YES;
    
    NSDictionary *dictionary = [self.player
                                dictionaryRepresentationOfFields:@{
                                                                   field(@"name"),
                                                                   field(@"email"),
                                                                   @"gameProgress" : @{
                                                                           @"achivements" : @{
                                                                                   field(@"name")
                                                                                   }
                                                                           },
                                                                   @"invitees" : @{
                                                                           field(@"name"),
                                                                           field(@"email"),
                                                                           @"gameProgress" : @{
                                                                                   @"achivements" : @{
                                                                                           field(@"name")
                                                                                           }
                                                                                   }
                                                                           }
                                                                   }];
    NSDictionary *assertation = @{
                                  @"name" : @"Bruce",
                                  @"email" : @"bruce@wayne.com",
                                  @"gameProgress" : @{
                                          @"achivements" : @[
                                                  @{
                                                      @"name" : @"Created!",
                                                      },
                                                  @{
                                                      @"name" : @"Social!",
                                                      }
                                                  ]
                                          },
                                  @"invitees" : @[
                                          @{
                                              @"name" : @"Alfred",
                                              @"email" : @"alfred@wayne.com",
                                              @"gameProgress" : @{
                                                      @"achivements" : @[
                                                              @{
                                                                  @"name" : @"Created!",
                                                                  },
                                                              @{
                                                                  @"name" : @"Guest!",
                                                                  }
                                                              ]
                                                      }
                                              }
                                          ]
                                  };
    
    XCTAssertEqualObjects(dictionary.description,
                          assertation.description,
                          @"Dictionary representation should be equal to asserted dictionary.");
}
                                

@end

