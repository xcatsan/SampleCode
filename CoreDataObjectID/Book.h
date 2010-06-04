//
//  Book.h
//  CoreDataObjectID
//
//  Created by Hiroshi Hashiguchi on 10/06/05.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Book :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * Title;
@property (nonatomic, retain) NSString * Author;
@property (nonatomic, retain) NSString * ObjectID_URI;

@end



