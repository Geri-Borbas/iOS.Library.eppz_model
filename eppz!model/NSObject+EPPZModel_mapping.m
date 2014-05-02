//
//  NSObject+EPPZModel_mapping.m
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

#import "NSObject+EPPZModel_mapping.h"
#import "NSObject+EPPZModel.h"


static char mapper_key;


@implementation NSObject (EPPZModel_mapping)


#pragma mark - Mapper

+(EPPZMapper*)defaultMapper
{ return [EPPZMapper new]; }

+(EPPZMapper*)mapper
{
    // Get mapper.
    NSString *keyString = (NSString*)objc_getAssociatedObject(self, &mapper_key); // Get key from retainer
    void *key = (__bridge void*)keyString;
    EPPZMapper *mapper = (EPPZMapper*)objc_getAssociatedObject(self, key);
    
    // Lazy allocate if not any.
    if (mapper == nil)
    {
        mapper = [self defaultMapper];
        [self setMapper:mapper];
    }
    
    return mapper;
}

-(void)setMapper:(EPPZMapper*) mapper
{
    // Associate the key for the property to the class itself.
    NSString *keyString = FORMAT(@"%@_mapper_key", self.className);
    void *key = (__bridge void*)keyString;
    objc_setAssociatedObject(self, &mapper_key, keyString, OBJC_ASSOCIATION_RETAIN_NONATOMIC); // Retain key
    
    // Associate mapper to class.
    objc_setAssociatedObject(self, key, mapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Representation (runtime to dictionary)

-(NSDictionary*)dictionaryRepresentation
{ return [self dictionaryRepresentationOfFields:self.propertyNames]; }

-(NSDictionary*)dictionaryRepresentationOfFields:(NSArray*) fields
{ return [self.class.mapper dictionaryRepresentationOfModel:self fields:fields]; }


#pragma mark - Reconstruction

+(instancetype)instanceWithDictionary:(NSDictionary*) dictionary
{
    NSObject *instance = [self instance];
    [instance configureWithDictionary:dictionary];
    return instance;
}

-(void)configureWithDictionary:(NSDictionary*) dictionary
{ [self.class.mapper configureModel:self withDictionary:dictionary]; }


@end
