//
//  Homepage.m
//  CustomCell
//

#import "Homepage.h"


@implementation Homepage

@synthesize title, image;

- (id)copyWithZone:(NSZone *)zone
{
	Homepage* homepage = [[[self class] allocWithZone:zone] init];
	
	homepage.image = [image copyWithZone:zone];
	homepage.title = [title copyWithZone:zone];
	return homepage;

//	return [self retain];
}

@end
