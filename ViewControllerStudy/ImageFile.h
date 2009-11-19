//
//  ImageFile.h
//  ViewControllerStudy
//

#import <Cocoa/Cocoa.h>


@interface ImageFile : NSObject {

	NSImage* image;
	NSString* name;
	NSDate* date;
}
@property (retain, nonatomic) NSImage* image;
@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSDate* date;

@end
