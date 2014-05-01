//
//  NSObject+EPPZModel.h
//  eppz!model
//
//  Created by Gardrobe on 01/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


static NSString *const __unknownTypeEncodingFormat = @"type encoding `%@`";


@interface NSObject (EPPZModel)


#pragma mark - Creation

/*!
 
 Any custom instance initializing implementation that `EPPZModel` operations can use.
 Default implementation falls back to `+[NSObject new]`.
 
 */
+(instancetype)instance;


#pragma mark - Property inspection

/*! Alias for `NSStringFromClass(self.class)`. */
-(NSString*)className;

/*! Returns the type name of the property called `propertyName`. */
-(NSString*)typeOfPropertyNamed:(NSString*) propertyName;

/*! Returns the class of the property called `propertyName`. */
-(Class)classOfPropertyNamed:(NSString*) propertyName;




@end
