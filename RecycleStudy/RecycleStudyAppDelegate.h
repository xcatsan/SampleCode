//
//  RecycleStudyAppDelegate.h
//  RecycleStudy
//
//  Created by 湖 on 10/01/25.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RecycleStudyAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet NSTextField* filenameField;
	IBOutlet NSTextField* urlField;
	IBOutlet NSTextField* dupField;
	
	NSURL* originalURL;
	NSURL* newURL;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)generate:(id)sender;
-(IBAction)moveToTrash:(id)sender;
-(IBAction)undo:(id)sender;
-(IBAction)duplicate:(id)sender;

@end
