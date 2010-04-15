//
//  ApplicationEntry.h
//  AppList
//
//  Created by 湖 on 10/04/13.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ApplicationEntry : NSObject {

	NSString* name;
	NSString* path;
	NSImage* icon;
}
@property (copy) NSString* name;
@property (copy) NSString* path;
@property (retain) NSImage* icon;

-(id)initWithPath:(NSString*)aPath;
@end
