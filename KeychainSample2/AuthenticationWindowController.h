//
//  AuthenticationWindowController.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/18.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LoginAccount;
@interface AuthenticationWindowController : NSObject {

	IBOutlet NSWindow* window_;
	IBOutlet NSTextField* loginIdTextField_;
	IBOutlet NSSecureTextField* passwordTextField_;

	NSWindow* attachedWindow_;
	NSString* loginId_;
	NSString* password_;

	NSString* message_;
	
	BOOL is_canceled_;

}

@property (assign) NSWindow* attachedWindow;
@property (copy) NSString* loginId;
@property (copy) NSString* password;

@property (retain) NSString* message;

-(BOOL)storeLoginAccount:(LoginAccount*)loginAccount;

-(IBAction)login:(id)sender;
-(IBAction)cancel:(id)cancel;
@end


