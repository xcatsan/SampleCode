//
//  CollectionViewItem.m
//  CustomCell
//

#import "CollectionViewItem.h"
#import "ItemView.h"

@implementation CollectionViewItem

- (void)setSelected:(BOOL)flag
{
	NSLog(@"self=%@: view=%@: ro=%@: %d", self, [self view], [self representedObject], flag);
	
	ItemView* itemView = (ItemView*)[self view];
	itemView.selected = flag;
	[itemView setNeedsDisplay:YES];
	[super setSelected:flag];
}

@end
