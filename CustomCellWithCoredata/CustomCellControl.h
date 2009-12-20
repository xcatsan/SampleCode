//
//  CustomCellControl.h
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/16.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

enum CONTROL_STATE
{
	CONTROL_STATE_OFF,
	CONTROL_STATE_ON,
	CONTROL_STATE_OVER
};
@interface CustomCellControl : NSObject {

	NSRect frame;
	NSString* title;
	NSString* keyPath;
	NSDictionary* textAttributes;
	BOOL canHandleEvent;

	id target;
	SEL action;
}
@property (assign) NSRect frame;
@property (retain) NSString* title;
@property (retain) NSString* keyPath;
@property (retain) NSDictionary* textAttributes;
@property (assign) BOOL canHandleEvent;
@property (retain) id target;
@property (assign) SEL action;

- (id)initWithFrame:(NSRect)rect;

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView state:(NSInteger)state value:(id)value;

- (BOOL)hitTestAtPoint:(NSPoint)testPoint inFrame:(NSRect)cellFrame;


@end
