//
//  CustomCellWithCoredata_AppDelegate.h
//  CustomCellWithCoredata
//
//  Created by ?? ? on 09/12/07.
//  Copyright xcatsan.com 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomTableView;
@interface CustomCellWithCoredata_AppDelegate : NSObject 
{
    IBOutlet NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;

	IBOutlet NSArrayController *arrayController;
	IBOutlet CustomTableView* tableView;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

@end
