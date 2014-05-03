//
//  EPPZNSArrayValueMapper.m
//  eppz!model
//
//  Created by Gardrobe on 03/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZNSArrayValueMapper.h"


@implementation EPPZNSArrayValueMapper


#pragma mark - Value mapping

-(id)representValue:(id) runtimeValue
{
    return @"Array";
}

-(id)reconstructValue:(id) representedValue
{
    return [NSArray new];
}


@end
