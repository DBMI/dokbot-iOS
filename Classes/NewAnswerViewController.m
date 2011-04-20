//
//  NewAnswerViewController.m
//  DokBot
//
//  Created by Sean Patno on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewAnswerViewController.h"

#import "Answer.h"

@implementation NewAnswerViewController

@synthesize answerView;
@synthesize answerButton;
@synthesize bot;
@synthesize questionIndex;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"New Answer";
	
	[answerView becomeFirstResponder];
	
	self.navigationItem.rightBarButtonItem = self.answerButton;
	
	self.answerButton.action = @selector(answer);
	self.answerButton.target = self;
	self.answerButton.style = UIBarButtonItemStyleDone;
}

-(void)answer
{
	ServerComm *servercomm = [[ServerComm alloc] init];
	servercomm.delegate = self;
	
	Answer *answer = [[Answer alloc] init];
	answer.title = @"null";
	answer.content = answerView.text;
	servercomm.notJSON = YES;
	NSString *urlSuffix = [NSString stringWithFormat:@"questions/%d/answers.json",self.questionIndex];
	[servercomm post:[answer getAsJSON] to:urlSuffix withToken:bot.authToken];
	
	[answer release];
	[servercomm release];
}

-(void)serverDidReturn:(NSDictionary *)dictionary
{
	//TODO: finish this?
	[self.navigationController popViewControllerAnimated:YES];
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	[answerView release];
	[answerButton release];
	answerView = nil;
	answerButton = nil;
}

- (void)dealloc {
	[bot release];
	[answerView release];
	[answerButton release];
    [super dealloc];
}


@end
