//
//  AutostartOnLoginAppDelegate.m
//  AutostartOnLogin
//
//  Created by 湖 on 09/11/11.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "AutostartOnLoginAppDelegate.h"

@implementation AutostartOnLoginAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	[_checkbox setIntValue:0];
}

- (void)enableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(CFURLRef)thePath
{
	LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(theLoginItemsRefs, kLSSharedFileListItemLast, NULL, NULL, thePath, NULL, NULL);		
	if (item)
	{
		CFRelease(item);
	}
}

- (void)disableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(CFURLRef)thePath
{
	UInt32 seedValue;
	NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(theLoginItemsRefs, &seedValue);
	for (id item in loginItemsArray)
	{		
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &thePath, NULL) == noErr)
		{
			if ([[(NSURL *)thePath path] hasPrefix:[[NSBundle mainBundle] bundlePath]])
				LSSharedFileListItemRemove(theLoginItemsRefs, itemRef);
		}
	}
	[loginItemsArray release];
}


-(IBAction)check:(id)sender
{
	NSString* applicationPath = [[NSBundle mainBundle] bundlePath];
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: applicationPath];

	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);

	if ([sender intValue] == 1) {
		// add
		[self enableLoginItemWithLoginItemsReference:loginItems ForPath:url];
	} else {
		// remove
		[self disableLoginItemWithLoginItemsReference:loginItems ForPath:url];
	}
	CFRelease(loginItems);
}

@end
