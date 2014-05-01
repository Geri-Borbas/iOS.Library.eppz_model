//
//  NSObject+EPPZModel.h
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

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "EPPZSwizzler.h"
#import "EPPZLog.h"



@interface NSObject (EPPZModel)


#pragma mark - Creation

/*!
 
 Any custom instance initializing implementation that `EPPZModel` operations can use.
 Default implementation falls back to `+[NSObject new]`.
 
 */
+(instancetype)instance;


#pragma mark - Class inspection

/*! Alias for `NSStringFromClass(self.class)`. */
-(NSString*)className;

/*! Returns an array with all the available properties for the given object. */
@property (nonatomic, readonly) NSArray *propertyNameList;

/*!
 
 If the class property structure changes (you create properties at runtime for example),
 you can update the property name list for further model operations.
 
 */
-(void)updatePropertyNameList;

#pragma mark - Property inspection

/*! Returns the type name of the property called `propertyName`. */
-(NSString*)typeOfPropertyNamed:(NSString*) propertyName;

/*! Returns the class of the property called `propertyName`. */
-(Class)classOfPropertyNamed:(NSString*) propertyName;


@end
