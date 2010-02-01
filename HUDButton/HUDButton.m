//
//  HUDButton.m
//  HUDButton
//
//  Created by 橋口 湖 on 09/12/29.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "HUDButton.h"

#define MARGIN_X	10.0
#define MARGIN_Y	4.0
@implementation HUDButton

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		textAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
										[NSColor whiteColor], NSForegroundColorAttributeName,
										[NSFont systemFontOfSize:11], NSFontAttributeName,
										nil];
    }
    return self;
}

- (void) dealloc
{
	self.title = nil;
	[textAttributes release];
	[super dealloc];
}


- (NSString*)title
{
	return title;
}

- (void)setTitle:(NSString*)aTitle
{
	[aTitle retain];
	[title release];
	title = aTitle;
	
	NSSize textSize = [title sizeWithAttributes:textAttributes];
	NSSize frameSize = textSize;
	frameSize.width += MARGIN_X*2;
	frameSize.height += MARGIN_Y*2;
	[self setFrameSize:frameSize];

	textFrame = [self bounds];
	textFrame.origin.x += (frameSize.width - textSize.width)/2.0;
	textFrame.origin.y -= (frameSize.height - textSize.height)/2.0;	
}

- (void)drawRect:(NSRect)rect {
		
	NSRect frame = NSInsetRect(self.bounds, 1.0, 1.0);
	NSRect shadowFrame = frame;

	NSBezierPath* path = [NSBezierPath
						  bezierPathWithRoundedRect:frame xRadius:10 yRadius:10];
	NSBezierPath* pathForShadow = [NSBezierPath
						  bezierPathWithRoundedRect:shadowFrame xRadius:10 yRadius:10];
	
	// [1] draw shadow
	[pathForShadow appendBezierPathWithRect:rect];
	[pathForShadow setWindingRule:NSEvenOddWindingRule];

	[NSGraphicsContext saveGraphicsState];
	NSShadow* shadow = [[NSShadow alloc] init];
	[shadow setShadowOffset:NSMakeSize(2, -2)];
	[shadow setShadowBlurRadius:1.0];
	[shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.5]];
	[shadow set];
	[[NSColor blackColor] set];
	[pathForShadow setClip];
	[path fill];
	[NSGraphicsContext restoreGraphicsState];

	// [2] draw background
	CGFloat cf1, cf2;
	if (isMouseDown) {
		cf1 = 1.00;
		cf2 = 0.75;
	} else {
		cf1 = 0.40;
		cf2 = 0.15;
	}
	CGFloat alpha = 0.5;
	NSColor* c1 = [NSColor colorWithCalibratedRed:cf1 green:cf1 blue:cf1 alpha:alpha];
	NSColor* c2 = [NSColor colorWithCalibratedRed:cf2 green:cf2 blue:cf2 alpha:alpha];
	NSArray* colors = [NSArray arrayWithObjects:c1, c2, nil];
	NSGradient *g = [[[NSGradient alloc] initWithColors:colors] autorelease];
	
	[g drawInBezierPath:path angle:270.0];

	// [3] draw frame
	[path setClip];
	NSColor* frameColor = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:alpha];
	[frameColor set];
	[path setLineWidth:1.75];
	[path stroke];

	// [4] draw text
	[title drawInRect:textFrame withAttributes:textAttributes];

}

- (void)mouseDown:(NSEvent*)event
{
	isMouseDown = YES;
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent*)event
{
	isMouseDown = NO;
	[self setNeedsDisplay:YES];
}

@end
