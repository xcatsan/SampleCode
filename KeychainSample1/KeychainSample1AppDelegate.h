//
//  KeychainSample1AppDelegate.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KeychainSample1AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet NSWindow* authenticateWindow;
	IBOutlet NSTextField* usernameText;
	IBOutlet NSSecureTextField* passwordText;	
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)connect:(id)sender;
-(IBAction)add:(id)sender;
-(IBAction)get:(id)sender;

-(IBAction)login:(id)sender;
-(IBAction)cancel:(id)cancel;


@end
