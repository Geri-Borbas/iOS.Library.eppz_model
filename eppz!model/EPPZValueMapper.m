//
//  EPPZValueMapper.m
//  eppz!model
//
//  Created by Borbás Geri  on 02/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZValueMapper.h"
#import "EPPZLog.h"


@interface EPPZValueMapper ()
@property (nonatomic, strong) NSString *typeNamePrefix;
@end



@implementation EPPZValueMapper


#pragma mark - Creation

+(instancetype)representer:(id(^)(id runtimeValue)) representerBlock reconstructor:(id(^)(id representedValue)) reconstructorBlock
{ return [self valueMapperWithRepresenter:representerBlock reconstructor:reconstructorBlock]; }

+(instancetype)valueMapperWithRepresenter:(id(^)(id runtimeValue)) representerBlock reconstructor:(id(^)(id representedValue)) reconstructorBlock
{ return [self valueMapperWithTypeName:nil representer:representerBlock reconstructor:reconstructorBlock]; }

+(instancetype)type:(NSString*) typeName representer:(id(^)(id runtimeValue)) representerBlock reconstructor:(id(^)(id representedValue)) reconstructorBlock
{ return [self valueMapperWithTypeName:typeName representer:representerBlock reconstructor:reconstructorBlock]; }

+(instancetype)valueMapperWithTypeName:(NSString*) typeName
                           representer:(id(^)(id runtimeValue)) representerBlock
                         reconstructor:(id(^)(id representedValue)) reconstructorBlock
{
    EPPZValueMapper *instance = [self new];
    instance.typeName = typeName;
    instance.representerBlock = representerBlock;
    instance.reconstructorBlock = reconstructorBlock;
    return instance;
}


#pragma mark - Value mapping

-(void)setTypeName:(NSString*) typeName
{
    _typeName = typeName;
    
    // Create `typeNamePrefix`.
    if (_typeName == nil)
    { self.typeNamePrefix = @""; }
    else
    { self.typeNamePrefix = FORMAT(@"%@%@", self.typeName, EPPZValueMapperTypeNameDelimiter); }
}

-(id)representValue:(id) runtimeValue
{
    id representedValue = runtimeValue;
    
    // Using block if any.
    if (self.representerBlock != nil) representedValue = self.representerBlock(runtimeValue);
    
    // Prefix with `typeName` if any.
    if (self.typeName != nil)
    { representedValue = FORMAT(@"%@%@", self.typeNamePrefix, representedValue); }
    
    return representedValue;
}

-(id)reconstructValue:(id) representedValue
{
    id runtimeValue = representedValue;
    
    // Remove `typeName` prefix if any.
    if (self.typeName != nil)
    {
        NSString *representedString = (NSString*)representedValue;
        representedValue = [representedString stringByReplacingOccurrencesOfString:self.typeNamePrefix withString:@""];
    }
    
    // Using block if any.
    if (self.reconstructorBlock != nil) runtimeValue = self.reconstructorBlock(representedValue);
    
    return runtimeValue;
}


@end
