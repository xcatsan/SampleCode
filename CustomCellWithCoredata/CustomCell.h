//
//  CustomCell.h
//  CustomCell
//
#import <Cocoa/Cocoa.h>

@class CustomCellControl;
@interface CustomCell : NSCell {

	NSManagedObjectContext* managedObjectContext;

	id handlingValue;
	CustomCellControl* handlingControl;
	NSEvent* handlingEvent;
	BOOL isMouseDown;

	NSMutableArray* controls;
}

@property (retain) NSManagedObjectContext* managedObjectContext;
@property (retain) id handlingValue;
@property (retain) CustomCellControl* handlingControl;
@property (retain) NSEvent* handlingEvent;

-(void)addControl:(CustomCellControl*)control;

-(void)handleMouseDown:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;
-(void)handleMouseUp:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;
-(void)handleMouseEntered:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;
-(void)handleMouseExited:(NSEvent*)theEvent;
-(void)handleMouseMoved:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;

@end
