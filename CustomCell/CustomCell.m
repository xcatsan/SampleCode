//
//  CustomCell.m
//  CustomCell
//
#import "CustomCell.h"
#import "Homepage.h"

@implementation CustomCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	Homepage* homepage = [self objectValue];
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
	NSLog(@"self=%@, copyWithZone:%@", self, zone);
	CustomCell* cell = (CustomCell*)[super copyWithZone:zone];
	return cell;
}

- (void)setObjectValue:(id < NSCopying >)object
{
	NSLog(@"setObjectValue: %@", object);
	[super setObjectValue:object];
}

@end
