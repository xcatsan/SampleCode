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
	
	NSLog(@"self=%@", self);
	NSLog(@"value=%@", [self valueForKey:@"self"]);
	NSImage* image = [NSImage imageNamed:@"sample"];
	
	[image setFlipped:YES];
	[image drawInRect:[self bounds]
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0];		

	[image drawInRect:[self bounds]
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0
	   respectFlipped:YES
				hints:nil];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
