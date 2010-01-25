//
//  RecycleStudyAppDelegate.m
//  RecycleStudy
//
//  Created by 湖 on 10/01/25.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "RecycleStudyAppDelegate.h"

@implementation RecycleStudyAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	NSString* path = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [path stringByAppendingPathComponent:@"RecycleSample.plist"];
	
	originalURL = [[NSURL alloc] initFileURLWithPath:path];
}

-(IBAction)generate:(id)sender
{
	NSDictionary* sampleDict = [NSDictionary
		dictionaryWithObjectsAndKeys:[NSDate date], @"now", nil];
	[sampleDict writeToURL:originalURL atomically:YES];
	[filenameField setStringValue:[originalURL description]];
}

-(IBAction)moveToTrash:(id)sender
{
	NSArray* urls = [NSArray arrayWithObject:originalURL];

	[[NSWorkspace sharedWorkspace] recycleURLs:urls
		 completionHandler:^(NSDictionary *newURLs, NSError *error) {
			 if (error != nil) {
				 NSLog(@"error: %@", error);
			 } else {
				 NSLog(@"newURLs: %@", newURLs);
				 newURL = [[newURLs objectForKey:originalURL] retain];
				 [urlField setStringValue:[newURL description]];
			 }
		 }];
}

-(IBAction)undo:(id)sender
{
	NSError* error = nil;
	BOOL result = [[NSFileManager defaultManager]
				   moveItemAtURL:newURL toURL:originalURL error:&error];
	if (!result) {
		NSLog(@"error: %@", error);
	}
}

-(IBAction)duplicate:(id)sender
{
	NSArray* urls = [NSArray arrayWithObject:originalURL];

	[[NSWorkspace sharedWorkspace] duplicateURLs:urls
	   completionHandler:^(NSDictionary *newURLs, NSError *error) {
		   if (error != nil) {
			   NSLog(@"error: %@", error);
		   } else {
			   NSLog(@"newURLs: %@", newURLs);
			   NSURL* url = [newURLs objectForKey:originalURL];
			   [dupField setStringValue:[url description]];
		   }
	   }];
}

@end
