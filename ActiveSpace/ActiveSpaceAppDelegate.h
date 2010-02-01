//
//  ActiveSpaceAppDelegate.h
//  ActiveSpace
//
//  Created by 湖 on 09/12/29.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ActiveSpaceAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
