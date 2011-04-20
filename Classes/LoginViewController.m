//
//  LoginViewController.m
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

#define kStatusKey @"status"
#define KTokenKey @"token"

@implementation LoginViewController

@synthesize passwordField;
@synthesize usernameField;
@synthesize rememberSwitch;
@synthesize bot;
@synthesize activityIndicator;

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
	
	[usernameField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (authenticating) {
		return NO;
	}
	
	if( textField == self.usernameField )
	{
		[textField resignFirstResponder];
		[self.passwordField becomeFirstResponder];
	} 
	else if (textField == self.passwordField) 
	{		
		authenticating = YES;
		ServerComm *servercomm = [[ServerComm alloc] init];
		servercomm.delegate = self;
		[servercomm authenticateUser:@"seanpatno@gmail.com" password:@"secret"];
		//[servercomm authenticateUser:usernameField.text password:passwordField.text];
		
		[servercomm release];
		activityIndicator.hidden = NO;
		[activityIndicator startAnimating];
		//Put some stuff here so it shows the user that it is authenticating
	}
		
	return YES;
}

-(void) serverDidReturn:(NSDictionary *)dictionary
{
	authenticating = NO;
	NSString *statusString = [dictionary objectForKey:kStatusKey];
	
	activityIndicator.hidden = YES;
	[activityIndicator stopAnimating];
	
	if( [statusString isEqualToString:@"success"] )
	{
		//successful authentication
		
		NSString *tokenString = [dictionary objectForKey:KTokenKey];
		NSLog(@"Token: %@", tokenString);
		bot.authToken = tokenString;
		
		[self.parentViewController dismissModalViewControllerAnimated:YES];
	}
	else 
	{
		//failure of authentication
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Incorrect username or password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[self.usernameField becomeFirstResponder];
		
		self.usernameField.text = @"";
		self.passwordField.text = @"";
	}
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	[passwordField release];
	[usernameField release];
	[activityIndicator release];
	passwordField = nil;
	usernameField = nil;
	activityIndicator = nil;
}

- (void)dealloc {
	[bot release];
	[passwordField release];
	[usernameField release];
	[activityIndicator release];
    [super dealloc];
}


@end
