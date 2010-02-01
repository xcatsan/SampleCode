//
//  HUDButton.h
//  HUDButton
//
//  Created by 橋口 湖 on 09/12/29.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HUDButton : NSView {

	BOOL isMouseDown;
	NSString* title;
	NSDictionary* textAttributes;
	NSRect textFrame;
}
@property (retain) NSString* title;
@end
