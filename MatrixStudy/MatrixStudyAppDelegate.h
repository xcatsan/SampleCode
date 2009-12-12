//
//  MatrixStudyAppDelegate.h
//  MatrixStudy
//
//  Created by 湖 on 09/11/29.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MatrixController;
@interface MatrixStudyAppDelegate : NSObject {
    NSWindow *window;
	
	MatrixController* viewController;
}

@property (assign) IBOutlet NSWindow *window;

@end
