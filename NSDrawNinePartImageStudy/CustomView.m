//
//  CustomView.m
//  NSDrawThreePartImageStudy
//
//  Created by 湖 on 09/12/23.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "CustomView.h"


@implementation CustomView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}
- (BOOL)isFlipped
{
	return YES;
}
- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	[[NSColor lightGrayColor] set];
	NSRectFill(dirtyRect);

	if (!topLeftCorner) {
		topLeftCorner     = [[NSImage imageNamed:@"frame_top_left"] retain];
		topEdgeFill       = [[NSImage imageNamed:@"frame_top_mid"] retain];
		topRightCorner    = [[NSImage imageNamed:@"frame_top_right"] retain];
		leftEdgeFill      = [[NSImage imageNamed:@"frame_mid_left"] retain];
		centerFill        = [[NSImage imageNamed:@"frame_mid_mid"] retain];
		rightEdgeFill     = [[NSImage imageNamed:@"frame_mid_right"] retain];
		bottomLeftCorner  = [[NSImage imageNamed:@"frame_bottom_left"] retain];
		bottomEdgeFill    = [[NSImage imageNamed:@"frame_bottom_mid"] retain];
		bottomRightCorner = [[NSImage imageNamed:@"frame_bottom_right"] retain];
		NSLog(@"%@", bottomRightCorner);
	}
	
	CGFloat margin = 20.0;
	
	NSRect frame = [self frame];
	
	frame.origin.x += margin;
	frame.origin.y += margin;
	frame.size.width -= margin*2.0;
	frame.size.height -= margin*2.0;
	NSDrawNinePartImage(frame, topLeftCorner, topEdgeFill, topRightCorner, leftEdgeFill, centerFill, rightEdgeFill, bottomLeftCorner, bottomEdgeFill, bottomRightCorner, NSCompositeSourceOver, 1.0, YES);
}

@end
