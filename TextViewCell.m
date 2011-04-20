

#import "TextViewCell.h"


@implementation TextViewCell

@synthesize textView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier text:(NSString*)theText
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		//self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		//textView.scrollEnabled = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		//self.autoresizesSubviews = YES;
		
		// cell's title label
		self.textLabel.backgroundColor = self.backgroundColor;
		self.textLabel.opaque = NO;
		self.textLabel.textColor = [UIColor blackColor];
		self.textLabel.highlightedTextColor = [UIColor whiteColor];
		self.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		CGSize sizeC = CGSizeMake(self.contentView.frame.size.width - 20, 1000);
		CGSize textSizeNeeded = [theText sizeWithFont:self.textLabel.font constrainedToSize:sizeC];
		
		textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentView.frame.size.width - 20, textSizeNeeded.height)];
		textView.text = theText;
		textView.editable = NO;
		//		NSLog(@"Before addsubview:%@", textView);
		[self.contentView addSubview:textView];
		textView.scrollEnabled = NO;
		//[textView sizeToFit];
		
		//textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 
		//							textView.frame.size.width, textView.contentSize.height);

		//	self.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 
		//							textView.frame.size.width, textView.contentSize.height);
		
		//self.contentView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 
		//							textView.frame.size.width, textView.contentSize.height);
		//[self.contentView sizeToFit];
		//[self sizeToFit];
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, textSizeNeeded.height + 8.0);
		self.contentView.frame = self.frame;

		
		/*/ cell's check button
		 checkButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		 checkButton.frame = CGRectZero;
		 checkButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		 checkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		 [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchDown];
		 checkButton.backgroundColor = self.backgroundColor;
		 [self.contentView addSubview:checkButton];*/
	}
	return self;
}

-( CGFloat ) getContentHeight
{
	
	//	textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 
	//textView.frame.size.width, textView.contentSize.height);
	
	return textView.contentSize.height + 30.0;
}

/*- (void)layoutSubviews
 {
 [super layoutSubviews];
 
 CGRect contentRect = [self.contentView bounds];
 
 CGRect frameC = CGRectMake(contentRect.origin.x, contentRect.origin.y + 4.0, contentRect.size.width, self.textView.contentSize.height);
 NSLog(@"layoutSubviews:contentRect %f", frameC.size.height);
 self.textView.frame = frameC;
 
 //[self.contentView sizeToFit];
 //[self sizeToFit];
 
 //self.contentView.frame = frameC;
 
 self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.textView.contentSize.height + 16.0);
 self.contentView.frame = self.frame;
 NSLog(@"layoutSubviews:self frame %f", self.frame.size.height);
 NSLog(@"layoutSubviews:self contentView %f", self.contentView.frame.size.height);*/

// layout the check button image
//UIImage *checkedImage = [UIImage imageNamed:@"checked.png"];
//frame = CGRectMake(contentRect.origin.x + 10.0, 12.0, checkedImage.size.width, checkedImage.size.height);
//checkButton.frame = frame;

//UIImage *image = (self.checked) ? checkedImage: [UIImage imageNamed:@"unchecked.png"];
//UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
//[checkButton setBackgroundImage:newImage forState:UIControlStateNormal];*/
//}

- (void)dealloc
{
	[textView release];
    [super dealloc];
}

// called when the checkmark button is touched 
- (void)checkAction:(id)sender
{
	// note: we don't use 'sender' because this action method can be called separate from the button (i.e. from table selection)
	//self.checked = !self.checked;
	//UIImage *checkImage = (self.checked) ? [UIImage imageNamed:@"checked.png"] : [UIImage imageNamed:@"unchecked.png"];
	//[checkButton setImage:checkImage forState:UIControlStateNormal];
}


@end
