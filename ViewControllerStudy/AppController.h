//
//  AppController.h
//  ViewControllerStudy
//

#import <Cocoa/Cocoa.h>

@class ImageFile;
@interface AppController : NSObject {

	IBOutlet NSView* view;
	IBOutlet NSViewController* viewController;
	
	ImageFile* imageFile;
}

@end
