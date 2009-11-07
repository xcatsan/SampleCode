//
//  PluginController.m
//  SafariPlugInStudy
//
//

#import "PluginController.h"
#import "SXSafariContextMenuSwizzler.h"
#import "SXSafariToolbarSwizzler.h"

#import <WebKit/WebKit.h>

#pragma mark -
#pragma mark Swizzling

@implementation PluginController
#pragma mark -
#pragma mark Entry point

static BOOL initialized_flag = NO;
//+(void)load
+ (void)initialize
{
	if (!initialized_flag) {
		initialized_flag = YES;
		[SXSafariContextMenuSwizzler setup];
		[SXSafariToolbarSwizzler setup];
		
		/*
		NSDocumentController* dc = [NSDocumentController sharedDocumentController];
		NSLog(@"NSDocumentController: %@", dc);
		NSLog(@"documents: %@", [dc documents]);
		NSLog(@"current: %@", [dc currentDocument]);
		*/
		NSLog(@"+[PluginController load] was called");
	}
}

@end
