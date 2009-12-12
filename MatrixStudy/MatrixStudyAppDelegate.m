//
//  MatrixStudyAppDelegate.m
//  MatrixStudy
//
//  Created by 湖 on 09/11/29.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "MatrixStudyAppDelegate.h"
#import "MatrixController.h"

@implementation MatrixStudyAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (void)awakeFromNib
{
	viewController = (MatrixController*)[[MatrixController alloc] initWithNibName:@"MatrixView" bundle:nil];
	NSMatrix* matrix = (NSMatrix*)[viewController view];
	[[window contentView] addSubview:matrix];
	
	[matrix addRow];
	[matrix sizeToCells];
}

@end
