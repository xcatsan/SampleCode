//
//  AuthenticationWindowController.m
//  KeychainSample1
//
//  Created by 湖 on 10/03/18.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "AuthenticationWindowController.h"
#import "KeychainManager.h"
#import "AuthenticationWindowDelegate.h"

#define SERVICE_NAME		@"TEST-1"

@implementation AuthenticationWindowController

@synthesize attachedWindow = attachedWindow_;
@synthesize username = username_;
@synthesize password = password_;
@synthesize delegate = delegate_;

#pragma mark -
#pragma mark Initilizer and Deallocation
-(id)init
{
	self = [super init];
	if (self) {
		if (![NSBundle loadNibNamed:@"AuthenticationWindow"
							 owner:self]) {
			self = nil;
		}
	}
	return self;

}

- (void) dealloc
{
	self.username = nil;
	self.password = nil;

	[super dealloc];
}


#pragma mark -
#pragma mark Control authentication flow
- (void)displayAuthenticationWindowWithUsername:(NSString*)username password:(NSString*)password
{
	if (username) {
		self.username = username;
	}
	if (password) {
		self.password = password;
	}
	
	[NSApp beginSheet:window_
	   modalForWindow:attachedWindow_
		modalDelegate:self
	   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
		  contextInfo:nil];
}

-(IBAction)login:(id)sender
{
	[NSApp endSheet:window_];
	[window_ orderOut:nil];

	BOOL result = [self.delegate authenticateWithUsername:self.username
												 password:self.password];
	
	if (result) {
		result = [[KeychainManager sharedManager]
				  storePasswordWithServiceName:SERVICE_NAME
				  accountName:self.username
				  password:self.password];
		
		[self.delegate didAuthenticateWithUsername:self.username result:YES];
		
	} else {
		[self displayAuthenticationWindowWithUsername:self.username
											 password:self.password];
	}
}

-(IBAction)cancel:(id)cancel
{
	[NSApp endSheet:window_];
	[window_ orderOut:nil];
	
	[self.delegate didAuthenticateWithUsername:self.username result:NO];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
}

@end
