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

#pragma mark -
#pragma mark Initialization & Deallocation
-(id)initWithPath:(NSString*)aPath;
{
	self = [super init];
	if (self != nil) {
		self.path = aPath;
		NSString* appName;
		LSCopyDisplayNameForURL((CFURLRef)[NSURL fileURLWithPath:path], (CFStringRef *)&appName);
		
		if (!appName) {
			appName = @"(not found)";
		}
		self.name = appName;
		
		self.icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
		[icon setSize:NSMakeSize(16, 16)];
	}
	return self;
}

- (void) dealloc
{
	self.path = nil;
	self.name = nil;
	self.icon = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (id)copyWithZone:(NSZone *)zone
{
	ApplicationEntry* entry = [[[self class] allocWithZone:zone] init];
	
	entry.path = [path copyWithZone:zone];
	entry.name = [name copyWithZone:zone];
	entry.icon = [icon copyWithZone:zone];
	
	return entry;
}

@end
