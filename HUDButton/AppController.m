//
//  AppController.m
//  HUDButton
//
//  Created by 橋口 湖 on 09/12/29.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "AppController.h"
#import "HUDButton.h"

@implementation AppController

-(void)awakeFromNib
{
	HUDButton* button;
	
	button = [[[HUDButton alloc] initWithFrame:NSMakeRect(50, 50, 0, 0)] autorelease];
	button.title = @"HUDButton2";	
	[[window contentView] addSubview:button];

	button = [[[HUDButton alloc] initWithFrame:NSMakeRect(50, 100, 0, 0)] autorelease];
	button.title = @"日本語ボタン";	
	[[window contentView] addSubview:button];

	button = [[[HUDButton alloc] initWithFrame:NSMakeRect(50, 150, 0, 0)] autorelease];
	button.title = @"OK";	
	[[window contentView] addSubview:button];
	
	button = [[[HUDButton alloc] initWithFrame:NSMakeRect(90, 150, 0, 0)] autorelease];
	button.title = @"Cancel";	
	[[window contentView] addSubview:button];
	
}

@end
