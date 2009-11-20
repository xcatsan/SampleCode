//
//  AppController.h
//  ViewControllerStudy
//

#import <Cocoa/Cocoa.h>

@class ImageFile;
@interface AppController : NSObject {

	IBOutlet NSView* view;
	NSViewController* viewController;
	
	ImageFile* imageFile;
}

@end
