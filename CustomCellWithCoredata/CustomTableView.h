//
//  CustomTableView.h
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/11.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CustomTableView : NSTableView {

	NSTrackingArea* trackingArea;

}
@property (retain) NSTrackingArea* trackingArea;

@end
