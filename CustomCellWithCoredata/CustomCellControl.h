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
	
	id target;
	SEL action;
}
@property (retain) NSString* title;
@property (retain) id target;
@property (assign) SEL action;

- (id)initWithOrigin:(NSPoint)origin;

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView state:(NSInteger)buttonState;

- (BOOL)hitTestAtPoint:(NSPoint)testPoint inFrame:(NSRect)cellFrame;



@end
