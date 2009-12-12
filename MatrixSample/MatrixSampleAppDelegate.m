//
//  MatrixSampleAppDelegate.m
//  MatrixSample
//
//  Created by 湖 on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "MatrixSampleAppDelegate.h"
#import "ApplicationButtonPallete.h"

@implementation MatrixSampleAppDelegate

@synthesize window;

- (void)awakeFromNib {
	// Insert code here to initialize your application 
	
	pallete = [[ApplicationButtonPallete alloc] init];
	pallete.action = @selector(clickAtRow:);
	pallete.target = self;
	
	[pallete setOrigin:NSMakePoint(50, 20)];
	[pallete addToView:[window contentView]];


	// remove test
	[pallete addButtonWithPath:@"/Applications/Preview.app"];
	[pallete addButtonWithPath:@"/Applications/Preview.app"];
	[pallete addButtonWithPath:@"/Applications/Preview.app"];
	[pallete addButtonWithPath:@"/Applications/Preview.app"];
	[pallete removeAll];
	
	 // normal test
	[pallete addButtonWithPath:@"/Applications/Mail.app"];
	[pallete addButtonWithPath:@"/Applications/Preview.app"];
	[pallete addButtonWithPath:@"/Applications/Address Book.app"];
	[pallete addButtonWithPath:@"/Applications/iTunes.app"];
	
}

-(void)clickAtRow:(NSInteger)row
{
	NSLog(@"clickAtRow: %d", row);
}
@end
