//
//  Answer.m
//  DokBot
//
//  Created by Sean Patno on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Answer.h"


@implementation Answer

@synthesize title,content,authorUserId, questionId, updateDate, creationDate, answerId,confidence, authorName;

-(void)populateDataFromDictionary:(NSDictionary *)dictionary
{	
		
	NSDictionary *userDict = [dictionary objectForKey:@"user"];
	{
		self.authorName = [userDict objectForKey:@"name"];
	}
	
	//get the answer id
	{
		self.answerId = [[dictionary objectForKey:kAnswerIdKey] intValue];
	}
	
	//get the confidence
	{
		self.confidence = [[dictionary objectForKey:kConfidenceKey] intValue];
	}
	
	//get the question id
	{
		self.questionId = [[dictionary objectForKey:kAnswerQuestionIdKey] intValue];
	}
	
	//get the author user id
	{
		self.authorUserId = [[dictionary objectForKey:kAuthorUserIdKey] intValue];
	}
	
	//get the content string
	{
		self.content = [dictionary objectForKey:kContentKey];
	}
	
	//get the title string
	{
		self.title = [dictionary objectForKey:kTitleKey];
	}
	
	//TODO:Not quite sure if this date stuff works yet
	NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	//get the update date
	{
		NSString *updateDateString = [dictionary objectForKey:kUpdateDateKey];
		self.updateDate = [[dateFormatter dateFromString:updateDateString] retain];
	}
	
	//get the creation date
	{
		NSString *creationDateString = [dictionary objectForKey:kCreationDateKey];
		self.creationDate = [[dateFormatter dateFromString:creationDateString] retain];
	}
	[dateFormatter release];
	[enUSPOSIXLocale release];
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
	
	[mutString appendString:@"{ \"answer\": { \"content\": \""];
	[mutString appendString:self.content];
	//[mutString appendString:@"\" "];
	//[mutString appendString:@"\", \"title\": \""];
	//[mutString appendString:self.title];
	[mutString appendString:@"\" } }"];
	
	NSLog(@"generated json string: %@",mutString);
	
	return mutString;
}

-(void) dealloc
{
	[title release];
	[updateDate release];
	[creationDate release];
	[content release];
	[super dealloc];
}


@end
