//
//  CustomCellLabel.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/17.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellLabel.h"


@implementation CustomCellLabel

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)buttonState value:(id)value
{
	NSRect rect = self.frame;
	rect.origin.x += cellFrame.origin.x;
	rect.origin.y += cellFrame.origin.y;
//	[[value valueForKeyPath:self.keyPath] drawAtPoint:p withAttributes:self.textAttributes];
	NSString* label = [value valueForKeyPath:self.keyPath];
	[label drawInRect:rect withAttributes:self.textAttributes];
}

@end
