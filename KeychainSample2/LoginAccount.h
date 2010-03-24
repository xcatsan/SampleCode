//
//  Account.h
//  KeychainSample2
//
//  Created by 湖 on 10/03/24.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LoginAccount : NSObject {

	NSString* serviceName;
	NSString* loginId;
	NSString* password;
}

@property (copy) NSString* serviceName;
@property (copy) NSString* loginId;
@property (copy) NSString* password;

@end
