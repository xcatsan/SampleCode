//
//  CoreDataConflict_AppDelegate.h
//  CoreDataConflict
//
//  Created by 湖 on 09/11/26.
//  Copyright Hiroshi Hashiguchi 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CoreDataConflict_AppDelegate : NSObject 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	
	NSManagedObjectContext* moc1;
	NSManagedObjectContext* moc2;
	
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectContext *moc1;
@property (nonatomic, retain, readonly) NSManagedObjectContext *moc2;

- (IBAction)saveAction:sender;

@end
