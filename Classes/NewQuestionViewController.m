//
//  NewQuestionViewController.m
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewQuestionViewController.h"


@implementation NewQuestionViewController

@synthesize questionView;
@synthesize askButton;
@synthesize bot;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"New Question";
	
	[questionView becomeFirstResponder];
	
	self.navigationItem.rightBarButtonItem = self.askButton;
	
	self.askButton.action = @selector(askQuestion);
	self.askButton.target = self;
	self.askButton.style = UIBarButtonItemStyleDone;
}

-(void)askQuestion
{
	ServerComm *servercomm = [[ServerComm alloc] init];
	servercomm.delegate = self;
	
	Question *question = [[Question alloc] init];
	question.title = @"null";
	question.content = questionView.text;
	servercomm.notJSON = YES;
	[servercomm post:[question getAsJSON] to:@"questions.json" withToken:bot.authToken];
	
	[question release];
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
	
	[questionView release];
	[askButton release];
	questionView = nil;
	askButton = nil;
}

- (void)dealloc {
	[bot release];
	[questionView release];
	[askButton release];
    [super dealloc];
}


@end
