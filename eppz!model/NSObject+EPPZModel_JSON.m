//
//  NSObject+EPPZModel_JSON.m
//  eppz!model
//
//  Created by Gardrobe on 13/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "NSObject+EPPZModel_JSON.h"
#import "NSObject+EPPZModel.h"


@implementation NSObject (EPPZModel_JSON)


#pragma mark - Represent

-(NSString*)JSONStringRepresentation
{ return [self.class JSONStringFromDictionary:self.dictionaryRepresentation]; }

-(NSString*)prettyJSONStringRepresentation
{ return [self.class JSONStringFromDictionary:self.dictionaryRepresentation prettyPrint:YES]; }

+(NSString*)JSONStringFromDictionary:(NSDictionary*) dictionary
{ return [self JSONStringFromDictionary:dictionary prettyPrint:NO]; }

+(NSString*)JSONStringFromDictionary:(NSDictionary*) dictionary prettyPrint:(BOOL) prettyPrint
{
    NSError *error;
    NSJSONWritingOptions options = prettyPrint ? NSJSONWritingPrettyPrinted : (NSJSONWritingOptions)0;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:options
                                                         error:&error];
    
    if (error.code == noErr)
    { return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]; }
    
    return nil;
}


#pragma mark - Save

-(void)saveToDocumentsAsJSONNamed:(NSString *)fileName
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    [self saveAsJSONToFilePath:[documents stringByAppendingPathComponent:fileName]];
}

-(void)saveToLibraryAsJSONNamed:(NSString *)fileName
{
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    [self saveAsJSONToFilePath:[library stringByAppendingPathComponent:fileName]];
}

-(void)saveAsJSONToFilePath:(NSString *)filePath
{
    [self.JSONStringRepresentation writeToFile:filePath
                                    atomically:NO
                                      encoding:NSStringEncodingConversionAllowLossy error:nil];
}

-(void)saveJSON:(NSString*) fileName
{ [self saveToDocumentsAsJSONNamed:fileName]; }

-(void)saveTestJSON:(NSString*) fileName
{ [self saveToLibraryAsJSONNamed:fileName]; }


#pragma mark - Load

+(instancetype)instanceFromJSONAtDocuemntsNamed:(NSString*) fileName
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [self instanceFromJSONAtFilePath:[documents stringByAppendingPathComponent:fileName]];
}

+(instancetype)instanceFromJSONAtLibraryNamed:(NSString*) fileName
{
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    return [self instanceFromJSONAtFilePath:[library stringByAppendingPathComponent:fileName]];
}

+(instancetype)instanceFromJSONAtFilePath:(NSString*) filePath
{
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    id JSONObejct = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (error.code == noErr &&
        [JSONObejct isKindOfClass:[NSDictionary class]])
    { return [self instanceWithDictionary:JSONObejct]; }
    
    return nil;
}

+(instancetype)instanceFromJSON:(NSString*) fileName
{ return [self instanceFromJSONAtDocuemntsNamed:fileName]; }

+(instancetype)instanceFromTestJSON:(NSString*) fileName
{ return [self instanceFromJSONAtLibraryNamed:fileName]; }



@end
