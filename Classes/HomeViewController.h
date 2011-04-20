//
//  HomeViewController.h
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dokbot.h"
#import "ServerComm.h"
#import "UIPullToReloadTableViewController.h"

@interface HomeViewController : UIPullToReloadTableViewController<ServerCommDelegate> {

	dokbot *bot;
	
	//search stuff
    NSMutableArray  *filteredListContent;   // The content filtered as a result of a search.
    
    // The saved state of the search UI if a memory warning removed the view.
    NSString        *savedSearchTerm;
    NSInteger       savedScopeButtonIndex;
    BOOL            searchWasActive;
	
}

@property (nonatomic ,retain) dokbot *bot;

@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

-(void) getQuestions;

@end
