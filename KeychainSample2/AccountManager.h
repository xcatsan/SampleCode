//
//  KeychainManager.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LoginAccount;
@interface AccountManager : NSObject {

}

+ (AccountManager*)sharedManager;
- (BOOL)setPasswordToLoginAccount:(LoginAccount*)loginAccount;
- (BOOL)storeLoginAccount:(LoginAccount*)loginAccount;
- (BOOL)deleteLoginAccount:(LoginAccount*)loginAccount;
@end
