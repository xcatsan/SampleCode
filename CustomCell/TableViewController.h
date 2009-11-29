//
//  TableViewController.h
//  CustomCell
//

#import <Cocoa/Cocoa.h>


@interface TableViewController : NSObject {

	NSMutableArray* list;
	
	IBOutlet NSTableColumn* tableColumn;
}
@property (assign) NSMutableArray* list;

@end
