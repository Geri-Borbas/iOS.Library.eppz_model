//
//  GitHubUser.m
//  eppz!model
//
//  Created by Borbás Geri on 21/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "GitHubUser.h"


@implementation GitHubUser


+(EPPZMapper*)defaultMapper
{
    EPPZMapper *mapper = [super defaultMapper];
    
    // Skip representing model attributes (do not support object graph reconstruction).
    mapper.representModelAttributes = NO;
    
    // Fields.
    mapper.fieldMapper = [EPPZFieldMapper map:@{
                                                
                                                @"login" : @"login",
                                                @"id" : @"id",
                                                
                                                @"avatarURL" : @"avatar_url",
                                                @"gravatarId" : @"gravatar_id",
                                                @"URL" : @"url",
                                                @"htmlURL" : @"html_url",
                                                @"followersURL" : @"followers_url",
                                                @"subscriptionsURL" : @"subscriptions_url",
                                                @"organizationsURL" : @"organizations_url",
                                                @"reposURL" : @"repos_url",
                                                @"receivedEventsURL" : @"received_events_url",
                                                
                                                @"followingURLTemplate" : @"following_url",
                                                @"gistsURLTemplate" : @"gists_url",
                                                @"starredURLTemplate" : @"starred_url",
                                                @"eventsURLTemplate" : @"events_url",
                                                
                                                @"type" : @"type",
                                                @"isSiteAdmin" : @"site_admin",
                                                
                                                @"name" : @"name",
                                                @"company" : @"company",
                                                @"blog" : @"blog",
                                                @"location" : @"location",
                                                @"email" : @"email",
                                                @"hireable" : @"hireable",
                                                @"bio" : @"bio",
                                                
                                                @"publicRepoCount" : @"public_repos",
                                                @"publicGistCount" : @"public_gists",
                                                @"followerCount" : @"followers",
                                                @"followingCount" : @"following",
                                                
                                                @"creationDate" : @"created_at",
                                                @"lastModificationDate" : @"updated_at"
                                                
                                                }];
    
    // Create `NSURL` value mapper.
    ValueMapper *urlValueMapper = [ValueMapper
                                   representer:^id(id runtimeValue) {
                                       return [runtimeValue absoluteString];
                                   } reconstructor:^id(id representedValue) {
                                       return [NSURL URLWithString:representedValue];
                                   }];
    
    // Create `NSDate` value mapper.
    mapper.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    mapper.timeZone = [NSTimeZone localTimeZone].name;
    ValueMapper *dateValueMapper = [ValueMapper
                                    representer:^id(id runtimeValue) {
                                        return [mapper.dateFormatter stringFromDate:runtimeValue];
                                    } reconstructor:^id(id representedValue) {
                                        return [mapper.dateFormatter dateFromString:representedValue];
                                    }];
    
    // Value mappers for given fields (!).
    mapper.valueMappersForFields =
    @{
      
      // NSURL value mappers.
      @"avatarURL" : urlValueMapper,
      @"URL" : urlValueMapper,
      @"htmlURL" : urlValueMapper,
      @"followersURL" : urlValueMapper,
      @"subscriptionsURL" : urlValueMapper,
      @"organizationsURL" : urlValueMapper,
      @"reposURL" : urlValueMapper,
      @"receivedEventsURL" : urlValueMapper,
      
      // Create `GitHubEntityType` value mapper.
      @"type" : [ValueMapper
                 representer:^id(id runtimeValue) {
                     return ([runtimeValue integerValue] == GitHubEntityTypeUser) ? @"User" : @"Unknown";
                 } reconstructor:^id(id representedValue) {
                     return ([representedValue isEqualToString:@"User"]) ? @(GitHubEntityTypeUser) : @(GitHubEntityTypeUnknown);
                 }],
      
      // NSDate.
      @"creationDate" : dateValueMapper,
      @"lastModificationDate" : dateValueMapper,
      
      };
    
    // Return the augmented mapper.
    return mapper;
}


@end
