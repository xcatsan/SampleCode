//
//  CustomCell.m
//  CustomCell
//
#import "CustomCell.h"
#import "Homepage.h"

@implementation CustomCell
@synthesize managedObjectContext;

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSManagedObjectID* moid = (NSManagedObjectID*)[self objectValue];
	Homepage* homepage = (Homepage*)[self.managedObjectContext objectWithID:moid];

	NSImage* image = [[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:homepage.image]] autorelease];
	
	[controlView lockFocus];
	NSPoint p1 = cellFrame.origin;
	p1.x += 5;
	p1.y += 5 + [image size].height;
	[image compositeToPoint:p1 operation:NSCompositeSourceOver];

	NSPoint p2 = cellFrame.origin;
	p2.x += 100;
	p2.y += 20;
	NSDictionary* attrs = [NSDictionary dictionary];
	[homepage.title drawAtPoint:p2 withAttributes:attrs];
	[controlView unlockFocus];
}

- (id)copyWithZone:(NSZone *)zone
{
//	NSLog(@"self=%@, copyWithZone:%@", self, zone);
	CustomCell* cell = (CustomCell*)[super copyWithZone:zone];
	return cell;
}

- (void)setObjectValue:(id < NSCopying >)object
{
//	NSLog(@"setObjectValue: %@", object);
	[super setObjectValue:object];
}


#pragma mark -
#pragma mark Overriedden methods
/*
- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView
{
	NSLog(@"startTrackingAt:%@ inView:%@", NSStringFromPoint(startPoint), controlView);
//	return [super startTrackingAt:startPoint inView:controlView];
	return YES;
}

- (BOOL)continueTracking:(NSPoint)lastPoint at:(NSPoint)currentPoint inView:(NSView *)controlView
{
	NSLog(@"continueTracking:%@ at:%@ inView:%@", NSStringFromPoint(lastPoint), NSStringFromPoint(currentPoint), controlView);
//	return [super continueTracking:lastPoint at:currentPoint inView:controlView];
	return YES;
}
- (void)stopTracking:(NSPoint)lastPoint at:(NSPoint)stopPoint inView:(NSView *)controlView mouseIsUp:(BOOL)flag
{
	NSLog(@"sopTracking:%@lastPoint at:%@ inView:%@ mouseIsUp:%d", NSStringFromPoint(lastPoint), NSStringFromPoint(stopPoint), controlView, flag);
}
 */
@end

