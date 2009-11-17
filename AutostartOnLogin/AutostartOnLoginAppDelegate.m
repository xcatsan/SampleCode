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

- (BOOL)isEnableLoginItem
{
	BOOL is_enable = NO;
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]];
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	
	UInt32 seedValue;
	NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);
	for (id item in loginItemsArray)
	{		
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr)
		{
			if ([[(NSURL *)url path] hasPrefix:[[NSBundle mainBundle] bundlePath]]) {
				is_enable = YES;
				break;
			}
		}
	}
	[loginItemsArray release];
	CFRelease(loginItems);
	
	return is_enable;
}

- (void)enableLoginItem
{
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]];

	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);		
	if (item)
	{
		CFRelease(item);
	}
	CFRelease(loginItems);
}

- (void)disableLoginItem
{
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]];
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	UInt32 seedValue;
	NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);
	for (id item in loginItemsArray)
	{		
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr)
		{
			if ([[(NSURL *)url path] hasPrefix:[[NSBundle mainBundle] bundlePath]]) {
				LSSharedFileListItemRemove(loginItems, itemRef);
				break;
			}
		}
	}
	[loginItemsArray release];
	CFRelease(loginItems);
}


-(IBAction)check:(id)sender
{

	if ([sender intValue] == 1) {
		// add
		[self enableLoginItem];
	} else {
		// remove
		[self disableLoginItem];
	}
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 

	if ([self isEnableLoginItem]) {
		[_checkbox setIntValue:1];
	} else {
		[_checkbox setIntValue:0];
	}
}


@end
