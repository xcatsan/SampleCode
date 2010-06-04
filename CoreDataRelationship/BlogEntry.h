//
//  BlogEntry.h
//  CoreDataRelationship
//
//  Created by Hiroshi Hashiguchi on 10/05/21.
//  Copyright 2010 . All rights reserved.
//

#import <CoreData/CoreData.h>

@class Tag;
@class BlogComment;

@interface BlogEntry :  NSManagedObject  
{
}

@property (retain) NSDate * created;
@property (retain) NSString * title;
@property (retain) NSString * content;
@property (retain) NSSet* tags;
@property (retain) NSSet* comments;

@end

@interface BlogEntry (CoreDataGeneratedAccessors)
- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)value;
- (void)removeTags:(NSSet *)value;

- (void)addCommentsObject:(BlogComment *)value;
- (void)removeCommentsObject:(BlogComment *)value;
- (void)addComments:(NSSet *)value;
- (void)removeComments:(NSSet *)value;

@end

