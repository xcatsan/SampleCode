//
//  CustomTableView.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/11.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomTableView.h"


@implementation CustomTableView
@synthesize trackingArea;
#pragma mark -
#pragma mark Tracking Utility
- (void)updateTrackingArea
{
	if (self.trackingArea) {
		[self removeTrackingArea:self.trackingArea];
	}
	self.trackingArea = [[[NSTrackingArea alloc]
						  initWithRect:[self frame]
						  options:(NSTrackingMouseEnteredAndExited |
								   NSTrackingMouseMoved |
								   NSTrackingActiveAlways )
						  owner:self
						  userInfo:nil] autorelease];
	[self addTrackingArea:self.trackingArea];
}

#pragma mark -
#pragma mark Initialization and Deallocation
- (void)awakeFromNib
{
	[self updateTrackingArea];
}

- (void) dealloc
{
	if (self.trackingArea) {
		[self removeTrackingArea:self.trackingArea];
	}
	self.trackingArea = nil;
	[super dealloc];
}



#pragma mark -
#pragma mark Event handler (Overridden)
- (BOOL)isVisible:(NSEvent*)theEvent
{
	NSPoint p = [self convertPointFromBase:[theEvent locationInWindow]];
	return NSPointInRect(p, [self visibleRect]);
}

- (void)mouseDown:(NSEvent*)theEvent
{
	if ([self isVisible:theEvent]) {
		NSLog(@"mouseDown:");
	}
//	[super mouseDown:theEvent];
}

- (void)mouseUp:(NSEvent*)theEvent
{
	if ([self isVisible:theEvent]) {
		NSLog(@"mouseUp:");
	}
	[super mouseUp:theEvent];
}
- (void)mouseEntered:(NSEvent *)theEvent
{
	if ([self isVisible:theEvent]) {
		NSLog(@"mouseEntered:");
	}
	[super mouseEntered:theEvent];
}
- (void)mouseExited:(NSEvent *)theEvent
{
	if ([self isVisible:theEvent]) {
		NSLog(@"mouseExited:");
	}
	[super mouseExited:theEvent];
}
- (void)mouseMoved:(NSEvent *)theEvent
{
	if ([self isVisible:theEvent]) {
		NSLog(@"mouseMoved:");
	}
	[super mouseMoved:theEvent];
}

- (void)viewDidEndLiveResize
{
//	NSLog(@"viewDidEndLiveResize %@", NSStringFromRect([self visibleRect]));
	[self updateTrackingArea];
	[super viewDidEndLiveResize];
}
@end
