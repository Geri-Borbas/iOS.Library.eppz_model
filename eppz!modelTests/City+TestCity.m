//
//  City+TestCity.m
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

#import "City+TestCity.h"


@implementation City (TestCity)


+(instancetype)testCity
{
    City *city = [self new];
    city.modelId = @"city_1";
    
    House *house_1 = [House houseInCity:city];
    House *house_2 = [House houseInCity:city];
    House *house_3 = [House houseInCity:city];
    
    [house_1 addCitizens:@[
                           [Citizen citizenWithName:@"Josh" ofCity:city inHouse:house_1],
                           [Citizen citizenWithName:@"Campbell" ofCity:city inHouse:house_1],
                           [Citizen citizenWithName:@"Stacy" ofCity:city inHouse:house_1],
                           ]];
    
    [house_2 addCitizens:@[
                           [Citizen citizenWithName:@"Greg" ofCity:city inHouse:house_2],
                           [Citizen citizenWithName:@"Paul" ofCity:city inHouse:house_2],
                           [Citizen citizenWithName:@"Lisa" ofCity:city inHouse:house_2],
                           [Citizen citizenWithName:@"Abott" ofCity:city inHouse:house_2],
                           ]];
    
    [house_3 addCitizens:@[
                           [Citizen citizenWithName:@"Donald" ofCity:city inHouse:house_3],
                           [Citizen citizenWithName:@"Sarah" ofCity:city inHouse:house_3],
                           [Citizen citizenWithName:@"Tagett" ofCity:city inHouse:house_3],
                           [Citizen citizenWithName:@"Laura" ofCity:city inHouse:house_3],
                           ]];
    
    city.houses = @[ house_1, house_2, house_3 ];
    
    return city;
}


@end
