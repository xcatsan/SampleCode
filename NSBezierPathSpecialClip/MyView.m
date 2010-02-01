//
//  MyView.m
//  NSBezierPathSpecialClip
//
//  Created by 橋口 湖 on 09/12/30.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "MyView.h"


@implementation MyView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    // Drawing code here.
	NSImage* image = [NSImage imageNamed:@"sample"];
	NSLog(@"%@", image);

	// [1-1] mask pattern 1
	NSRect baseFrame11 = NSMakeRect(50, 200, 100, 100);
	NSRect frame11 = NSInsetRect(baseFrame11, 10, 10);
	NSBezierPath* path11 = [NSBezierPath bezierPathWithRoundedRect:frame11
														 xRadius:20
														 yRadius:20];
	[[NSColor redColor] set];
	[path11 fill];
	
	// [1-2] image with mask1
	NSRect baseFrame12 = NSMakeRect(200, 200, 100, 100);
	NSRect frame12 = NSInsetRect(baseFrame12, 10, 10);
	NSBezierPath* path12 = [NSBezierPath bezierPathWithRoundedRect:frame12
														  xRadius:20
														  yRadius:20];
	[NSGraphicsContext saveGraphicsState];
	[path12 setClip];
	[image drawInRect:baseFrame12
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];
	
	// [2-1] mask pattern 2
	NSRect baseFrame21 = NSMakeRect(50, 50, 100, 100);
	NSRect frame21 = NSInsetRect(baseFrame21, 10, 10);
	NSBezierPath* path21 = [NSBezierPath bezierPathWithRoundedRect:frame21
														  xRadius:20
														  yRadius:20];
	[path21 appendBezierPathWithRect:baseFrame21];
	[path21 setWindingRule:NSEvenOddWindingRule];
	[[NSColor redColor] set];
	[path21 fill];


	// [2-2] image with mask 2
	NSRect baseFrame22 = NSMakeRect(200, 50, 100, 100);
	NSRect frame22 = NSInsetRect(baseFrame22, 10, 10);
	NSBezierPath* path22 = [NSBezierPath bezierPathWithRoundedRect:frame22
														   xRadius:20
														   yRadius:20];
	[path22 appendBezierPathWithRect:baseFrame22];
	[path22 setWindingRule:NSEvenOddWindingRule];

	[NSGraphicsContext saveGraphicsState];
	[path22 setClip];
	[image drawInRect:baseFrame22
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];

}

@end
