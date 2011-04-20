//
//  NewAnswerViewController.h
//  DokBot
//
//  Created by Sean Patno on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dokbot.h"
#import "ServerComm.h"

@interface NewAnswerViewController : UIViewController <ServerCommDelegate> {

	UITextView *answerView;
	UIBarButtonItem *answerButton;
	
	NSInteger questionIndex;
	
	dokbot *bot;
	
}

@property (nonatomic, assign) NSInteger questionIndex;
@property (nonatomic, retain) dokbot *bot;
@property (nonatomic,retain) IBOutlet UITextView *answerView;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *answerButton;

-(void)answer;

@end
