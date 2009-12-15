//
//  CustomCell.h
//  CustomCell
//
#import <Cocoa/Cocoa.h>

@class CustomCellButton;
@interface CustomCell : NSCell {

	NSManagedObjectContext* managedObjectContext;
	id handlingValue;
}

@property (retain) IBOutlet NSManagedObjectContext* managedObjectContext;
@property (retain) id handlingValue;

-(void)handleMouseDown:(NSEvent*)theEvent;
-(void)handleMouseUp:(NSEvent*)theEvent;
-(void)handleMouseEntered:(NSEvent*)theEvent;
-(void)handleMouseExited:(NSEvent*)theEvent;
-(void)handleMouseMoved:(NSEvent*)theEvent;

@end
