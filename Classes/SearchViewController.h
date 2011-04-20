//
//  SearchViewController.h
//  DokBot
//
//  Created by Sean Patno on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dokbot.h"

@interface SearchViewController : UITableViewController<UISearchDisplayDelegate,UISearchBarDelegate> {
	
	dokbot *bot;
	NSArray         *listContent;           // The master content.
    NSMutableArray  *filteredListContent;   // The content filtered as a result of a search.
    
    // The saved state of the search UI if a memory warning removed the view.
    NSString        *savedSearchTerm;
    NSInteger       savedScopeButtonIndex;
    BOOL            searchWasActive;
}
@property (nonatomic, retain) dokbot *bot;

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
