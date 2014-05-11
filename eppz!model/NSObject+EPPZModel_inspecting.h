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


/*!
 
 Protocol to mark a given object to enjoy @c EPPZModel features.
 
 */
@protocol EPPZModel <NSObject>
@end


/*!
 
 Extend @c NSObject class to have some features to inspect class structure.
 
 */
@interface NSObject (Inspecting)


#pragma mark - Class inspection

/*! Alias for @c NSStringFromClass actually. */
+(NSString*)className;

/*! Alias for @c NSStringFromClass actually. */
-(NSString*)className;

/*!
 
 Returns an array with all the available properties for the given @c <EPPZModel> object.
 It traverses up the inheritance chain, but collects properties only from @c <EPPZModel>
 classes (having this, you can avoid collect really basic properties you are not interested
 in, like basic @c NSObject, @c UIKit properties, or accessibility properies for example).
 
 It gets populated once when the class loads, so later updates in class structure (like
 runtime property swizzling) have to be invoked manually using @c -updatePropertyNames.
 
 */
@property (nonatomic, readonly) NSArray *propertyNames;

/*!
 
 If the class property structure changes at runtime (e.g. you swizzle properties), you
 can update @c propertyNames for further operations.
 
 */
-(void)updatePropertyNames;


#pragma mark - Property inspection

/*! Returns the type name (either class name) of the property called @c propertyName. */
-(NSString*)typeOfPropertyNamed:(NSString*) propertyName;

/*! Returns the class of the property called @c propertyName. */
-(Class)classOfPropertyNamed:(NSString*) propertyName;


@end
