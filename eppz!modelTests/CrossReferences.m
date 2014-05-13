//
//  CrossReferences.m
//  eppz!model
//
//  Created by Gardrobe on 13/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
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
