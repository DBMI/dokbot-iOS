//
//  AnswerControlCell.m
//  DokBot
//
//  Created by Sean Patno on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnswerControlCell.h"

#define kButtonHeight	40.0
#define kPadding 3.0

#define kTrustButtonWidth 145.0//85.0
#define kFlagButtonWidth 145.0//75.0
#define kCommentsButtonWidth 127.0

@implementation AnswerControlCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier comments:(NSString*)numComments 
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		
		UIButton *trustButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		trustButton.frame = CGRectMake(kPadding, kPadding, kTrustButtonWidth, kButtonHeight);
		[trustButton setTitle:@"Trust" forState:UIControlStateNormal];
		trustButton.backgroundColor = [UIColor clearColor];
		[trustButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
		[trustButton addTarget:self action:@selector(trust:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:trustButton];
		[trustButton release];
		
		UIButton *flagButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		flagButton.frame = CGRectMake(kPadding * 2.0 + kTrustButtonWidth, kPadding, kFlagButtonWidth, kButtonHeight);
		[flagButton setTitle:@"Flag" forState:UIControlStateNormal];
		flagButton.backgroundColor = [UIColor clearColor];
		[flagButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[trustButton addTarget:self action:@selector(flag:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:flagButton];
		[flagButton release];
		
		/*
		UIButton *commentsButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		commentsButton.frame = CGRectMake(kPadding * 3.0 + kTrustButtonWidth + kFlagButtonWidth, 
										  kPadding, kCommentsButtonWidth, kButtonHeight);
		[commentsButton setTitle:[NSString stringWithFormat:@"Comments(%@)",numComments] forState:UIControlStateNormal];
		commentsButton.backgroundColor = [UIColor clearColor];
		[commentsButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:commentsButton];
		[commentsButton release];*/
		
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kButtonHeight + kPadding*2.0);
		self.contentView.frame = self.frame;
    }
    return self;
}

-(void)trust:(id)sender
{
	//TODO
	printf("trust\n");
}

-(void)flag:(id)sender
{
	//TODO
	printf("flag\n");
}

-(void)comment:(id)sender
{
	//TODO
	printf("comment\n");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
