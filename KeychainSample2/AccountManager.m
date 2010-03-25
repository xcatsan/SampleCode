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

- (BOOL)storeLoginAccount:(LoginAccount*)loginAccount
{
	OSStatus status;
	SecKeychainItemRef itemRef = nil;
	BOOL result = NO;

	const char *serviceNameUTF8 = [loginAccount.serviceName UTF8String];
	const char *loginIdUTF8 = [loginAccount.loginId UTF8String];
	const char *passwordUTF8 = [loginAccount.password UTF8String];

	status = SecKeychainFindGenericPassword(NULL,
											strlen(serviceNameUTF8),
											serviceNameUTF8,
											strlen(loginIdUTF8),
											loginIdUTF8,
											NULL,
											NULL,
											&itemRef);
	
	if (status == errSecItemNotFound) {
		status = SecKeychainAddGenericPassword(NULL,
											   strlen(serviceNameUTF8),
											   serviceNameUTF8,
											   strlen(loginIdUTF8),
											   loginIdUTF8,
											   strlen(passwordUTF8),
											   passwordUTF8,
											   NULL);
		if (status == errSecSuccess) {
			NSLog(@"created keychain item");
			result = YES;
		} else {
			NSLog(@"ERROR:SecKeychainAddGenericPassword:%d", status);
			result = NO;
		}

	} else {
		status = SecKeychainItemModifyAttributesAndData(itemRef,
														NULL,
														strlen(passwordUTF8),
														passwordUTF8);
		
		if (status == errSecSuccess) {
			NSLog(@"updated keychain item");
			result = YES;
		} else {
			NSLog(@"ERROR:SecKeychainItemModifyAttributesAndData:%d", status);
			result = NO;
		}
	}
	
	if (itemRef) {
		CFRelease(itemRef);
	}

	return result;
}

-(BOOL)setPasswordToLoginAccount:(LoginAccount*)loginAccount
{
	OSStatus status;
	
	const char *serviceNameUTF8 = [loginAccount.serviceName UTF8String];
	const char *loginIdUTF8 = [loginAccount.loginId UTF8String];
	
	void *passwordData = nil;
	UInt32 passwordLength;

	status = SecKeychainFindGenericPassword(NULL,
											strlen(serviceNameUTF8),
											serviceNameUTF8,
											strlen(loginIdUTF8),
											loginIdUTF8,
											&passwordLength,
											&passwordData,
											NULL);

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
