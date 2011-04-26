//
//  HomeViewController.m
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

#import "QuestionViewController.h"
#import "Question.h"
#import "NewQuestionViewController.h"

@implementation HomeViewController

@synthesize filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, bot;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	NSLog(@"%@",self.navigationController);
	
	[self getQuestions];
	
	self.filteredListContent = [NSMutableArray arrayWithCapacity:1];
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	// save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredListContent count];
    }
    else
    {
        return [bot.questions count];
    }
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	Question *question = nil;// = [bot.questions objectAtIndex:indexPath.row];
	
	if (tableView == self.searchDisplayController.searchResultsTableView)
    {
		if( indexPath.row == ( [self.filteredListContent count] - 1 ) ) {
			
		} else {
			question = [self.filteredListContent objectAtIndex:indexPath.row];
		}
        
    }
    else
    {
        question = [bot.questions objectAtIndex:indexPath.row];
    }
	
	if( question ) {
		cell.textLabel.text = question.content;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Asked on %@", [question getCreationDate]];
	} else {
		cell.textLabel.text = @"Ask DokBot a question...";
		cell.detailTextLabel.text = @"";
	}

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Question *question = nil;
	
	if (tableView == self.searchDisplayController.searchResultsTableView)
    {
		if( indexPath.row != ( [self.filteredListContent count] - 1 ) ) {
			question = [self.filteredListContent objectAtIndex:indexPath.row];
		}
    }
    else
    {
        question = [bot.questions objectAtIndex:indexPath.row];
    }
	
	if( question ) 
	{

		QuestionViewController *questionController = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
		
		questionController.questionIndex =  question.questionId;
		questionController.bot = self.bot;
		
		[self.navigationController pushViewController:questionController animated:YES];
		[questionController release];
	
	} 
	else 
	{
		NewQuestionViewController *newQuestionController = [[NewQuestionViewController alloc] initWithNibName:@"NewQuestionViewController" bundle:nil];
		newQuestionController.bot = self.bot;
		[self.navigationController pushViewController:newQuestionController animated:YES];
		[newQuestionController release];
	}
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

#pragma mark -

-(void) pullDownToReloadActionFinished {
	// add one data on top
	//[data insertObject:[NSNumber numberWithInt: rand()] atIndex:0];
	//[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject: [NSIndexPath indexPathForRow:0 inSection:0]] 
	//					  withRowAnimation:UITableViewRowAnimationTop];
	[self.pullToReloadHeaderView setLastUpdatedDate: [NSDate date]];
	[self.pullToReloadHeaderView finishReloading:self.tableView animated:YES];
}

-(void) pullDownToReloadAction {	
	// finish reload after three seconds
	[self getQuestions];
	//[self performSelector:@selector(pullDownToReloadActionFinished) withObject:nil afterDelay: 3.0f];	
}

-(void) getQuestions
{
	ServerComm *servercomm = [[ServerComm alloc] init];
	servercomm.delegate = self;
	[servercomm getJSONWithToken:bot.authToken from:@"questions.json"];
	[servercomm release];
}

-(void)serverDidReturn:(NSDictionary *)dictionary
{
	if (dictionary) {
		[bot loadQuestionsFromDictionary:dictionary];
	}

	[self.tableView reloadData];
	[self.pullToReloadHeaderView setLastUpdatedDate: [NSDate date]];
	[self.pullToReloadHeaderView finishReloading:self.tableView animated:YES];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	
	//TODO: use:/questions/search?query=<some query> to do server side searching when number of questions gets large
	
	
	
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (Question *question in self.bot.questions)
    {
        //if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
        {
            NSRange range = [question.content rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
            if (range.length != 0)
            {
                [self.filteredListContent addObject:question];
            }// else if ([ testString isEqualToString:@"Create a new Question" ]) {
			//	[self.filteredListContent addObject:testString];
			//}
        }
    }
	[self.filteredListContent addObject:@"Ask DokBot a Question..."];
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)dealloc {
	[bot release];
    [filteredListContent release];
    [super dealloc];
}


@end

