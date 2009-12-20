//
//  CustomTableView.h
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/11.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomCell;
@interface CustomTableView : NSTableView {

	NSTrackingArea* trackingArea;
	CustomCell* cell;
	
	NSInteger previousColumn;
	NSInteger previousRow;
	
}
@property (retain) NSTrackingArea* trackingArea;

- (void)setup;
- (void)setDataCell:(CustomCell*)cell;

@end
