//
//  ItemView.m
//  CustomCell
//

#import "ItemView.h"


@implementation ItemView

@synthesize selected;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	
	if (self.selected) {
		[[NSColor lightGrayColor] set];
	} else {
		[[NSColor whiteColor] set];
	}
	NSRectFill(rect);
	
	[super drawRect:rect];
	
	NSLog(@"view: %@", self);
}

@end
