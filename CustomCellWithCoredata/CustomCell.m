//
//  CustomCell.m
//  CustomCell
//
#import "CustomCell.h"
#import "CustomCellControl.h"

@implementation CustomCell
@synthesize managedObjectContext, handlingValue, handlingEvent, handlingControl;

- (id)init
{
	self = [super init];
	if (self) {
		controls = [[NSMutableArray alloc] init];
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

-(id)dataObject
{
	NSManagedObjectID* moid = (NSManagedObjectID*)[self objectValue];
	NSManagedObject* mo = [self.managedObjectContext objectWithID:moid];
	return mo;
}


- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{	
	[controlView lockFocus];

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
					state:controlState
						 value:[self dataObject]];
	}	
	[controlView unlockFocus];
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

-(CustomCellControl*)controlOnMouse:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView
{
	NSPoint mp = [controlView convertPointFromBase:[theEvent locationInWindow]];
	for (CustomCellControl* cellControl in controls) {
		if (cellControl.canHandleEvent &&
			[cellControl hitTestAtPoint:mp inFrame:cellFrame]) {
			return cellControl;
		}
	}
	return nil;
}


#pragma mark -
#pragma mark 

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
	
	CustomCellControl* control = self.handlingControl;
	if (control.canHandleEvent && [control.target respondsToSelector:control.action]) {
		
		[control.target performSelector:control.action
		 withObject:[self dataObject]];
	}
	
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

