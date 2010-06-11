//
//  CoreDataTransaction_AppDelegate.h
//  CoreDataTransaction
//
//  Created by Hiroshi Hashiguchi on 10/06/12.
//  Copyright Hiroshi Hashiguchi 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CoreDataTransaction_AppDelegate : NSObject 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	
	IBOutlet NSArrayController* arrayController;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;
- (IBAction)rollbackAction:sender;


@end
