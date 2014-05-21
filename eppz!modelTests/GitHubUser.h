//
//  GitHubUser.h
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

#import <Foundation/Foundation.h>
#import "EPPZModel.h"


typedef enum
{
    GitHubEntityTypeUnknown,    // 0
    GitHubEntityTypeUser        // 1
} GitHubEntityType;


@interface GitHubUser : NSObject

    <EPPZModel>


@property (nonatomic, strong) NSString *login;
@property (nonatomic) NSUInteger id;

@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic, strong) NSString *gravatarId;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSURL *htmlURL;
@property (nonatomic, strong) NSURL *followersURL;
@property (nonatomic, strong) NSURL *subscriptionsURL;
@property (nonatomic, strong) NSURL *organizationsURL;
@property (nonatomic, strong) NSURL *reposURL;
@property (nonatomic, strong) NSURL *receivedEventsURL;

@property (nonatomic, strong) NSString *followingURLTemplate;
@property (nonatomic, strong) NSString *gistsURLTemplate;
@property (nonatomic, strong) NSString *starredURLTemplate;
@property (nonatomic, strong) NSString *eventsURLTemplate;

@property (nonatomic) GitHubEntityType type;
@property (nonatomic) BOOL isSiteAdmin;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *blog;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) BOOL hireable;
@property (nonatomic, strong) NSString *bio;

@property (nonatomic) NSUInteger publicRepoCount;
@property (nonatomic) NSUInteger publicGistCount;
@property (nonatomic) NSUInteger followerCount;
@property (nonatomic) NSUInteger followingCount;

@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *lastModificationDate; // 2014-05-20T13:11:59Z


@end