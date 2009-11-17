//
//  Homepage.h
//  BlogAssistant
//

#import <Cocoa/Cocoa.h>

@interface Homepage : NSManagedObject {

}
@property (retain, nonatomic) NSDate * createdDate;
@property (retain, nonatomic) NSString * imageName;
@property (retain, nonatomic) NSString * memo;
@property (retain, nonatomic) NSDate * modifiedDate;
@property (retain, nonatomic) NSString * title;
@property (retain, nonatomic) NSString * url;

@end
