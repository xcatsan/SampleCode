//
//  KeychainSample1AppDelegate.m
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "KeychainSample1AppDelegate.h"
#import "KeychainManager.h"

#define SERVICE_NAME	@"TEST-1"

@implementation KeychainSample1AppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (void)displayAuthenticationWindowWithUsername:(NSString*)username password:(NSString*)password
{
	if (username) {
		[usernameText setStringValue:username];
	}
	if (password) {
		[passwordText setStringValue:password];
	}
	
	[NSApp beginSheet:authenticateWindow
	   modalForWindow:window
		modalDelegate:self
	   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
		  contextInfo:nil];
}

- (BOOL)authenticateWithUsername:(NSString*)username password:(NSString*)password
{
	NSLog(@"authenticateWithUsername:%@ password:%@",
		  username, password);
	return YES;
}

-(void)didAuthenticate:(BOOL)result
{
	NSLog(@"didAuthenticate: %d", result);
}


-(IBAction)login:(id)sender
{
	[NSApp endSheet:authenticateWindow];
	[authenticateWindow orderOut:nil];
	
	NSString* username = [usernameText stringValue];
	NSString* password = [passwordText stringValue];
	BOOL result = [self authenticateWithUsername:username
										password:password];
	
	if (result) {
		[[NSUserDefaults standardUserDefaults] setValue:username
												 forKey:@"username"];
		result = [[KeychainManager sharedManager]
				  storePasswordWithServiceName:SERVICE_NAME
								   accountName:username
									  password:password];
		
		[self didAuthenticate:YES];

	} else {
		[self displayAuthenticationWindowWithUsername:username
											 password:password];
	}
}

-(IBAction)cancel:(id)cancel
{
	[NSApp endSheet:authenticateWindow];
	[authenticateWindow orderOut:nil];
	
	[self didAuthenticate:NO];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
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
	
	[self displayAuthenticationWindowWithUsername:username
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

@end
