//
//  EPPZMapper.m
//  eppz!model
//
//  Created by Borbás Geri on 02/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZMapper.h"

#import "NSObject+EPPZModel_inspecting.h"
#import "NSObject+EPPZModel.h"

#import "EPPZMapper+Default.h"
#import "EPPZMapper+Accessors.h"
#import "EPPZMapper+Representation.h"
#import "EPPZMapper+Debug.h"

#import "EPPZCollectionEnumerator.h"
#import "EPPZTracker.h"


@interface EPPZMapper ()
@end


@implementation EPPZMapper


#pragma mark - Basic accessors

-(NSDateFormatter*)dateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:self.dateFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:self.timeZone]];
    return dateFormatter;
}

-(void)setNilValueMapper:(EPPZValueMapper*) nilValueMapper
{
    _nilValueMapper = nilValueMapper;

    // Validate.
    if ([nilValueMapper.representerBlock(nil) isKindOfClass:[NSString class]] == NO)
    {
        [NSException exceptionWithName:@"Invalid `nil` value mapper."
                                reason:@"A `nil` representer should always return an NSString"
                              userInfo:nil];
    }
}


@end
