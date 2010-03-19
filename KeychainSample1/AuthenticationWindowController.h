//
//  AuthenticationWindowController.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/18.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AuthenticationWindowDelegate;
@interface AuthenticationWindowController : NSObject {

	IBOutlet NSWindow* window_;

	NSWindow* attachedWindow_;
	NSString* username_;
	NSString* password_;

	AuthenticationWindowDelegate* delegate_;
}

@property (assign) NSWindow* attachedWindow;
@property (copy) NSString* username;
@property (copy) NSString* password;
@property (assign) AuthenticationWindowDelegate* delegate;

- (void)displayAuthenticationWindowWithUsername:(NSString*)username password:(NSString*)password;

-(IBAction)login:(id)sender;
-(IBAction)cancel:(id)cancel;
@end


