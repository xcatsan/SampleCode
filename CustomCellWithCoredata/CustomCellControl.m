//
//  CustomCellControl.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/16.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellControl.h"


@implementation CustomCellControl

@synthesize frame, title, target, action, keyPath, textAttributes, canHandleEvent;

- (id)initWithFrame:(NSRect)rect
{
	self = [super init];
	if (self) {
		self.frame = rect;
		self.textAttributes = [NSDictionary dictionary];
		self.canHandleEvent = NO;
	}
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)state value:(id)value
{
	// should override this method in subclass
}

- (BOOL)hitTestAtPoint:(NSPoint)testPoint inFrame:(NSRect)cellFrame
{
	NSRect testRect = self.frame;
	testRect.origin.x += cellFrame.origin.x;
	testRect.origin.y += cellFrame.origin.y;
	return NSPointInRect(testPoint, testRect);
}


@end
