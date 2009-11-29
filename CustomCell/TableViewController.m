//
//  TableViewController.m
//  CustomCell
//

#import "TableViewController.h"
#import "Homepage.h"
#import "CustomCell.h"

@implementation TableViewController
@synthesize list;

- (id)init
{
	self = [super init];
	if (self) {
		list = [[NSMutableArray alloc] init];
		
		Homepage* homepage;
		
		for (int i=0; i < 10; i++) {
			homepage = [[[Homepage alloc] init] autorelease];
			homepage.title = [NSString stringWithFormat:@"SAMPLE-%d", i];
			homepage.image = @"sample.jpg";
			[list addObject:homepage];
		}
	}
	return self;
}
#pragma mark -
-(void)awakeFromNib
{
	CustomCell* cell = [[[CustomCell alloc] init] autorelease];
	[cell setEditable:NO];
	[tableColumn setDataCell:cell];
	NSLog(@"cell=%@", cell);
}

#pragma mark -
#pragma mark NSTableViewDelegate
/*
- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSLog(@"tableView: %@", tableView);
	NSLog(@"  tableColumn: %@", tableColumn);
	NSLog(@"  row: %d", row);

	CustomCell* cell = [[[CustomCell alloc] init] autorelease];
	return cell;
}
*/

@end
