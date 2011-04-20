//
//  Answer.h
//  DokBot
//
//  Created by Sean Patno on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kConfidenceKey @"confidence"
#define kAnswerIdKey @"id"
#define kAuthorUserIdKey @"user_id"
#define kAnswerQuestionIdKey @"question_id"
#define kContentKey @"content"
#define kTitleKey @"title"
#define kUpdateDateKey @"updated_at"
#define kCreationDateKey @"created_at"

@interface Answer : NSObject {

	NSInteger confidence;
	NSInteger answerId;
	NSInteger questionId;
	NSInteger authorUserId;
	NSDate *creationDate;
	NSDate *updateDate;
	NSString *title;
	NSString *content;
	NSString *authorName;
	
}

@property (nonatomic, assign) NSInteger confidence;
@property (nonatomic, assign) NSInteger answerId;
@property (nonatomic, assign) NSInteger questionId;
@property (nonatomic, assign) NSInteger authorUserId;
@property (nonatomic, retain) NSDate *creationDate;
@property (nonatomic, retain) NSDate *updateDate;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString *authorName;

-(void) populateDataFromDictionary:(NSDictionary*)dictionary;
-(NSString*) getDateAsString:(NSDate*)date;
-(NSString*) getCreationDate;
-(NSString*) getUpdateDate;

-(NSString*)getAsJSON;

@end
