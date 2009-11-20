//
//  AppController.m
//  ViewControllerStudy
//

#import "AppController.h"
#import "ImageFile.h"

@implementation AppController

- (void)awakeFromNib
{
	imageFile = [[ImageFile alloc] init];
	imageFile.image = [NSImage imageNamed:@"sample"];
	imageFile.name = @"sample.jpg";
	imageFile.date = [NSDate date];
	
	viewController = [[NSViewController alloc] initWithNibName:@"SampleView" bundle:nil];
	[viewController setRepresentedObject:imageFile];
	[view addSubview:[viewController view]];
}

@end
