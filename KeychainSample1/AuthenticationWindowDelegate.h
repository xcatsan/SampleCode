//
//  AuthenticationWindowDelegate.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/19.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol AuthenticationWindowDelegate

- (BOOL)authenticateWithUsername:(NSString*)username password:(NSString*)password;
-(void)didAuthenticateWithUsername:(NSString*)username result:(BOOL)result;
@end
