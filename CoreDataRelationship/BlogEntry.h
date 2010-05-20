//
//  BlogEntry.h
//  CoreDataRelationship
//
//  Created by Hiroshi Hashiguchi on 10/05/20.
//  Copyright 2010 . All rights reserved.
//

#import <CoreData/CoreData.h>


@interface BlogEntry :  NSManagedObject  
{
}

@property (retain) NSDate * created;
@property (retain) NSString * title;
@property (retain) NSString * content;
@property (retain) NSSet* tags;

@end

@interface BlogEntry (CoreDataGeneratedAccessors)
- (void)addTagsObject:(NSManagedObject *)value;
- (void)removeTagsObject:(NSManagedObject *)value;
- (void)addTags:(NSSet *)value;
- (void)removeTags:(NSSet *)value;

@end

