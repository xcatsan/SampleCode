//
//  CustomCell.m
//  CustomCell
//
#import "CustomCell.h"
#import "CustomCellControl.h"
#import "CustomCellButton.h"
#import "Homepage.h"

@implementation CustomCell
@synthesize managedObjectContext, handlingValue, handlingEvent, handlingControl;

- (id)init
{
	self = [super init];
	if (self) {
		controls = [[NSMutableArray alloc] init];
		CustomCellButton* cellButton;
		cellButton = [[CustomCellButton alloc] initWithTitle:@"BUTTON-A"
					  at:NSMakePoint(200, 10)];
		[controls addObject:cellButton];
		cellButton = [[CustomCellButton alloc] initWithTitle:@"BUTTON-B"
					  at:NSMakePoint(300, 10)];
		[controls addObject:cellButton];
	}
	return self;
}

- (void) dealloc
{
	self.handlingValue = nil;
	self.handlingEvent = nil;
	self.handlingControl = nil;
	[controls release];
	[super dealloc];
}

-(void)addControl:(CustomCellControl*)control
{
	[controls addObject:control];
}


- (Homepage*)homepage
{
	NSManagedObjectID* moid = (NSManagedObjectID*)[self objectValue];
	Homepage* homepage = (Homepage*)[self.managedObjectContext objectWithID:moid];
	return homepage;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	/*
	if (handlingValue == [self objectValue]) {
		[[NSColor lightGrayColor] set];
		NSRectFill(cellFrame);
	} else {
		[[NSColor whiteColor] set];
		NSRectFill(cellFrame);
	}
	 */
	
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

	NSInteger controlState;
	
	for (CustomCellControl* cellControl in controls) {
		if (handlingControl == cellControl) {
			if (isMouseDown) {
				controlState = CONTROL_STATE_ON;
			} else {
				controlState = CONTROL_STATE_OVER;
			}
		} else {
			controlState = CONTROL_STATE_OFF;
		}
		[cellControl drawWithFrame:cellFrame
				   inView:controlView
					state:controlState];
	}	
}

- (id)copyWithZone:(NSZone *)zone
{
	CustomCell* cell = [[[self class] allocWithZone:zone] init];
	return cell;
}

/*
- (void)setObjectValue:(id < NSCopying >)object
{
	[super setObjectValue:object];
}
*/

-(CustomCellButton*)controlOnMouse:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView
{
	NSPoint mp = [controlView convertPointFromBase:[theEvent locationInWindow]];
	for (CustomCellButton* cellButton in controls) {
		if ([cellButton hitTestAtPoint:mp inFrame:cellFrame]) {
			return cellButton;
		}
	}
	return nil;
}


#pragma mark -
#pragma mark Overriedden methods



#pragma mark -
#pragma mark Handle event
-(void)handleMouseDown:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView
{
	self.handlingValue = [self objectValue];
	self.handlingEvent = theEvent;
	self.handlingControl = [self controlOnMouse:theEvent frame:cellFrame inView:controlView];
	isMouseDown = YES;
}

-(void)handleMouseUp:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView
{
	self.handlingValue = [self objectValue];
	self.handlingEvent = theEvent;
	self.handlingControl = [self controlOnMouse:theEvent frame:cellFrame inView:controlView];
	isMouseDown = NO;
}

-(void)handleMouseEntered:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView
{
	self.handlingValue = [self objectValue];
	self.handlingEvent = theEvent;
	self.handlingControl = [self controlOnMouse:theEvent frame:cellFrame inView:controlView];
}

-(void)handleMouseExited:(NSEvent*)theEvent
{
	self.handlingValue = nil;
	self.handlingEvent = theEvent;
	self.handlingControl = nil;
}

-(void)handleMouseMoved:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView
{
	self.handlingValue = [self objectValue];
	self.handlingEvent = theEvent;
	self.handlingControl = [self controlOnMouse:theEvent frame:cellFrame inView:controlView];
}

@end

