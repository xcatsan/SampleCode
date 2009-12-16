//
//  CustomCellControl.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/16.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellControl.h"


@implementation CustomCellControl

@synthesize title, target, action;

- (id)initWithOrigin:(NSPoint)origin
{
	self = [super init];
	if (self) {
		frame.origin = origin;
	}
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)buttonState
{
	// should override this method in subclass
}

- (BOOL)hitTestAtPoint:(NSPoint)testPoint inFrame:(NSRect)cellFrame
{
	NSRect testRect = frame;
	testRect.origin.x += cellFrame.origin.x;
	testRect.origin.y += cellFrame.origin.y;
	return NSPointInRect(testPoint, testRect);
}

@end
