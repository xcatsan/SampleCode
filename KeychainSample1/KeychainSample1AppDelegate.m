//
//  KeychainSample1AppDelegate.m
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "KeychainSample1AppDelegate.h"
#import "KeychainManager.h"
#import "AuthenticationWindowController.h"

#define SERVICE_NAME	@"TEST-1"

@implementation KeychainSample1AppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	authenticationWindowController_ = [[AuthenticationWindowController alloc] init];
	authenticationWindowController_.delegate = (AuthenticationWindowDelegate*)self;
	authenticationWindowController_.attachedWindow = window;
}

-(IBAction)connect:(id)sender
{
	NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];

	NSString *password = nil;
	
	if (username) {
		password = [[KeychainManager sharedManager]
					getPasswordWithServiceName:SERVICE_NAME
								   accountName:username];
	}
	
	[authenticationWindowController_ displayAuthenticationWindowWithUsername:username
										 password:password];
	
}

-(IBAction)add:(id)sender
{
	BOOL result = [[KeychainManager sharedManager]
				   storePasswordWithServiceName:SERVICE_NAME
									accountName:@"hashiguchi"
									    password:@"1234567"];
	
	NSLog(@"result=%d", result);
}

-(IBAction)get:(id)sender
{
	NSString* password = [[KeychainManager sharedManager]
						  getPasswordWithServiceName:@"TEST-1"
						  accountName:@"hashiguchi"];
	NSLog(@"password=%@", password);
}

- (BOOL)authenticateWithUsername:(NSString*)username password:(NSString*)password
{
	NSLog(@"authenticateWithUsername:%@ password:%@",
		  username, password);
	return YES;
}

-(void)didAuthenticateWithUsername:(NSString*)username result:(BOOL)result
{
	NSLog(@"didAuthenticate: %d", result);
	if (result) {
		 [[NSUserDefaults standardUserDefaults] setValue:username
		 forKey:@"username"];
	}		
}

@end
