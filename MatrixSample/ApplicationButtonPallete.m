//
//  ButtonPallete.m
//  MatrixSample
//
//  Created by 湖 on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationButtonPallete.h"
#import "ApplicationButtonCell.h"
#import "ApplicationButtonMatrix.h"

@implementation ApplicationButtonPallete

@synthesize target, action;

#pragma mark -
#pragma mark Initialize and Deallocation
-(id)init
{
	self = [super init];
	
	if (self) {
		matrix = [[[ApplicationButtonMatrix alloc] init] autorelease];
		[matrix setTarget:self];
		[matrix setAction:@selector(click:)];
	}
	return self;
}
- (void) dealloc
{
	matrix = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Managing Cell
-(void)addButtonWithPath:(NSString*)path
{
	NSArray* array = [NSArray arrayWithObject:
					  [ApplicationButtonCell cellWithPath:path]];
	[matrix addRowWithCells:array];
	[matrix sizeToCells];
}
-(void)removeAll
{
	for (NSInteger row=[matrix numberOfRows]-1; row >=0; row--) {
		[matrix removeRow:row];
	}
}


#pragma mark -
#pragma mark Event Handling
-(void)click:(id)sender
{
	ApplicationButtonCell* selectedCell = [sender selectedCell];
	NSInteger row, column;
	[matrix getRow:&row column:&column ofCell:selectedCell];

	NSMethodSignature* signature = [[target class] instanceMethodSignatureForSelector:self.action];
	if (signature) {
		NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
		[invocation setSelector:self.action];
		[invocation setTarget:self.target];
		[invocation setArgument:&row atIndex:2];
		[invocation invoke];
	}
}

#pragma mark -
#pragma mark Public method
-(void)addToView:(NSView*)view
{
	[view addSubview:matrix];
}

-(void)setOrigin:(NSPoint)point
{
	[matrix setFrameOrigin:point];
}

@end
