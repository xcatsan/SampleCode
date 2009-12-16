//
//  CustomCell.h
//  CustomCell
//
#import <Cocoa/Cocoa.h>

@class CustomCellButton;
@class CustomCellControl;
@interface CustomCell : NSCell {

	NSManagedObjectContext* managedObjectContext;

	id handlingValue;
	CustomCellButton* handlingControl;
	NSEvent* handlingEvent;
	BOOL isMouseDown;

	NSMutableArray* controls;
}

@property (retain) IBOutlet NSManagedObjectContext* managedObjectContext;
@property (retain) id handlingValue;
@property (retain) CustomCellButton* handlingControl;
@property (retain) NSEvent* handlingEvent;

-(void)addControl:(CustomCellControl*)control;

-(void)handleMouseDown:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;
-(void)handleMouseUp:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;
-(void)handleMouseEntered:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;
-(void)handleMouseExited:(NSEvent*)theEvent;
-(void)handleMouseMoved:(NSEvent*)theEvent frame:(NSRect)cellFrame inView:(NSView*)controlView;

@end
