//
//  EPPZMapper.m
//  eppz!model
//
//  Created by orbás Geri  on 02/05/14.
//  Copyright (c) 2010-2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZMapper.h"
#import "NSObject+EPPZModel.h"


@interface EPPZMapper ()
@end


@implementation EPPZMapper


#pragma mark - Default mappers

-(id)init
{
    if (self = [super init])
    {
        // Defaults.
        self.fieldMapper = [EPPZFieldMapper new];
    }
    return self;
}



#pragma mark - Representation

-(NSDictionary*)dictionaryRepresentationOfModel:(NSObject*) model fields:(NSArray*) fields
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    // Create representation for each property using representers.
    [fields enumerateObjectsUsingBlock:^(NSString *eachField, NSUInteger index, BOOL *stop)
    {
        // Check for property.
        if ([model.propertyNames containsObject:eachField] == NO)
        { WARNING_AND_VOID(@"Can't find field `%@` on <%@> to represent.", eachField, model.className); }
        
        // Get value.
        id eachValue = [model valueForKey:eachField];
        
        // Represented value.
        #warning Hook in value mappers (recursively inside)!
        id eachRepresentation = eachValue;
         
                // Null.
                if (eachRepresentation == nil) eachRepresentation = [NSNull null];
        
        // Represented field.
        NSString *eachRepresentedField = [self.fieldMapper representationFieldForField:eachField];
        
        
        // Set.
        [dictionary setObject:eachRepresentation forKey:eachRepresentedField];
    }];
    
    return dictionary;}

-(void)configureModel:(NSObject*) model withDictionary:(NSDictionary*) dictionary
{
    // Do.
}


@end
