//
//  AppController.m
//  UUIDSample
//

#import "AppController.h"


@implementation AppController

- (NSString*) stringWithUUID {
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString	*uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString autorelease];
}

-(IBAction)createUUID:(id)sender
{
	[textView insertText:[self stringWithUUID]];
	[textView insertText:@"\n"];
}

-(IBAction)useProcessInfo:(id)sender
{
	[textView insertText:[[NSProcessInfo processInfo] globallyUniqueString]];
	[textView insertText:@"\n"];
}

@end
