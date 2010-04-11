//
//  CascadingWindowsAppDelegate.m
//  CascadingWindows
//
//  Created by 湖 on 10/04/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "CascadingWindowsAppDelegate.h"

@implementation CascadingWindowsAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	nextTopLeft = [window cascadeTopLeftFromPoint:NSZeroPoint];
}


- (IBAction)createWindow:(id)sender
{
	NSRect rect = NSMakeRect(0, 0, 320, 200);
	NSWindow* w = [[NSWindow alloc]
				   initWithContentRect:rect
				   styleMask:NSTitledWindowMask
				   backing:NSBackingStoreBuffered
				   defer:NO];
	nextTopLeft = [w cascadeTopLeftFromPoint:nextTopLeft];
	[w setTitle:NSStringFromPoint(nextTopLeft)];
	[w  makeKeyAndOrderFront:nil];
}

@end
