//
//  ApplicationButtonMatrix.m
//  MatrixSample
//
//  Created by 湖 on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationButtonMatrix.h"
#import "ApplicationButtonCell.h"

#define CELL_SPACING	4.0

@implementation ApplicationButtonMatrix
@synthesize trackingArea;

#pragma mark -
#pragma mark Utility
- (void)updateTrackingArea
{
	if (self.trackingArea) {
		[self removeTrackingArea:self.trackingArea];
	}
	self.trackingArea = [[[NSTrackingArea alloc]
						   initWithRect:[self bounds]
						   options:(NSTrackingMouseEnteredAndExited |
									NSTrackingMouseMoved |
									NSTrackingActiveAlways )
						   owner:self
						   userInfo:nil] autorelease];
	[self addTrackingArea:self.trackingArea];
}

#pragma mark -
#pragma mark Initializatin and Deallocation
- (id)init
{
	ApplicationButtonCell* cell = [[[ApplicationButtonCell alloc] init] autorelease];
	self = [super initWithFrame:NSZeroRect
						   mode:NSHighlightModeMatrix
					  prototype:cell
				   numberOfRows:0
				numberOfColumns:1];
	if (self) {
		[self setIntercellSpacing:NSMakeSize(0, CELL_SPACING)];
	}
	return self;
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
#pragma mark Overriden methods
- (void)sizeToCells
{
	[super sizeToCells];
	[self updateTrackingArea];
}


#pragma mark -
#pragma mark Event handling
- (ApplicationButtonCell*)cellAtPoint:(NSPoint)point
{
	NSInteger max_row = [self numberOfRows];
	for (NSInteger i=0; i < max_row; i++) {
		NSRect cellFrame = [self cellFrameAtRow:i column:0];
		if (NSPointInRect(point, cellFrame)) {
			return (ApplicationButtonCell*)[self cellAtRow:i column:0];
		}
	}
	return nil;
}

- (void)mouseDown:(NSEvent*)theEvent
{
	NSPoint point = [self convertPointFromBase:[theEvent locationInWindow]];
	ApplicationButtonCell* cell = [self cellAtPoint:point];
	cell.cellState = CELL_STATE_ON;
	if (pushedCell != cell) {
		if (overedCell != pushedCell) {
			pushedCell.cellState = CELL_STATE_OFF;
		}
		pushedCell = cell;
	}
	[self setNeedsDisplay:YES];
	[super mouseDown:theEvent];
}

- (void)mouseUp:(NSEvent*)theEvent
{
	if (pushedCell) {
		if (pushedCell == overedCell) {
			pushedCell.cellState = CELL_STATE_OVER;
		} else {
			pushedCell.cellState = CELL_STATE_OFF;
		}
		pushedCell = nil;
	}
	[self setNeedsDisplay:YES];
	
}
- (void)mouseEntered:(NSEvent *)theEvent
{
	NSPoint point = [self convertPointFromBase:[theEvent locationInWindow]];
	ApplicationButtonCell* cell = [self cellAtPoint:point];
	cell.cellState = CELL_STATE_OVER;
	if (overedCell != cell) {
		overedCell.cellState = CELL_STATE_OFF;
		overedCell = cell;
	}
	[self setNeedsDisplay:YES];	
}

- (void)mouseExited:(NSEvent *)theEvent
{
	if (overedCell) {
		overedCell.cellState = CELL_STATE_OFF;
		overedCell = nil;
	}
	[self setNeedsDisplay:YES];	
}
- (void)mouseMoved:(NSEvent *)theEvent
{
	NSPoint point = [self convertPointFromBase:[theEvent locationInWindow]];
	ApplicationButtonCell* cell = [self cellAtPoint:point];
	cell.cellState = CELL_STATE_OVER;
	if (overedCell != cell) {
		overedCell.cellState = CELL_STATE_OFF;
		overedCell = cell;
	}
	[self setNeedsDisplay:YES];	
}

@end
