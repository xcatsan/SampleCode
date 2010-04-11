//
//  CascadingWindowsAppDelegate.h
//  CascadingWindows
//
//  Created by 湖 on 10/04/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CascadingWindowsAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	NSPoint nextTopLeft;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)createWindow:(id)sender;

@end
