//
//  EPPZLog.h
//  eppz!model
//
//  Created by Gardrobe on 01/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FORMAT(...) [NSString stringWithFormat:__VA_ARGS__]
#define LOG(...) __log(FORMAT(__VA_ARGS__))
#define WARNING(...) __logWarning(FORMAT(__VA_ARGS__))
#define WARNING_AND_VOID(...) __logWarning(FORMAT(__VA_ARGS__)); return
#define WARNING_AND_NIL(...) __logWarning(FORMAT(__VA_ARGS__)); return nil


static NSString *const __warningFormat = @"WARNING: %@";


void __log(NSString *message);
void __logWarning(NSString *message);
void __logWarning(NSString *message);
