//
//  ApplicationCell.m
//  AppList
//
//  Created by 湖 on 10/04/15.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationCell.h"
#import "ApplicationEntry.h"

@implementation ApplicationCell

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	ApplicationEntry* entry = [self objectValue];
	
	NSSize iconSize = [entry.icon size];
	NSPoint p1 = cellFrame.origin;
	if ([controlView isFlipped]) {
		p1.y += iconSize.height;
	}
	[entry.icon compositeToPoint:p1 operation:NSCompositeSourceOver];
	
	NSRect nameRect = cellFrame;
	nameRect.origin.x += iconSize.width + 4.0;
	nameRect.size.width -= iconSize.width;

	NSDictionary* attrs = [NSDictionary dictionary];
	[entry.name drawInRect:nameRect withAttributes:attrs];
}

- (id)copyWithZone:(NSZone *)zone
{
	ApplicationCell* cell = (ApplicationCell*)[super copyWithZone:zone];
	return cell;
}

- (NSUInteger)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
	
	return NSCellHitContentArea;
}

@end
