//
//  KeychainSample1AppDelegate.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AuthenticationWindowDelegate.h"

@class AuthenticationWindowController;
@interface KeychainSample1AppDelegate : NSObject <NSApplicationDelegate,AuthenticationWindowDelegate> {
    NSWindow *window;
	
	AuthenticationWindowController* authenticationWindowController_;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)connect:(id)sender;
-(IBAction)add:(id)sender;
-(IBAction)get:(id)sender;

@end
