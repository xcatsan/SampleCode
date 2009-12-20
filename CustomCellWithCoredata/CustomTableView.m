//
//  CustomTableView.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/11.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomTableView.h"

#import "CustomCell.h"

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
						  initWithRect:[self visibleRect]
						  options:(NSTrackingMouseEnteredAndExited |
								   NSTrackingMouseMoved |
								   NSTrackingActiveAlways )
						  owner:self
						  userInfo:nil] autorelease];
	[self addTrackingArea:self.trackingArea];
}
- (void)setDataCell:(CustomCell*)aCell
{
	[aCell retain];
	[cell release];
	cell = aCell;
	[[[self tableColumns] objectAtIndex:0] setDataCell:cell];
}

- (void)setup
{
	[self updateTrackingArea];
}


#pragma mark -
#pragma mark Initialization and Deallocation

- (void) dealloc
{
	if (self.trackingArea) {
		[self removeTrackingArea:self.trackingArea];
	}
	self.trackingArea = nil;
	[cell release];
	[super dealloc];
}



#pragma mark -
#pragma mark Event handler (Overridden)
- (BOOL)isVisible:(NSEvent*)theEvent
{
	NSPoint p = [self convertPointFromBase:[theEvent locationInWindow]];
	return NSPointInRect(p, [self visibleRect]);
}

- (CustomCell*)cellOnMouse:(NSEvent*)theEvent
{
	NSPoint mp = [self convertPointFromBase:[theEvent locationInWindow]];
	NSInteger column = [self columnAtPoint:mp];
	NSInteger row = [self rowAtPoint:mp];
	
	CustomCell* targetCell = (CustomCell*)[self preparedCellAtColumn:column row:row];
	return targetCell;
}

- (NSRect)cellFrameOnMouse:(NSEvent*)theEvent
{
	NSPoint mp = [self convertPointFromBase:[theEvent locationInWindow]];
	NSInteger column = [self columnAtPoint:mp];
	NSInteger row = [self rowAtPoint:mp];

	return 	 [self frameOfCellAtColumn:column row:row];
}


- (void)redrawCell:(NSEvent*)theEvent
{
	NSPoint mp = [self convertPointFromBase:[theEvent locationInWindow]];
	NSInteger column = [self columnAtPoint:mp];
	NSInteger row = [self rowAtPoint:mp];

	if (column != previousColumn || row != previousRow) {
		if (previousColumn >= 0 && previousRow >= 0) {

			[self setNeedsDisplayInRect:
			 [self frameOfCellAtColumn:previousColumn row:previousRow]];
		}
	}
	if (column >= 0 && row >= 0) {
		[self setNeedsDisplayInRect:[self frameOfCellAtColumn:column row:row]];
	}
	previousColumn = column;
	previousRow = row;
}


- (void)mouseDown:(NSEvent*)theEvent
{
	if ([self isVisible:theEvent]) {
		CustomCell* targetCell = [self cellOnMouse:theEvent];
		[targetCell handleMouseDown:theEvent
							  frame:[self cellFrameOnMouse:theEvent]
							 inView:self];
		[self redrawCell:theEvent];
	}
}


- (void)mouseUp:(NSEvent*)theEvent
{
	if ([self isVisible:theEvent]) {
		CustomCell* targetCell = [self cellOnMouse:theEvent];
		[targetCell handleMouseUp:theEvent
							frame:[self cellFrameOnMouse:theEvent]
						   inView:self];
		[self redrawCell:theEvent];
	}
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	if ([self isVisible:theEvent]) {
		CustomCell* targetCell = [self cellOnMouse:theEvent];
		[targetCell handleMouseEntered:theEvent
								 frame:[self cellFrameOnMouse:theEvent]
								inView:self];
		[self redrawCell:theEvent];
	}
}

- (void)mouseExited:(NSEvent *)theEvent
{
	[cell handleMouseExited:theEvent];
	[self setNeedsDisplay:YES];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	if ([self isVisible:theEvent]) {
		CustomCell* targetCell = [self cellOnMouse:theEvent];
		[targetCell handleMouseMoved:theEvent
							   frame:[self cellFrameOnMouse:theEvent]
							  inView:self];
		[self redrawCell:theEvent];
	}
}

#pragma mark -
#pragma mark Overidden methods
- (void)highlightSelectionInClipRect:(NSRect)clipRect
{
	// do nothing
}

- (void)viewDidEndLiveResize
{
//	NSLog(@"viewDidEndLiveResize %@", NSStringFromRect([self visibleRect]));
	[self updateTrackingArea];
	[super viewDidEndLiveResize];
}
@end
