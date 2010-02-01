//
//  AppController.m
//  GetProperty
//
//  Created by Hiroshi Hashiguchi on 10/02/01.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <objc/runtime.h>
#import "AppController.h"
#import "Book.h"

@implementation AppController

-(void)awakeFromNib
{
	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList([Book class], &outCount);

	for(i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		const char *propName = property_getName(property);
		const char *propType = property_getAttributes(property);
		NSString *propertyName = [NSString stringWithUTF8String:propName];
		NSString *propertyType = [NSString stringWithUTF8String:propType];
		NSLog(@"%@: %@", propertyName, propertyType);
	}
	free(properties);
}

@end
