//
//  CustomCellWithCoredata_AppDelegate.h
//  CustomCellWithCoredata
//
//  Created by ?? ? on 09/12/07.
//  Copyright xcatsan.com 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomCell;
@interface CustomCellWithCoredata_AppDelegate : NSObject 
{
    IBOutlet NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	
	IBOutlet NSTableColumn* table_column;
	IBOutlet NSArrayController* array_controller;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

@end
