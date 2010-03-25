//
//  AuthenticationWindowController.m
//  KeychainSample1
//
//  Created by 湖 on 10/03/18.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "AuthenticationWindowController.h"
#import "AccountManager.h"
#import "LoginAccount.h"

@implementation AuthenticationWindowController

@synthesize attachedWindow = attachedWindow_;
@synthesize loginId = loginId_;
@synthesize password = password_;
@synthesize message = message_;

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
	self.loginId = nil;
	self.password = nil;
	self.message = nil;

	[super dealloc];
}


#pragma mark -
#pragma mark Public accessors
-(BOOL)storeLoginAccount:(LoginAccount*)loginAccount
{
	if (loginAccount.loginId) {
		self.loginId = loginAccount.loginId;
		if (!loginAccount.password) {
			if ([[AccountManager sharedManager]
				 setPasswordToLoginAccount:loginAccount]) {
				self.password = loginAccount.password;
			}
		}
	}
	
	[window_ makeFirstResponder:loginIdTextField_];
	self.message = @"";

	[NSApp beginSheet:window_
	   modalForWindow:attachedWindow_
		modalDelegate:nil
	   didEndSelector:nil
		  contextInfo:nil];
	[NSApp runModalForWindow:window_];
	
	// dialog is up here (wait for closing)

	[NSApp endSheet:window_];
	[window_ orderOut:nil];
	
	if (!is_canceled_) {
		loginAccount.loginId = self.loginId;
		loginAccount.password = self.password;
		
		[[AccountManager sharedManager] storeLoginAccount:loginAccount];
		return YES;

	} else {
		return NO;
	}
}

-(IBAction)login:(id)sender
{
	/*
	NSString* loginId = [loginIdTextField_ stringValue];
	NSString* password = [passwordTextField_ stringValue];
	
	if (!loginId  || [loginId length] == 0) {
		self.message = @"Username is empty";
		[window_ makeFirstResponder:loginIdTextField_];
		return;
	}
	if (!password || [password length] == 0) {
		self.message = @"Password is empty";
		[window_ makeFirstResponder:passwordTextField_];
		return;
	}
	 */
	if (!self.loginId  || [self.loginId length] == 0) {
		self.message = @"Username is empty";
		[window_ makeFirstResponder:loginIdTextField_];
		return;
	}
	if (!self.password || [self.password length] == 0) {
		self.message = @"Password is empty";
		[window_ makeFirstResponder:passwordTextField_];
		return;
	}
	
	is_canceled_ = NO;
	[NSApp stopModal];
}

-(IBAction)cancel:(id)cancel
{
	is_canceled_ = YES;
	[NSApp stopModal];
}

@end
