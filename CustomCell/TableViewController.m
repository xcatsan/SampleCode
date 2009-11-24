//
//  TableViewController.m
//  CustomCell
//

#import "TableViewController.h"
#import "Homepage.h"

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

@end
