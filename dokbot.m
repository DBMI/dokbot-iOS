//
//  dokbot.m
//  DokBot
//
//  Created by Sean Patno on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "dokbot.h"

#define KQuestionsKey @"questions"

@implementation dokbot

@synthesize password, username, stayLoggedIn, questions, authToken;

-(id)init
{
	self = [super init];
	
	questions = [[NSMutableArray alloc] initWithCapacity:1];
	
	return self;
}

-(void)loadQuestionsFromDictionary:(NSDictionary *)dictionary
{
	NSArray *theQuestions = [dictionary objectForKey:KQuestionsKey];
	
	[self.questions removeAllObjects];
	
	for( NSDictionary *questionDict in theQuestions )
	{
		Question *question = [[Question alloc] init];
		
		[question populateDataFromDictionary:questionDict];
		
		[self.questions addObject:question];
		[question release];
	}
}

-(Question*)getQuestionWithId:(NSInteger)theID
{
	for(Question* question in self.questions)
	{
		if (question.questionId == theID) {
			return question;
		}
	}
	return nil;
}

-(void)dealloc
{
	[authToken release];
	[questions release];
	[username release];
	[password release];
	[super dealloc];
}

@end
