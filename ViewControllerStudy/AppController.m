//
//  AppController.m
//  ViewControllerStudy
//

#import "AppController.h"
#import "ImageFile.h"
#import "ViewController.h"

@implementation AppController

- (void)awakeFromNib
{
	viewControllers = [[NSMutableArray alloc] init];
	CGFloat offset_y = 0;
	for (int i=0; i < 4; i++) {
		imageFile = [[[ImageFile alloc] init] autorelease];
		imageFile.image = [NSImage imageNamed:@"sample"];
		imageFile.name = [NSString stringWithFormat:@"count-%d", i];
		imageFile.date = [NSDate date];
		
		ViewController* viewController = [[[NSViewController alloc]
						  initWithNibName:@"SampleView" bundle:nil] autorelease];
		[viewController setRepresentedObject:imageFile];
		NSView* subview = [viewController view];
		NSRect frame = [subview frame];
		[subview setFrameOrigin:NSMakePoint(frame.origin.x , frame.origin.y + offset_y)];
		[view addSubview:subview];
		[viewControllers addObject:viewController];
		offset_y += frame.size.height;
	}
}

@end
