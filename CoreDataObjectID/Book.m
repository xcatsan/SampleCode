// 
//  Book.m
//  CoreDataObjectID
//
//  Created by Hiroshi Hashiguchi on 10/06/05.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "Book.h"


@implementation Book 

@dynamic Title;
@dynamic Author;

-(NSString*)ObjectID_URI
{
	NSManagedObjectID* moid = [self objectID];
	return [[moid URIRepresentation] description];
}
-(void)setObjectID_URI:(NSString*)dummy
{
}
@end
