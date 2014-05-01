//
//  NSObject+EPPZModel.m
//  eppz!model
//
//  Created by Gardrobe on 01/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "NSObject+EPPZModel.h"


@interface NSObject (EPPZModel_private)

-(NSString*)typeNameForTypeEncoding:(NSString*) typeEncoding;

@end


@implementation NSObject (EPPZModel)


+(instancetype)instance
{ return [self new]; }


#pragma mark - Property inspection

-(NSString*)className
{ return NSStringFromClass(self.class); }

-(NSString*)typeOfPropertyNamed:(NSString*) propertyName
{
    NSString *propertyType = nil;

    // Get Class of property.
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    if (property == NULL)
    { WARNING_AND_NIL(@"No property called `%@` of %@", propertyName, self.className); }
    
    // Get property attributes.
    const char *propertyAttributesCString = property_getAttributes(property);
    if (propertyAttributesCString == NULL)
    { WARNING_AND_NIL(@"Could not get attributes for property called `%@` of <%@>", propertyName, self.className); }
    
    // Parse property attributes.
    NSString *propertyAttributes = [NSString stringWithCString:propertyAttributesCString encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    NSLog(@"%@", splitPropertyAttributes);
    if (splitPropertyAttributes.count > 0)
    {
        // From Objective-C Runtime Programming Guide.
        // xcdoc://ios//library/prerelease/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
        NSString *encodeType = splitPropertyAttributes[0];
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        propertyType = (splitEncodeType.count > 1) ? splitEncodeType[1] : [self typeNameForTypeEncoding:encodeType];
    }
    else
    { WARNING_AND_NIL(@"Could not parse attributes for property called `%@` of <%@>å", propertyName, self.className); }
    
    return propertyType;
}

-(NSString*)typeNameForTypeEncoding:(NSString*) typeEncoding
{
    // From Objective-C Runtime Programming Guide.
    // xcdoc://ios//library/prerelease/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
    NSDictionary *typeNamesForTypeEncodings = @{
                                                @"Tc" : @"char",
                                                @"Ti" : @"int",
                                                @"Ts" : @"short",
                                                @"Tl" : @"long",
                                                @"Tq" : @"long long",
                                                @"TC" : @"unsigned char",
                                                @"TI" : @"unsigned int",
                                                @"TS" : @"unsigned short",
                                                @"TL" : @"unsigned long",
                                                @"TQ" : @"unsigned long long",
                                                @"Tf" : @"float",
                                                @"Td" : @"double",
                                                @"Tv" : @"void",
                                                @"T^v" : @"void*",
                                                @"T*" : @"char*",
                                                @"T@" : @"id",
                                                @"T#" : @"Class",
                                                @"T:" : @"SEL",
                                                };
    
    // Recognized format.
    if ([[typeNamesForTypeEncodings allKeys] containsObject:typeEncoding])
    { return [typeNamesForTypeEncodings objectForKey:typeEncoding]; }
    
    // Struct property.
    if ([typeEncoding hasPrefix:@"T{"])
    { return @"struct"; }
    
    return FORMAT(__unknownTypeEncodingFormat, typeEncoding);
}

-(Class)classOfPropertyNamed:(NSString*) propertyName
{
    // Attempt to get class of property.
    Class class = nil;
    NSString *className = [self typeOfPropertyNamed:propertyName];
    class = NSClassFromString(className);
    
    // Warning.
    if (class == nil)
    { WARNING_AND_NIL(@"No class called `%@` in runtime", className); }
    
    return class;
}


@end
