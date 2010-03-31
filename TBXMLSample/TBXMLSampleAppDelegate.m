//
//  TBXMLSampleAppDelegate.m
//  TBXMLSample
//
//  Created by 湖 on 10/03/31.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "TBXMLSampleAppDelegate.h"
#import "TBXML.h"

@implementation TBXMLSampleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (void)parseWithXMLFile:(NSString*)filename
{
	TBXML* tbxml = [TBXML tbxmlWithXMLFile:filename];

	TBXMLElement *element = tbxml.rootXMLElement;
	
	NSMutableDictionary* elements = [NSMutableDictionary dictionary];

	if (element) {
		NSString* status = [TBXML valueOfAttributeNamed:@"status"
											 forElement:element];

		if (status) {
			if ([status isEqualToString:@"ok"]) {
				element = element->firstChild;

				do {
					NSString* key = [TBXML elementName:element];
					NSString* object = [TBXML textForElement:element];
					[elements setObject:object forKey:key];

				} while (element = element->nextSibling);

				NSLog(@"ok: %@", elements);

			} else {
				// fail
				element = element->firstChild;
				if (element) {
					NSString* errorCode = [TBXML valueOfAttributeNamed:@"code"
												forElement:element];
					NSString* errorMsg = [TBXML valueOfAttributeNamed:@"msg"
												forElement:element];
					NSLog(@"fail: code=%@, msg=%@", errorCode, errorMsg);
				}
			}
		} else {
			// error
		}
	}
}
- (IBAction)parse1:(id)sender
{
	[self parseWithXMLFile:@"sample.xml"];
}

- (IBAction)parse2:(id)sender
{
	[self parseWithXMLFile:@"error.xml"];
}

@end
