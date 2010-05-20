//
//  CoreDataRelationship_AppDelegate.h
//  CoreDataRelationship
//
//  Created by Hiroshi Hashiguchi on 10/05/20.
//  Copyright  2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CoreDataRelationship_AppDelegate : NSObject 
{
    IBOutlet NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

@end
