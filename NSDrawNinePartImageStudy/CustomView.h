//
//  CustomView.h
//  NSDrawThreePartImageStudy
//
//  Created by 湖 on 09/12/23.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CustomView : NSView {

	NSImage *topLeftCorner;
	NSImage *topEdgeFill;
	NSImage *topRightCorner;
	NSImage *leftEdgeFill;
	NSImage *centerFill;
	NSImage *rightEdgeFill;
	NSImage *bottomLeftCorner;
	NSImage *bottomEdgeFill;
	NSImage *bottomRightCorner;
}

@end
