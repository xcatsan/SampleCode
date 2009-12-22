//
//  CustomView.m
//  NSDrawThreePartImageStudy
//
//  Created by 湖 on 09/12/23.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "CustomView.h"


@implementation CustomView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.

	if (!startCap) {
		NSString* safariPath = @"/Applications/Safari.app/Contents/Resources";
		startCap = [[NSImage alloc] initWithContentsOfFile:[safariPath stringByAppendingPathComponent:@"PurplePopUpLeft.png"]];
		centerFill = [[NSImage alloc] initWithContentsOfFile:[safariPath stringByAppendingPathComponent:@"PurplePopUpFill.png"]];
		endCap = [[NSImage alloc] initWithContentsOfFile:[safariPath stringByAppendingPathComponent:@"PurplePopUpRight.png"]];
	}
	
	CGFloat margin = 20.0;
	
	NSRect frame = [self frame];
	frame.origin.x += margin;
	frame.origin.y += margin;
	frame.size.width -= margin*2.0;
	frame.size.height = [centerFill size].height;
	
	NSDrawThreePartImage(frame, startCap, centerFill, endCap, NO, NSCompositeSourceOver, 1.0, NO);
}

@end
