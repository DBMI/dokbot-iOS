//
//  LoginViewController.h
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dokbot.h"
#import "ServerComm.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,ServerCommDelegate> {

	UITextField *usernameField;
	UITextField *passwordField;
	UISwitch *rememberSwitch;
	UIActivityIndicatorView *activityIndicator;
	dokbot* bot;
	BOOL authenticating;
}

@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) IBOutlet UITextField *usernameField;
@property (nonatomic,retain) IBOutlet UITextField *passwordField;
@property (nonatomic,retain) IBOutlet UISwitch *rememberSwitch;

@property (nonatomic,retain) dokbot* bot;

@end
