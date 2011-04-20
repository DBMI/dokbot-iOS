//
//  NewQuestionViewController.h
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dokbot.h"
#import "ServerComm.h"

@interface NewQuestionViewController : UIViewController <ServerCommDelegate> {
	UITextView *questionView;
	UIBarButtonItem *askButton;
	
	dokbot *bot;
}

@property (nonatomic, retain) dokbot *bot;
@property (nonatomic,retain) IBOutlet UITextView *questionView;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *askButton;

-(void)askQuestion;

@end
