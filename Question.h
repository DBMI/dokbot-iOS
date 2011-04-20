//
//  Question.h
//  DokBot
//
//  Created by Sean Patno on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQuestionIdKey @"id"
#define kAuthorUserIdKey @"user_id"
#define kContentKey @"content"
#define kTitleKey @"title"
#define kUpdateDateKey @"updated_at"
#define kCreationDateKey @"created_at"
#define KAnswersKey @"answers"


@interface Question : NSObject {

	NSInteger questionId;
	NSInteger authorUserId;
	NSString *title;
	NSString *content;
	NSDate *updateDate;
	NSDate *creationDate;
	
	NSString *authorName;
	
	NSMutableArray *answers;
	
}

@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* content;
@property (nonatomic,retain) NSDate* updateDate;
@property (nonatomic,retain) NSDate* creationDate;
@property (nonatomic,assign) NSInteger questionId;
@property (nonatomic,assign) NSInteger authorUserId;
@property (nonatomic,retain) NSMutableArray *answers;
@property (nonatomic, retain) NSString *authorName;

-(void) populateAnswersFromDictionary:(NSDictionary*)dictionary;
-(void) populateDataFromDictionary:(NSDictionary*)dictionary;
-(NSString*) getDateAsString:(NSDate*)date;
-(NSString*) getCreationDate;
-(NSString*) getUpdateDate;
-(NSString*) getAsJSON;

@end
