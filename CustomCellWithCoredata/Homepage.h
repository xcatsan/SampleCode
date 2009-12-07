//
//  Homepage.h
//  CustomCell
//

#import <Cocoa/Cocoa.h>


@interface Homepage : NSManagedObject <NSCopying> {

	NSString* title;
	NSString* image;
}
@property (retain, nonatomic) NSString* title;
@property (retain, nonatomic) NSString* image;

@end
