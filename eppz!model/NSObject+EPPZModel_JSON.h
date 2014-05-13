//
//  NSObject+EPPZModel_JSON.h
//  eppz!model
//
//  Created by Gardrobe on 13/05/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (EPPZModel_JSON)


#pragma mark - Represent

-(NSString*)JSONStringRepresentation;
-(NSString*)prettyJSONStringRepresentation;

+(NSString*)JSONStringFromDictionary:(NSDictionary*) dictionaryRepresentation;
+(NSString*)JSONStringFromDictionary:(NSDictionary*) dictionaryRepresentation prettyPrint:(BOOL) prettyPrint;


#pragma mark - Save

-(void)saveToDocumentsAsJSONNamed:(NSString*) fileName;
-(void)saveToLibraryAsJSONNamed:(NSString*) fileName;
-(void)saveAsJSONToFilePath:(NSString*) filePath;

/*! Alias for @c saveToDocumentsAsJSONNamed: */
-(void)saveJSON:(NSString*) fileName;

/*! Alias for @c saveToLibraryAsJSONNamed: */
-(void)saveTestJSON:(NSString*) fileName;


#pragma mark - Load

+(instancetype)instanceFromJSONAtDocuemntsNamed:(NSString*) fileName;
+(instancetype)instanceFromJSONAtLibraryNamed:(NSString*) fileName;
+(instancetype)instanceFromJSONAtFilePath:(NSString*) filePath;

/*! Alias for @c instanceFromJSONAtDocuemntsNamed: */
+(instancetype)instanceFromJSON:(NSString*) fileName;

/*! Alias for @c instanceFromJSONAtLibraryNamed: */
+(instancetype)instanceFromTestJSON:(NSString*) fileName;


@end
