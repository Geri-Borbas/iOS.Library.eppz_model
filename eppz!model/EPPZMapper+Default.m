//
//  EPPZMapper+Default.m
//  eppz!model
//
//  Created by Borbás Geri on 06/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZMapper+Default.h"


@implementation EPPZMapper (Default)


#pragma mark - Default mappers

-(id)init
{
    if (self = [super init])
    {
        // Default fiels.
        self.modelIdField = @"_id";
        self.classNameField = @"_type";
        self.representModelAttributes = YES;
        self.representReferences = NO;
        
        // Date format.
        self.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
        self.timeZone = [NSTimeZone localTimeZone].name;
        
        // Field mapper.
        self.fieldMapper = [FieldMapper new];
        
        // Default (straight) value mapper.
        self.defaultValueMapper = [ValueMapper new];
        
        // Nil value mapper.
        self.nilValueMapper = [ValueMapper representer:^id(id runtimeValue) {
                                               return @"<null>";
                                           } reconstructor:^id(id representedValue) {
                                               return nil;
                                           }];
        
        // Type name value mappers.
        self.valueMappersForTypeNames =
        @{
          
          // Foundation.
          
          @"NSData" : [ValueMapper type:@"NSData"
                            representer:^id(id runtimeValue) {
                                return [runtimeValue base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                            } reconstructor:^id(id representedValue) {
                                return [[NSData alloc] initWithBase64EncodedData:representedValue options:NSDataBase64DecodingIgnoreUnknownCharacters];
                            }],
          
          @"NSDate" : [ValueMapper type:@"NSDate"
                            representer:^id(id runtimeValue) {
                                return [self.dateFormatter stringFromDate:runtimeValue];
                            } reconstructor:^id(id representedValue) {
                                return [self.dateFormatter dateFromString:representedValue];
                            }],
          
          // CoreData.
          
          @"CGPoint" : [ValueMapper type:@"CGPoint"
                             representer:^id(id runtimeValue) {
                                 return NSStringFromCGPoint([runtimeValue CGPointValue]);
                             } reconstructor:^id(id representedValue) {
                                 return [NSValue valueWithCGPoint:CGPointFromString((NSString*)representedValue)];
                             }],
          
          @"CGSize" : [ValueMapper type:@"CGSize"
                            representer:^id(id runtimeValue) {
                                return NSStringFromCGSize([runtimeValue CGSizeValue]);
                            } reconstructor:^id(id representedValue) {
                                return [NSValue valueWithCGSize:CGSizeFromString((NSString*)representedValue)];
                            }],
          
          @"CGRect" : [ValueMapper type:@"CGRect"
                            representer:^id(id runtimeValue) {
                                return NSStringFromCGRect([runtimeValue CGRectValue]);
                            } reconstructor:^id(id representedValue) {
                                return [NSValue valueWithCGRect:CGRectFromString((NSString*)representedValue)];
                            }],
          
          @"CGAffineTransform" : [ValueMapper type:@"CGAffineTransform"
                                       representer:^id(id runtimeValue) {
                                           return NSStringFromCGAffineTransform([runtimeValue CGAffineTransformValue]);
                                       } reconstructor:^id(id representedValue) {
                                           return [NSValue valueWithCGAffineTransform:CGAffineTransformFromString((NSString*)representedValue)];
                                       }],
          
          };
        
        
    }
    return self;
}


@end
