//
//  Tag.h
//  CoreDataRelationship
//
//  Created by Hiroshi Hashiguchi on 10/05/21.
//  Copyright 2010 . All rights reserved.
//

#import <CoreData/CoreData.h>

@class BlogEntry;

@interface Tag :  NSManagedObject  
{
}

@property (retain) NSString * name;
@property (retain) NSSet* entries;

@end

@interface Tag (CoreDataGeneratedAccessors)
- (void)addEntriesObject:(BlogEntry *)value;
- (void)removeEntriesObject:(BlogEntry *)value;
- (void)addEntries:(NSSet *)value;
- (void)removeEntries:(NSSet *)value;

@end

