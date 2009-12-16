//
//  CustomCellButton.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/15.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellButton.h"

#define TITLE_MARGIN_X	6.0
#define TITLE_MARGIN_Y	3.0

@implementation CustomCellButton

- (id)initWithTitle:(NSString*)aTitle at:(NSPoint)aPoint;
{
	self = [super init];
	
	if (self) {
		NSDictionary* attrs = [NSDictionary dictionary];
		frame.size = [aTitle sizeWithAttributes:attrs];
		frame.size.width += TITLE_MARGIN_X*2;
		frame.size.height += TITLE_MARGIN_Y*2;
		frame.origin = aPoint;
		self.title = [aTitle retain];
	}
	
	return self;
}
- (void) dealloc
{
	[title release];
	[super dealloc];
}


- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
 state:(NSInteger)buttonState
{
	NSColor* frameColor;
	NSColor* backgroundColor;
	NSColor* fontColor;

	switch (buttonState) {
		case CONTROL_STATE_ON:
			frameColor = [NSColor lightGrayColor];
			backgroundColor = [NSColor redColor];
			fontColor = [NSColor whiteColor];
			break;
		case CONTROL_STATE_OVER:
			frameColor = [NSColor grayColor];
			backgroundColor = [NSColor lightGrayColor];
			fontColor = [NSColor blackColor];
			break;
		default:
			frameColor = [NSColor lightGrayColor];
			backgroundColor = [NSColor whiteColor];
			fontColor = [NSColor grayColor];
			break;
	}

	[controlView lockFocus];
	

	NSRect rect = frame;
	rect.origin.x += cellFrame.origin.x;
	rect.origin.y += cellFrame.origin.y;

	NSBezierPath* path = [NSBezierPath
		bezierPathWithRoundedRect:rect xRadius:10.0 yRadius:10.0];
	[backgroundColor set];
	[path fill];
	
	[frameColor set];
	[path setLineWidth:2.0];
	[path stroke];
	
	NSPoint p2 = rect.origin;
	p2.x += TITLE_MARGIN_X;
	p2.y += TITLE_MARGIN_Y;
	NSDictionary* attrs = [NSDictionary dictionary];
	[fontColor set];
	[title drawAtPoint:p2 withAttributes:attrs];

	[controlView unlockFocus];
}



@end
