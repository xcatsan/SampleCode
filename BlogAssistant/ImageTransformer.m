//
//  ImageTransformer.m
//  BlogAssistant
//

#import "ImageTransformer.h"


@implementation ImageTransformer

+ (Class)transformedValueClass
{
    return [NSImage class];
}

- (id)transformedValue:(id)value
{
	if (!value) {
		return  nil;
	}
	NSImage* image = nil;
	NSString* path = [[NSBundle mainBundle] pathForImageResource:value];
	if (path) {
		image = [[NSImage alloc] initWithContentsOfFile:path];
	}
	return image;
}
@end
