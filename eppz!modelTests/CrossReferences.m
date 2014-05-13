//
//  CrossReferences.m
//  eppz!model
//
//  Created by Borbás Geri on 13/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <XCTest/XCTest.h>

#import "EPPZModel.h"
#import "EPPZMapper+Debug.h"

#import "City+TestCity.h"

#import "City+Comparison.h"
#import "House+Comparison.h"
#import "Citizen+Comparison.h"


@interface CrossReferences : XCTestCase
@property (nonatomic, strong) City *city;
@end


@implementation CrossReferences

-(void)setUp
{
    [super setUp];
    self.city = [City testCity];
}

-(void)testCrossReferencesAndJSON
{
    // Represent.
    [self.city saveTestJSON:@"city.json"];
    
    // Reconstruct.
    City *city = [City instanceFromTestJSON:@"city.json"];
    
    XCTAssertEqualObjects(self.city,
                          city,
                          @"Dictionary representation should be equal to asserted dictionary.");
    
    NSDictionary *dictionary = self.city.dictionaryRepresentation;
    NSDictionary *assertation = city.dictionaryRepresentation;
    
    XCTAssertEqualObjects(dictionary.description,
                          assertation.description,
                          @"Dictionary representation should be equal to asserted dictionary.");
}

@end
