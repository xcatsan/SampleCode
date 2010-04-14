//
//  KeychainSample2AppDelegate.m
//  KeychainSample2
//
//  Created by 湖 on 10/03/24.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "KeychainSample2AppDelegate.h"
#import "AuthenticationWindowController.h"
#import "LoginAccount.h"

#import "ASIFormDataRequest.h"
#import "TBXML.h"

#define SERVICE_NAME	@"TEST-2"
#define DEFAULT_LOGINID	@"loginId"

@implementation KeychainSample2AppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	authenticationWindowController_ = [[AuthenticationWindowController alloc] init];
	authenticationWindowController_.attachedWindow = window;
}

- (BOOL)parseWithResponseString:(NSString*)responseString toDictionary:(NSMutableDictionary*)dictionary
{
	BOOL result = NO;

	TBXML* tbxml = [TBXML tbxmlWithXMLString:responseString];
	
	TBXMLElement *element = tbxml.rootXMLElement;
	
	if (element) {
		NSString* status = [TBXML valueOfAttributeNamed:@"status"
											 forElement:element];
		NSString* stat = [TBXML valueOfAttributeNamed:@"stat"
											 forElement:element];
		
		if (status && [status isEqualToString:@"ok"]) {
				element = element->firstChild;
				
				do {
					NSString* key = [TBXML elementName:element];
					NSString* object = [TBXML textForElement:element];
					[dictionary setObject:object forKey:key];
					
				} while (element = element->nextSibling);
				
				result = true;
				
		} else if (stat && [stat isEqualToString:@"fail"]) {
			// fail
			element = element->firstChild;
			if (element) {
				NSString* errorCode = [TBXML valueOfAttributeNamed:@"code"
														forElement:element];
				NSString* errorMsg = [TBXML valueOfAttributeNamed:@"msg"
													   forElement:element];
				[dictionary setObject:errorCode forKey:@"errorCode"];
				[dictionary setObject:errorMsg forKey:@"errorMsg"];
			}
		} else {
			// error
			[dictionary setObject:@"-1" forKey:@"errorCode"];
			[dictionary setObject:@"[internal]parse error" forKey:@"errorMsg"];
		}
	}
	return result;
}


-(IBAction)connect:(id)sender
{
	LoginAccount* loginAccount = [[[LoginAccount alloc] init] autorelease];

	loginAccount.loginId =
		[[NSUserDefaults standardUserDefaults] valueForKey:DEFAULT_LOGINID];
	loginAccount.serviceName = SERVICE_NAME;
	
	NSMutableDictionary* response = [NSMutableDictionary dictionary];

	if ([authenticationWindowController_ getLoginAccount:loginAccount]) {

		// TODO: send request
		NSURL *url = [NSURL URLWithString:@"http://twitpic.com/api/uploadAndPost"];
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		[request setPostValue:loginAccount.loginId forKey:@"username"];
		[request setPostValue:loginAccount.password forKey:@"password"];
		NSString* filepath = [[NSBundle mainBundle] pathForImageResource:@"sample"];
		NSLog(@"filepath=%@", filepath);
		[request setFile:filepath forKey:@"media"];
		
		NSString* msg = [NSString stringWithFormat:@"Hello, %@", [NSDate date]];
		[request setPostValue:msg forKey:@"message"];
		[request startSynchronous];

		NSError* error = [request error];
		BOOL result = NO;
		if (!error) {
			result = [self parseWithResponseString:[request responseString]
							 toDictionary:response];
		} else {
			NSLog(@"error: %@", error);
		}


		NSLog(@"result=%d, %@", result, response);
		NSLog(@"%@", loginAccount);
		
		// If the request is successful..
		[[NSUserDefaults standardUserDefaults] setValue:loginAccount.loginId
												 forKey:DEFAULT_LOGINID];
	} else {
		// cancel
		NSLog(@"canceled");
	}
}

-(IBAction)delete:(id)sender
{
	LoginAccount* loginAccount = [[[LoginAccount alloc] init] autorelease];
	
	loginAccount.loginId =
	[[NSUserDefaults standardUserDefaults] valueForKey:DEFAULT_LOGINID];
	loginAccount.serviceName = SERVICE_NAME;
	
	[authenticationWindowController_ deleteLoginAccount:loginAccount];
	
	NSLog(@"deleted");
}

@end
