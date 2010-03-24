//
//  KeychainManager.m
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "AccountManager.h"
#import "LoginAccount.h"

#include <CoreFoundation/CoreFoundation.h>
#include <Security/Security.h>
#include <CoreServices/CoreServices.h>


@implementation AccountManager

#pragma mark -
#pragma mark Initilizer and Deallocation
static AccountManager* _sharedManager = nil;

+ (AccountManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[AccountManager alloc] init];
	}
	return _sharedManager;
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark -
#pragma mark Store & Get a password

-(BOOL)storePasswordWithServiceName:(NSString*)serviceName accountName:(NSString*)accountName password:(NSString*)password
{
	OSStatus status;
	
	const char *serviceNameUTF8 = [serviceName UTF8String];
	const char *accountNameUTF8 = [accountName UTF8String];
	const char *passwordUTF8 = [password UTF8String];

	status = SecKeychainAddGenericPassword(NULL,
										   strlen(serviceNameUTF8),
										   serviceNameUTF8,
										   strlen(accountNameUTF8),
										   accountNameUTF8,
										   strlen(passwordUTF8),
										   passwordUTF8,
										   NULL);
	if (status == errSecSuccess) {
		return YES;
	} else {
		NSLog(@"ERROR:SecKeychainAddGenericPassword:%d", status);
		return NO;
	}

}

-(BOOL)setPasswordWithLoginAccount:(LoginAccount*)loginAccount
{
	OSStatus status;
	
	const char *serviceNameUTF8 = [loginAccount.serviceName UTF8String];
	const char *loginIdUTF8 = [loginAccount.loginId UTF8String];
	
	void *passwordData = nil;
	UInt32 passwordLength;
	SecKeychainItemRef *itemRef = nil;

	status = SecKeychainFindGenericPassword(NULL,
											strlen(serviceNameUTF8),
											serviceNameUTF8,
											strlen(loginIdUTF8),
											loginIdUTF8,
											&passwordLength,
											&passwordData,
											itemRef);

	if (status == errSecSuccess) {
		loginAccount.password = [NSString stringWithUTF8String:passwordData];

		status = SecKeychainItemFreeContent(NULL, passwordData);
		return YES;

	} else {
		NSLog(@"ERROR:SecKeychainFindGenericPassword:%d", status);
		return NO;
	}
	
}
@end
