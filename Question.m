//
//  Question.m
//  DokBot
//
//  Created by Sean Patno on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Question.h"

#import "Answer.h"

@implementation Question

@synthesize title,content,authorUserId, questionId, updateDate, creationDate, answers, authorName;

-(void)populateAnswersFromDictionary:(NSDictionary *)dictionary
{	
	[answers removeAllObjects];
	NSArray *answerArray = [[dictionary objectForKey:@"question"] objectForKey:KAnswersKey];

	for( NSDictionary *answerDict in answerArray )
	{

		Answer *answer = [[Answer alloc] init];
		[answer populateDataFromDictionary:answerDict];
		[answers addObject:answer];
		[answer release];
	}
}

-(void)populateDataFromDictionary:(NSDictionary *)dictionary
{	
	
	NSDictionary *questionDict = [dictionary objectForKey:@"question"];
	
	NSDictionary *userDict = [questionDict objectForKey:@"user"];
	{
		self.authorName = [userDict objectForKey:@"name"];
	}
	
	//get the question id
	{
		self.questionId = [[questionDict objectForKey:kQuestionIdKey] intValue];
	}
	
	//get the author user id
	{
		self.authorUserId = [[questionDict objectForKey:kAuthorUserIdKey] intValue];
	}
	
	//get the content string
	{
		self.content = [questionDict objectForKey:kContentKey];
	}
	
	//get the title string
	{
		self.title = [questionDict objectForKey:kTitleKey];
	}
	
	//TODO:Not quite sure if this date stuff works yet
	NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	//get the update date
	{
		NSString *updateDateString = [questionDict objectForKey:kUpdateDateKey];
		self.updateDate = [[dateFormatter dateFromString:updateDateString] retain];
	}
	
	//get the creation date
	{
		NSString *creationDateString = [questionDict objectForKey:kCreationDateKey];
		self.creationDate = [[dateFormatter dateFromString:creationDateString] retain];
	}
	[dateFormatter release];
	[enUSPOSIXLocale release];
	
	answers = [[NSMutableArray alloc] initWithCapacity:1];
}

-(NSString*)getDateAsString:(NSDate *)date
{
	//NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
	
	NSString *dateAsString = [dateFormatter stringFromDate:date];
	
	[dateFormatter release];
	//[enUSPOSIXLocale release];
	
	return dateAsString;
}

-(NSString*)getUpdateDate
{
	return [self getDateAsString:updateDate];
}

-(NSString*)getCreationDate
{
	return [self getDateAsString:creationDate];
}

-(NSString*)getAsJSON
{
	NSMutableString *mutString = [NSMutableString stringWithCapacity:1];
	
	[mutString appendString:@"{ \"question\": { \"content\": \""];
	[mutString appendString:self.content];
	//mutString appendString:@"\" "];
	//[mutString appendString:@"\", \"title\": \""];
	//[mutString appendString:self.title];
	[mutString appendString:@"\" } }"];
	
	return mutString;
}

-(void) dealloc
{
	[answers release];
	[title release];
	[updateDate release];
	[creationDate release];
	[content release];
	[super dealloc];
}

@end
