//
//  EPPZLog.m
//  eppz!model
//
//  Created by Gardrobe on 01/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZLog.h"


void __log(NSString *message)
{ NSLog(@"%@", message); }

void __logWarning(NSString *message)
{ NSLog(__warningFormat, message); }
