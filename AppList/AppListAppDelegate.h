//
//  AppListAppDelegate.h
//  AppList
//
//  Created by 湖 on 10/04/13.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppListAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet NSTableView* tableView_;
	IBOutlet NSArrayController* arrayController_;
	IBOutlet NSTableColumn* tableColumn_;
	
	NSMutableArray* appList_;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) NSMutableArray* appList;

- (IBAction)addApplication:(id)sender;
//- (IBAction)removeApplication:(id)sender;

@end
