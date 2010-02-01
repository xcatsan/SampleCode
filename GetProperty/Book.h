//
//  Book.h
//  GetProperty
//
//  Created by Hiroshi Hashiguchi on 10/02/01.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Book : NSObject {

	NSString* title;
	NSString* author;
	NSDate* createdDate;
	float weight;
}
@property (retain) NSString* title;
@property (retain) NSString* author;
@property (retain) NSDate* createdDate;
@property float weight;
@end
