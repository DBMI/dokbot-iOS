//
//  dokbot.h
//  DokBot
//
//  Created by Sean Patno on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Question.h"

@interface dokbot : NSObject {

	BOOL stayLoggedIn;
	NSString *authToken;
	NSString *username;
	NSString *password;
	NSMutableArray *questions;
}

@property (nonatomic, retain) NSString* authToken;
@property (nonatomic, assign) BOOL stayLoggedIn;
@property (nonatomic, retain) NSMutableArray *questions;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

-(void) loadQuestionsFromDictionary:(NSDictionary*)dictionary;

-(Question*)getQuestionWithId:(NSInteger)theID;

@end
