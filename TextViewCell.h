

#import <UIKit/UIKit.h>


@interface TextViewCell : UITableViewCell 
{
	UITextView *textView;
}


@property (nonatomic, retain) UITextView *textView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier text:(NSString*)theText;

@end
