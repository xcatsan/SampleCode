//
//  AutostartOnLoginAppDelegate.h
//  AutostartOnLogin
//
//  Created by 湖 on 09/11/11.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AutostartOnLoginAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet NSButton* _checkbox;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)check:(id)sender;

@end
