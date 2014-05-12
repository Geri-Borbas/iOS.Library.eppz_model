//
//  EPPZMapper+Debug.m
//  eppz!model
//
//  Created by Borbás Geri on 12/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZMapper+Debug.h"
#import "EPPZSwizzler.h"


@interface EPPZMapper ()
@property (nonatomic, strong) NSNumber *writeRepresentationLog_;
@end


@implementation EPPZMapper (Debug)
@dynamic writeRepresentationLog;
@dynamic logFileDirectory;


+(void)load
{
    [EPPZSwizzler synthesizePropertyNamed:@"logFileDirectory"
                                   ofKind:[NSString class]
                                 forClass:[NSObject class]
                               withPolicy:retain];
    
    // Workaround until `EPPZSwizzler` handles standard object types.
    [EPPZSwizzler synthesizePropertyNamed:@"writeRepresentationLog_"
                                   ofKind:[NSNumber class]
                                 forClass:[NSObject class]
                               withPolicy:assign];
}

-(void)setWriteRepresentationLog:(BOOL) writeRepresentationLog
{ self.writeRepresentationLog_ = @(writeRepresentationLog); }

-(BOOL)writeRepresentationLog
{ return self.writeRepresentationLog_.boolValue; }


@end
