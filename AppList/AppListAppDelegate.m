//
//  AppListAppDelegate.m
//  AppList
//
//  Created by 湖 on 10/04/13.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "AppListAppDelegate.h"

#import "ApplicationEntry.h"

@implementation AppListAppDelegate

@synthesize window;
@synthesize appList = appList_;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.appList = [NSMutableArray array];
		
		/*
		// TEST
		ApplicationEntry* entry;
		
		entry = [[[ApplicationEntry alloc] init] autorelease];
		entry.name = @"APPLICATION-1";
		[self.appList addObject:entry];

		entry = [[[ApplicationEntry alloc] init] autorelease];
		entry.name = @"APPLICATION-2";
		[self.appList addObject:entry];

		entry = [[[ApplicationEntry alloc] init] autorelease];
		entry.name = @"APPLICATION-3";
		[self.appList addObject:entry];
		 */
	}
	return self;
}
- (void) dealloc
{
	self.appList = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Application Delegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	[tableView_ registerForDraggedTypes:
	 [NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

#pragma mark -
#pragma mark Accssors
- (IBAction)addApplication:(id)sender
{
	NSLog(@"-");
	NSString* path = @"/Applications";
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanChooseDirectories:NO];
	[openPanel setCanCreateDirectories:YES];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel setDirectory:path];
	
	int result = [openPanel runModal];
	
	NSLog(@"result=%d", result);
}

- (IBAction)removeApplication:(id)sender
{
}

#pragma mark -
#pragma mark NSTableViewDataSource Protocol
- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op
{
    return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info
			  row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation
{
    NSPasteboard* pboard = [info draggingPasteboard];
	NSArray*filenames = [pboard propertyListForType:NSFilenamesPboardType];

	for (NSString* filename in filenames) {
		ApplicationEntry* entry = [[[ApplicationEntry alloc] init] autorelease];
		entry.path = filename;
//		entry.name = [filename lastPathComponent];
		[arrayController_ insertObject:entry atArrangedObjectIndex:row];
	}

	return YES;
}
@end
