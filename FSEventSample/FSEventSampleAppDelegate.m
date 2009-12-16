//
//  FSEventSampleAppDelegate.m
//  FSEventSample
//
//  Created by 湖 on 09/12/15.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "FSEventSampleAppDelegate.h"

@implementation FSEventSampleAppDelegate

@synthesize window;

void fsevents_callback(
				  ConstFSEventStreamRef streamRef,
				  void *userData,
				  size_t numEvents,
				  void *eventPaths,
				  const FSEventStreamEventFlags eventFlags[],
				  const FSEventStreamEventId eventIds[])
{
    int i;
    char **paths = eventPaths;

	NSLog(@"clicentCallBackInfo: %@", userData);

    for (i=0; i<numEvents; i++) {
        /* flags are unsigned long, IDs are uint64_t */
        printf("Change %llu in %s, flags %lu\n",
			eventIds[i], paths[i], eventFlags[i]);
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedLongLong:eventIds[numEvents-1]] forKey:@"LAST_EVENT_ID"];
}

- (void)awakeFromNib
{
	FSEventStreamEventId lastEventId =
	[[[NSUserDefaults standardUserDefaults]
	  objectForKey:@"LAST_EVENT_ID"] unsignedLongLongValue];
	
	NSLog(@"Last event id = %llu", lastEventId);
	
	if (!lastEventId) {
		lastEventId = kFSEventStreamEventIdSinceNow;
	}
	
	NSArray* pathsToWatch = [NSArray arrayWithObjects:
							 @"/Users/hashi/Desktop",
							 @"/Users/hashi/Desktop/SimpleCap Images", nil];
	void *selfPointer = (void*)self;
	FSEventStreamContext context = {0, selfPointer, NULL, NULL, NULL};
    FSEventStreamRef stream;
    NSTimeInterval latency = 3.0; /* Latency in seconds */
	
    /* Create the stream, passing in a callback */
    stream = FSEventStreamCreate(NULL,
		&fsevents_callback,
		&context,
		(CFArrayRef)pathsToWatch,
		lastEventId,
		latency,
		kFSEventStreamCreateFlagNone /* Flags explained in reference */
	);
	
    /* Create the stream before calling this. */
    FSEventStreamScheduleWithRunLoop(stream,
		CFRunLoopGetCurrent(), kCFRunLoopDefaultMode
	);
	
	FSEventStreamStart(stream);
	
}
@end
