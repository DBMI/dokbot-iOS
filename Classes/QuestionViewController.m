//
//  QuestionViewController.m
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionViewController.h"

#import "TextViewCell.h"
#import "AnswerControlCell.h"
#import "NewAnswerViewController.h"

#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0
#define kStdButtonWidth		106.0
#define kStdButtonHeight	40.0

#define kViewTag			1		// for tagging our embedded controls for removal at cell recycle time

@implementation QuestionViewController

@synthesize answerArray, bot, questionIndex;

- (void)dealloc
{
	[bot release];	
	[answerArray release];
	
	[super dealloc];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self getData];
	
	self.title = @"Question";
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload 
{
	[super viewDidUnload];
	
	
	self.answerArray = nil;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return ( [ ((Question*)[self.bot getQuestionWithId:questionIndex]).answers count] + 2);
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	//return [[self.answerArray objectAtIndex: section] valueForKey:kSectionTitleKey];
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//NSLog(@"")
	
	if( section == 0 ) {
		return 2;
	} else if (section == ([self numberOfSectionsInTableView:tableView]-1) ) {
		return 1;
	} else {
		return 3;
	}

}

- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	
	return cell.bounds.size.height;

}


// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	//TODO: some of the necessary data is missing from the answer JSON
	
	static NSString *kCellID = @"cellID";
	static NSString *kCustomCellID = @"hello";
	static NSString *kOtherCellID = @"id2";
	static NSString *kAnswerControlCellID = @"answerid";
	
	Question *question = [self.bot getQuestionWithId:self.questionIndex];
	Answer* answer = nil; 
	if( indexPath.section > 0 && indexPath.section < ([self numberOfSectionsInTableView:tableView]-1) )
	{
		answer = [question.answers objectAtIndex:(indexPath.section - 1)];
	}
	
	UITableViewCell *cell;
		
	if( (indexPath.row == 1) || (indexPath.row == 2) )
	{
		// cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
		cell = nil;
	} else 
	{
		 cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	}
	
	if (cell == nil)
    {
		
		if( indexPath.section == 0 )
		{
			if (indexPath.row == 0) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kOtherCellID] autorelease];
			} else {
				cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID text:question.content] autorelease];
			}
		}
		else if( indexPath.row == 1 )
		{
			cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID text:answer.content] autorelease];
		}
		else if( indexPath.row == 2 )
		{
			//TODO: 0 comments for now, this needs to be fixed later
			cell = [[[AnswerControlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAnswerControlCellID comments:0] autorelease];
		}
		else 
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
			//cell.lineBreakMode = UILineBreakModeWordWrap;
			//cell.textLabel.adjustsFontSizeToFitWidth = YES;
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

	
	if ([indexPath section] == 0) 
	{
		if( [indexPath row] == 0 )
		{
			cell.textLabel.text = [NSString stringWithFormat: @"Question by %@",question.authorName];
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Asked on %@", [question getCreationDate]];
		}
		else 
		{
			//cell.textLabel.numberOfLines = 0;
			//cell.textLabel.text = @"This is a sample question. This is a sample Question. This is where the question will be. Question mark?";
		}
	} 
	else if( [indexPath section] == ([self numberOfSectionsInTableView:tableView]-1) ) 
	{
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.textLabel.text = @"Add an Answer";
	} 
	else 
	{
		
		if( [indexPath row] == 0 ) {
			
			NSString *confString = @"?";
			if( answer.confidence > 2 ) {
				confString = @"yes";
			} else if (answer.confidence < 0) {
				confString = @"no";
			}
			
			cell.textLabel.text = [NSString stringWithFormat:@"Answer by %@ | Conf. %@",
								   answer.authorName, confString];
			cell.textLabel.adjustsFontSizeToFitWidth = YES;
		//} else if( [indexPath row] == 1 ) {
		//	cell.textLabel.numberOfLines = 0;
	//		cell.textLabel.text = @"Trusted By: ?";
			
		} else if( [indexPath row] == 1 ) {
			
		} else {
			
		}

	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.section == ([self numberOfSectionsInTableView:tableView]-1) ) 
	{
		NewAnswerViewController *answerController = [[NewAnswerViewController alloc] initWithNibName:@"NewAnswerViewController" bundle:nil];
		answerController.questionIndex = self.questionIndex;
		answerController.bot = self.bot;
		[self.navigationController pushViewController:answerController animated:YES];
		[answerController release];
	}
}

-(void)getData
{
	ServerComm *servercomm = [[ServerComm alloc] init];
	servercomm.delegate = self;
	
	[servercomm getJSONWithToken:bot.authToken from:[NSString stringWithFormat:@"questions/%d.json", questionIndex]];
	[servercomm release];
}

-(void)serverDidReturn:(NSDictionary *)dictionary
{
	///NSLog(@"%@",dictionary);
	
	[[bot getQuestionWithId:questionIndex] populateAnswersFromDictionary:dictionary];
	
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}


@end

