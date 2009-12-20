//
//  CustomCellImage.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/17.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellImage.h"


@implementation CustomCellImage
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)buttonState value:(id)value
{
	NSImage* image = [[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:[value valueForKey:self.keyPath]]] autorelease];
	
	NSPoint p1 = cellFrame.origin;
	p1.x += self.frame.origin.x;
	p1.y += self.frame.origin.y + [image size].height;
	[image compositeToPoint:p1 operation:NSCompositeSourceOver];
}
@end
