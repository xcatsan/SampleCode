//
//  KeychainSample2AppDelegate.m
//  KeychainSample2
//
//  Created by 湖 on 10/03/24.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "KeychainSample2AppDelegate.h"
#import "AuthenticationWindowController.h"
#import "LoginAccount.h"

#define SERVICE_NAME	@"TEST-2"
#define DEFAULT_LOGINID	@"loginId"

@implementation KeychainSample2AppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	authenticationWindowController_ = [[AuthenticationWindowController alloc] init];
	authenticationWindowController_.attachedWindow = window;
}

-(IBAction)connect:(id)sender
{
	LoginAccount* loginAccount = [[[LoginAccount alloc] init] autorelease];

	loginAccount.loginId =
		[[NSUserDefaults standardUserDefaults] valueForKey:DEFAULT_LOGINID];
	loginAccount.serviceName = SERVICE_NAME;

	if ([authenticationWindowController_ storeLoginAccount:loginAccount]) {
		// TODO: send request
		NSLog(@"%@", loginAccount);
		
		// If the request is successful..
		[[NSUserDefaults standardUserDefaults] setValue:loginAccount.loginId
												 forKey:DEFAULT_LOGINID];
	} else {
		// cancel
		NSLog(@"canceled");
	}
}

@end
