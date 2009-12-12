//
//  ButtonPallete.h
//  MatrixSample
//
//  Created by 湖 on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ApplicationButtonMatrix;
@interface ApplicationButtonPallete : NSObject {

	ApplicationButtonMatrix* matrix;

	id target;
	SEL action;
}
@property (retain) id target;
@property (assign) SEL action;

-(void)addButtonWithPath:(NSString*)path;
-(void)removeAll;

-(void)addToView:(NSView*)view;
-(void)setOrigin:(NSPoint)point;


@end
