//
//  BlogComment.h
//  CoreDataRelationship
//
//  Created by Hiroshi Hashiguchi on 10/05/21.
//  Copyright 2010 . All rights reserved.
//

#import <CoreData/CoreData.h>

@class BlogEntry;

@interface BlogComment :  NSManagedObject  
{
}

@property (retain) NSString * comment;
@property (retain) NSDate * created;
@property (retain) BlogEntry * entry;

@end


