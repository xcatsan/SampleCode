//
//  CoreDataRelationship_AppDelegate.m
//  CoreDataRelationship
//
//  Created by Hiroshi Hashiguchi on 10/05/20.
//  Copyright  2010 . All rights reserved.
//

#import "CoreDataRelationship_AppDelegate.h"
#import "BlogEntry.h"
#import "Tag.h"

@implementation CoreDataRelationship_AppDelegate


/**
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named "CoreDataRelationship" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportFolder {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"CoreDataRelationship"];
}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle.
 */
 
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The folder for the store is created, 
    if necessary.)
 */

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }

    NSFileManager *fileManager;
    NSString *applicationSupportFolder = nil;
    NSURL *url;
    NSError *error;
    
    fileManager = [NSFileManager defaultManager];
    applicationSupportFolder = [self applicationSupportFolder];
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        [fileManager createDirectoryAtPath:applicationSupportFolder attributes:nil];
    }
    
    url = [NSURL fileURLWithPath: [applicationSupportFolder stringByAppendingPathComponent: @"CoreDataRelationship.db"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]){
        [[NSApplication sharedApplication] presentError:error];
    }    

    return persistentStoreCoordinator;
}


/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}


/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}


/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
- (IBAction) saveAction:(id)sender {

    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}


/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {

    NSError *error;
    int reply = NSTerminateNow;
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext commitEditing]) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
				
                // This error handling simply presents error information in a panel with an 
                // "Ok" button, which does not include any attempt at error recovery (meaning, 
                // attempting to fix the error.)  As a result, this implementation will 
                // present the information to the user and then follow up with a panel asking 
                // if the user wishes to "Quit Anyway", without saving the changes.

                // Typically, this process should be altered to include application-specific 
                // recovery steps.  

                BOOL errorResult = [[NSApplication sharedApplication] presentError:error];
				
                if (errorResult == YES) {
                    reply = NSTerminateCancel;
                } 

                else {
					
                    int alertReturn = NSRunAlertPanel(nil, @"Could not save changes while quitting. Quit anyway?" , @"Quit anyway", @"Cancel", nil);
                    if (alertReturn == NSAlertAlternateReturn) {
                        reply = NSTerminateCancel;	
                    }
                }
            }
        } 
        
        else {
            reply = NSTerminateCancel;
        }
    }
    
    return reply;
}


/**
    Implementation of dealloc, to release the retained variables.
 */
 
- (void) dealloc {

    [managedObjectContext release], managedObjectContext = nil;
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    [managedObjectModel release], managedObjectModel = nil;
    [super dealloc];
}

- (NSUInteger)getCount
{
	NSManagedObjectContext* moc = [self managedObjectContext];

	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"BlogEntry"
								   inManagedObjectContext:managedObjectContext]];
	[request setIncludesSubentities:NO];
	
	NSError* error = nil;
	NSUInteger count = [moc countForFetchRequest:request error:&error];
	if (count == NSNotFound) {
		count = 0;
	}
	[request release];
	
	return count;
}

- (void)addTestData
{
	if ([self getCount]) {
		return;
	}

	NSManagedObjectContext* moc = [self managedObjectContext];

	Tag* tag1 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
											  inManagedObjectContext:moc];
	tag1.name = @"Mac";
	
	Tag* tag2 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
											  inManagedObjectContext:moc];
	tag2.name = @"iPhone";
	
	Tag* tag3 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
											  inManagedObjectContext:moc];
	tag3.name = @"iPad";
	
	BlogEntry* blog1 = [NSEntityDescription insertNewObjectForEntityForName:@"BlogEntry"
													 inManagedObjectContext:moc];
	blog1.title = @"CoreData のリレーションしっぷについて";
	blog1.content = @"かくかくしかじか";
	blog1.created = [NSDate date];
	blog1.tags = [NSSet setWithObjects:tag1, tag2, tag3, nil];

	BlogEntry* blog2 = [NSEntityDescription insertNewObjectForEntityForName:@"BlogEntry"
													 inManagedObjectContext:moc];
	blog2.title = @"iPad 5/28発売";
	blog2.content = @"かくかくしかじか";
	blog2.created = [NSDate date];
	blog2.tags = [NSSet setWithObjects:tag3, nil];

	NSError* error = nil;
	[moc save:&error];
	
	if (error) {
		NSLog(@"INSERT ERROR: %@", error);
	} else {
		NSLog(@"INSERTED");
	}	
}

- (void)fetchData
{
	NSManagedObjectContext* moc = [self managedObjectContext];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"BlogEntry"
								   inManagedObjectContext:managedObjectContext]];

	NSError* error = nil;
	NSLog(@"----- executeFetchRequest ------------------------------------------");
	NSArray* list = [moc executeFetchRequest:request error:&error];
	
	NSLog(@"----- listup tag ---------------------------------------------------");
	for (BlogEntry* entry in list) {
		for (Tag* tag in entry.tags) {
			NSLog(@"*tag*: %@", tag.name);
		}
	}

	[request release];
	
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self addTestData];	
	[self fetchData];
}


@end