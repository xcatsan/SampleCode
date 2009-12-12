//
//  MatrixSampleAppDelegate.h
//  MatrixSample
//
//  Created by 湖 on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ApplicationButtonPallete;
@interface MatrixSampleAppDelegate : NSObject {
    NSWindow *window;
	
	ApplicationButtonPallete* pallete;
}

@property (assign) IBOutlet NSWindow *window;

@end
