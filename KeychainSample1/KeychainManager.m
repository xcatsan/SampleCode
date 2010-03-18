//
//  KeychainManager.m
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "KeychainManager.h"

#include <CoreFoundation/CoreFoundation.h>
#include <Security/Security.h>
#include <CoreServices/CoreServices.h>


@implementation KeychainManager

#pragma mark -
#pragma mark Initilizer and Deallocation
static KeychainManager* _sharedManager = nil;

+ (KeychainManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[KeychainManager alloc] init];
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

-(NSString*)getPasswordWithServiceName:(NSString*)serviceName accountName:(NSString*)accountName
{
	OSStatus status;
	
	const char *serviceNameUTF8 = [serviceName UTF8String];
	const char *accountNameUTF8 = [accountName UTF8String];
	
	void *passwordData = nil;
	UInt32 passwordLength;
	SecKeychainItemRef *itemRef = nil;

	status = SecKeychainFindGenericPassword(NULL,
											strlen(serviceNameUTF8),
											serviceNameUTF8,
											strlen(accountNameUTF8),
											accountNameUTF8,
											&passwordLength,
											&passwordData,
											itemRef);

	NSString* password = nil;
	if (status == errSecSuccess) {
		password = [NSString stringWithUTF8String:passwordData];

		status = SecKeychainItemFreeContent(NULL, passwordData);
	} else {
		NSLog(@"ERROR:SecKeychainFindGenericPassword:%d", status);
	}
	
	return password;
}
@end
