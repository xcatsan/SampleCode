//
//  TBXMLSampleAppDelegate.h
//  TBXMLSample
//
//  Created by 湖 on 10/03/31.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TBXMLSampleAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)parse1:(id)sender;
- (IBAction)parse2:(id)sender;

@end
