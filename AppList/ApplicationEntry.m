//
//  ApplicationEntry.m
//  AppList
//
//  Created by 湖 on 10/04/13.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationEntry.h"


@implementation ApplicationEntry

@synthesize name, path, icon;

-(void)setPath:(NSString *)aPath
{
	[aPath retain];
	[path release];
	path = aPath;
	
	LSCopyDisplayNameForURL((CFURLRef)[NSURL fileURLWithPath:path], (CFStringRef *)&name);
	
	if (!name) {
		name = @"(not found)";
	}
}

@end
