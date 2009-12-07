//
//  CustomCell.h
//  CustomCell
//
#import <Cocoa/Cocoa.h>


@interface CustomCell : NSCell {

	NSManagedObjectContext* managedObjectContext;

}

@property (retain) NSManagedObjectContext* managedObjectContext;
@end
