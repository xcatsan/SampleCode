//
//  KeychainSample2AppDelegate.h
//  KeychainSample2
//
//  Created by 湖 on 10/03/24.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AuthenticationWindowController;

@interface KeychainSample2AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	AuthenticationWindowController* authenticationWindowController_;
}

-(IBAction)connect:(id)sender;
-(IBAction)delete:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
