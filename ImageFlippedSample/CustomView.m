//
//  CustomView.m
//  ImageFlippedSample
//
//  Created by 橋口 湖 on 10/01/03.
//  Copyright 2010 xcatsan.com. All rights reserved.
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

- (void)drawRect:(NSRect)rect {
	
	NSImage* image = [NSImage imageNamed:@"sample"];
	
	if ([image respondsToSelector:@selector(lockFocusFlipped:)]) {
		
		void (*lockFocusFlipped)(id, SEL, BOOL);
		lockFocusFlipped = (void(*)(id, SEL, BOOL))[image methodForSelector:@selector(lockFocusFlipped:)];
		lockFocusFlipped(image, @selector(methodForSelector:), YES);
		[image drawInRect:[self bounds]
				 fromRect:NSZeroRect
				operation:NSCompositeSourceOver
				 fraction:1.0];
		[image unlockFocus];
		
	} else {
		// v10.5 earlier
		[image setFlipped:YES];
		[image drawInRect:[self bounds]
				 fromRect:NSZeroRect
				operation:NSCompositeSourceOver
				 fraction:1.0];		
	}
		
}

- (BOOL)isFlipped
{
	return YES;
}

@end
