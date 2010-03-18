//
//  KeychainManager.h
//  KeychainSample1
//
//  Created by 湖 on 10/03/11.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KeychainManager : NSObject {

}

+ (KeychainManager*)sharedManager;
-(BOOL)storePasswordWithServiceName:(NSString*)serviceName accountName:(NSString*)accountName password:(NSString*)password;

-(NSString*)getPasswordWithServiceName:(NSString*)serviceName accountName:(NSString*)accountName;

@end
