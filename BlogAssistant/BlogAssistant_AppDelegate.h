//
//  BlogAssistant_AppDelegate.h
//  BlogAssistant
//

#import <Cocoa/Cocoa.h>

@interface BlogAssistant_AppDelegate : NSObject 
{
    IBOutlet NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	IBOutlet NSArrayController *arrayController;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

- (IBAction)addTestRecord:(id)sender;
@end
