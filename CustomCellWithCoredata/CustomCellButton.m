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

#pragma mark -
#pragma mark Initialization and Deallocation

- (id)initWithFrame:(NSRect)rect
{
	self = [super initWithFrame:rect];
	
	if (self) {
		self.canHandleEvent = YES;
	}
	
	return self;
}

- (void) dealloc
{
	[title release];
	[super dealloc];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)state value:(id)value
{
	NSColor* frameColor;
	NSColor* backgroundColor;

	switch (state) {
		case CONTROL_STATE_ON:
			frameColor = [NSColor lightGrayColor];
			backgroundColor = [NSColor redColor];
			break;
		case CONTROL_STATE_OVER:
			frameColor = [NSColor grayColor];
			backgroundColor = [NSColor lightGrayColor];
			break;
		default:
			frameColor = [NSColor lightGrayColor];
			backgroundColor = [NSColor whiteColor];
			break;
	}

	NSRect rect = self.frame;
	rect.origin.x += cellFrame.origin.x;
	rect.origin.y += cellFrame.origin.y;

	NSBezierPath* path = [NSBezierPath
		bezierPathWithRoundedRect:rect xRadius:10.0 yRadius:10.0];
	[backgroundColor set];
	[path fill];
	
	[frameColor set];
	[path setLineWidth:2.0];
	[path stroke];
	
	NSSize textSize = [self.title sizeWithAttributes:self.textAttributes];
	CGFloat margin_x = (self.frame.size.width - textSize.width)/2.0;
	CGFloat margin_y = (self.frame.size.height - textSize.height)/2.0;

	NSRect textRect = self.frame;

	textRect.origin.x += margin_x + cellFrame.origin.x;
	textRect.origin.y += margin_y + cellFrame.origin.y;
	textRect.size.width -= margin_x*2;
	textRect.size.height -= margin_y*2;
	
	[title drawInRect:textRect withAttributes:self.textAttributes];
}


#pragma mark -
#pragma mark Original methods

- (void)adjustSize
{
	frame.size = [self.title sizeWithAttributes:self.textAttributes];
	frame.size.width += TITLE_MARGIN_X*2;
	frame.size.height += TITLE_MARGIN_Y*2;
}


@end
