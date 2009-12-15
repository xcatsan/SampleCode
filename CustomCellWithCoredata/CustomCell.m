//
//  CustomCell.m
//  CustomCell
//
#import "CustomCell.h"
#import "CustomCellButton.h"
#import "Homepage.h"

@implementation CustomCell
@synthesize managedObjectContext, handlingValue;

- (id)init
{
	self = [super init];
	if (self) {
		NSLog(@"cell was initialized");
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}


- (Homepage*)homepage
{
	NSManagedObjectID* moid = (NSManagedObjectID*)[self objectValue];
	Homepage* homepage = (Homepage*)[self.managedObjectContext objectWithID:moid];
	return homepage;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	if (handlingValue == [self objectValue]) {
		[[NSColor lightGrayColor] set];
		NSRectFill(cellFrame);
	} else {
		[[NSColor whiteColor] set];
		NSRectFill(cellFrame);
	}

	Homepage* homepage = [self homepage];

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

//	[button drawWithFrame:cellFrame inView:controlView];
	
}

- (id)copyWithZone:(NSZone *)zone
{
//	NSLog(@"self=%@, copyWithZone:%@", self, zone);
	CustomCell* cell = [[[self class] allocWithZone:zone] init];
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
- (NSRect)expansionFrameWithFrame:(NSRect)cellFrame inView:(NSView *)view
{
	NSRect frame = cellFrame;
	frame.origin.x += 20;
	frame.origin.y -= 20;
	frame.size.width = 440;
	frame.size.height = 100;
	return frame;
}

- (NSString*)description
{
	return [[self homepage] description];
}
 */

#pragma mark -
#pragma mark Handle event
-(void)handleMouseDown:(NSEvent*)theEvent
{
	NSLog(@"mouseDown: %@", self);
}

-(void)handleMouseUp:(NSEvent*)theEvent
{
	NSLog(@"mouseUp");
}

-(void)handleMouseEntered:(NSEvent*)theEvent
{
//	NSLog(@"mouseEntered");
	self.handlingValue = [self objectValue];
}

-(void)handleMouseExited:(NSEvent*)theEvent
{
//	NSLog(@"mouseExited");
	self.handlingValue = nil;
}

-(void)handleMouseMoved:(NSEvent*)theEvent
{
	self.handlingValue = [self objectValue];
}

@end

