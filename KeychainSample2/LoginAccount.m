//
//  Account.m
//  KeychainSample2
//
//  Created by 湖 on 10/03/24.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "LoginAccount.h"


@implementation LoginAccount

@synthesize serviceName,loginId, password;

- (void) dealloc
{
	self.serviceName = nil;
	self.loginId = nil;
	self.password = nil;

	[super dealloc];
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@: %@/%@",
			self.serviceName, self.loginId, self.password];
}
@end
