//
//  ActiveSpaceAppDelegate.m
//  ActiveSpace
//
//  Created by 湖 on 09/12/29.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "ActiveSpaceAppDelegate.h"
typedef int             CGSConnection;
extern OSStatus CGSGetWorkspace(const CGSConnection cid, int *workspace);

@implementation ActiveSpaceAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	int spaceNumber = -1;
	int cid=[NSApp contextID];
	CGSGetWorkspace(cid, &spaceNumber);
	NSLog(@"spaceNumber=%d", spaceNumber);
}

@end
