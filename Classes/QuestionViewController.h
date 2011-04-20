//
//  QuestionViewController.h
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dokbot.h"
#import "ServerComm.h"
#import "Question.h"
#import "Answer.h"

@interface QuestionViewController : UITableViewController <ServerCommDelegate> {

	NSInteger questionIndex;
	NSArray *answerArray;
	dokbot* bot;
}

@property (nonatomic ,retain) dokbot *bot;
@property (nonatomic, assign) NSInteger questionIndex;
@property (nonatomic, retain) NSArray *answerArray;


-(void) getData;

@end
