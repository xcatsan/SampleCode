//
//  Book.h
//  CoreDataConflict
//
//  Created by 湖 on 09/11/26.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Book :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * title;

@end



