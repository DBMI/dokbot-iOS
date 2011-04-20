//
//  AnswerControlCell.h
//  DokBot
//
//  Created by Sean Patno on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnswerControlCell : UITableViewCell {
	
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier comments:(NSString*)numComments;

-(void)trust:(id)sender;
-(void)flag:(id)sender;
-(void)comment:(id)sender;

@end
