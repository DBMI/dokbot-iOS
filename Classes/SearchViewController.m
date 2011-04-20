//
//  SearchViewController.m
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"

#import "QuestionViewController.h"
#import "NewQuestionViewController.h"

@implementation SearchViewController

@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, bot;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
    self.title = @"Search";
    
	listContent = [[NSArray alloc] initWithObjects:
							@"Placeholder",
							@"Placeholder a b",
							@" Placeholder hello",
							@"SPlaceholder test",
							@"Sea Placeholder goodbye",
							@"SearcPlaceholder cf",
							@" Placeholder asdf",
							@"Placeholder monkey",
							@"SPlaceholder hello3",
							@"Placeholder",
							@" Placeholderhello2",
							@" Placeholder",
				            @"Create a new Question",
							nil];
	
    // create a filtered list that will contain products for the search results table.
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;
}

- (void)viewDidUnload
{
    self.filteredListContent = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void)dealloc
{
	[bot release];
    [listContent release];
    [filteredListContent release];
    
    [super dealloc];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	[self.searchDisplayController.searchBar becomeFirstResponder];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
     If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
     */
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredListContent count];
    }
    else
    {
        return [self.listContent count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    /*
     If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
     */
    NSString *testString = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        testString = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        testString = [self.listContent objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = testString;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    /*
     If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
     */
    NSString *testString = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        testString = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        testString = [self.listContent objectAtIndex:indexPath.row];
    }
	
	if( [testString isEqualToString:@"Create a new Question"] ) 
	{
		NewQuestionViewController *newQuestionController = [[NewQuestionViewController alloc] initWithNibName:@"NewQuestionViewController" bundle:nil];
		newQuestionController.bot = self.bot;
		[self.navigationController pushViewController:newQuestionController animated:YES];
		
		[newQuestionController release];
	}
	else 
	{
		QuestionViewController *questionController = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
		questionController.bot = self.bot;
		questionController.questionIndex = 0;
		questionController.title = testString;
		
		[[self navigationController] pushViewController:questionController animated:YES];
		[questionController release];
	}
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (NSString *testString in listContent)
    {
        //if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
        {
            NSRange range = [testString rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
            if (range.length != 0)
            {
                [self.filteredListContent addObject:testString];
            } else if ([ testString isEqualToString:@"Create a new Question" ]) {
				[self.filteredListContent addObject:testString];
			}
        }
    }
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


@end

