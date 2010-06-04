//
//  AppListAppDelegate.m
//  AppList
//
//  Created by 湖 on 10/04/13.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "AppListAppDelegate.h"

#import "ApplicationEntry.h"
#import "ApplicationCell.h"
#define AppListTableViewDataType @"AppListTableViewDataType"
#define UDKEY_HELPER_APPLICATION_LIST	@"HelperApplicationList"
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
#pragma mark Utilities
- (void)rearrangeList
{
	[arrayController_ rearrangeObjects];
	
	NSUserDefaults* userDefaults =
	[[NSUserDefaultsController sharedUserDefaultsController] values];
	
	NSMutableArray* pathList = [NSMutableArray array];
	for (ApplicationEntry* entry in appList_) {
		[pathList addObject:entry.path];
	}
	[userDefaults setValue:pathList forKey:UDKEY_HELPER_APPLICATION_LIST];
}


#pragma mark -
#pragma mark Application Delegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 

	NSUserDefaults* userDefaults =
	[[NSUserDefaultsController sharedUserDefaultsController] values];
	NSArray* pathList = [userDefaults valueForKey:UDKEY_HELPER_APPLICATION_LIST];
	for (NSString* path in pathList) {
		[appList_ addObject:[[[ApplicationEntry alloc] initWithPath:path] autorelease]];
	}
	[arrayController_ rearrangeObjects];

	[tableView_ registerForDraggedTypes:
	 [NSArray arrayWithObjects:
	  NSFilenamesPboardType, AppListTableViewDataType, nil]];
	
	[tableColumn_ setDataCell:[[[ApplicationCell alloc] init] autorelease]];
}

#pragma mark -
#pragma mark Accssors
- (IBAction)addApplication:(id)sender
{
	NSString* path = @"/Applications";
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanChooseDirectories:NO];
	[openPanel setCanCreateDirectories:NO];
	[openPanel setAllowsMultipleSelection:YES];
	[openPanel setDirectory:path];

	int result = [openPanel runModalForDirectory:path
											file:nil
										   types:nil];
	
	if (result == NSOKButton) {
		for (NSString* filename in [openPanel filenames]) {
			ApplicationEntry* entry = [[[ApplicationEntry alloc] initWithPath:filename] autorelease];
			
			[appList_ addObject:entry];
		}
		[self rearrangeList];
	}
	
	/*
	[openPanel beginSheetForDirectory:path
								 file:nil
								types:nil
					   modalForWindow:window
						modalDelegate:self
					   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
						  contextInfo:nil];
	
	*/
}
/*
- (void)openPanelDidEnd:(NSOpenPanel *)panel returnCode:(int)returnCode  contextInfo:(void  *)contextInfo
{
	if (returnCode == NSOKButton) {
		for (NSString* filename in [panel filenames]) {
			ApplicationEntry* entry = [[[ApplicationEntry alloc] initWithPath:filename] autorelease];
			
			[appList_ addObject:entry];
		}
		[arrayController_ rearrangeObjects];
	}
}
*/

#pragma mark -
#pragma mark NSTableViewDataSource Protocol
- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard
{
	NSLog(@"drag starts");
    // Copy the row numbers to the pasteboard.
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:[NSArray arrayWithObject:AppListTableViewDataType] owner:self];
    [pboard setData:data forType:AppListTableViewDataType];
    return YES;
}

- (NSDragOperation)tableView:(NSTableView *)aTableView validateDrop:(id < NSDraggingInfo >)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation
{
	[aTableView setDropRow:row dropOperation:NSTableViewDropAbove];
	
	if ([info draggingSource] == tableView_) {
		return NSDragOperationMove;
	} 
	return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info
			  row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation
{
    NSPasteboard* pboard = [info draggingPasteboard];	
	NSArray* pboardTypes = [pboard types];

	if ([pboardTypes containsObject:AppListTableViewDataType]) {

		NSData* data = [pboard dataForType:AppListTableViewDataType];
		
		NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:data];

		NSArray* srcArray = [appList_ objectsAtIndexes:rowIndexes];
		NSUInteger srcCount = [srcArray count];

		if ([rowIndexes firstIndex] < row) {
			row = row - srcCount;
		}
		NSIndexSet* newIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row, srcCount)];

		[appList_ removeObjectsAtIndexes:rowIndexes];
		[appList_ insertObjects:srcArray atIndexes:newIndexes];
		[self rearrangeList];

		
//		[arrayController_ removeObjectsAtArrangedObjectIndexes:rowIndexes];
//		[arrayController_ insertObjects:srcArray atArrangedObjectIndexes:newIndexes];
		return YES;

	} else if ([pboardTypes containsObject:NSFilenamesPboardType]) {
		NSArray*filenames = [pboard propertyListForType:NSFilenamesPboardType];

		for (NSString* filename in filenames) {
			ApplicationEntry* entry = [[[ApplicationEntry alloc] initWithPath:filename] autorelease];

			[appList_ insertObject:entry atIndex:row];
//			[arrayController_ insertObject:entry atArrangedObjectIndex:row];
		}
		[self rearrangeList];
		return YES;
	} else {
		return NO;
	}
}
@end
