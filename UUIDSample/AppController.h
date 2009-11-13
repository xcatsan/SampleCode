//
//  AppController.h
//  UUIDSample
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {

	IBOutlet NSTextView* textView;
}
-(IBAction)createUUID:(id)sender;
-(IBAction)useProcessInfo:(id)sender;

@end
