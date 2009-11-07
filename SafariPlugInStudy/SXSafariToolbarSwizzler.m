//
//  SXSafariToolbarSwizzler.m
//  SafariPlugInStudy
//

#import "SXSafariToolbarSwizzler.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>

#define TOOLBAR_BUTTON_ID		@"com.xcatsan.SafariPlugInStudy"

static SXSafariToolbarSwizzler* _shared_instance = nil;

@implementation SXSafariToolbarSwizzler

#pragma mark -
#pragma mark Swizzling
-(void)swizzleMethodForClass:(Class)cls orginalSelector:(SEL)org_sel alternativeSelector:(SEL)alt_sel
{
    Method org_method = class_getInstanceMethod(cls, org_sel);
	class_addMethod(cls, alt_sel,
					class_getMethodImplementation([self class], alt_sel),
					method_getTypeEncoding(org_method));
	
    Method alt_method = class_getInstanceMethod(cls, alt_sel);
//	NSLog(@"cls: %@", cls);
//	NSLog(@"org: %x", org_method);
//	NSLog(@"alt: %x", alt_method);
	method_exchangeImplementations(org_method, alt_method);
	
}

#pragma mark -
#pragma mark Class methods
+ (void)setup
{
	if (!_shared_instance) {
		_shared_instance = [[SXSafariToolbarSwizzler alloc] init];
		
		[_shared_instance swizzleMethodForClass:objc_getClass("ToolbarController")
								orginalSelector:@selector(toolbarDefaultItemIdentifiers:)
							alternativeSelector:@selector(_sx_toolbarDefaultItemIdentifiers:)];
		
		[_shared_instance swizzleMethodForClass:objc_getClass("ToolbarController")
								orginalSelector:@selector(toolbarAllowedItemIdentifiers:)
							alternativeSelector:@selector(_sx_toolbarAllowedItemIdentifiers:)];
		
		[_shared_instance swizzleMethodForClass:objc_getClass("ToolbarController")
				orginalSelector:@selector(toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:)
				alternativeSelector:@selector(_sx_toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:)];
		
		[_shared_instance swizzleMethodForClass:objc_getClass("BrowserWindowController")
								orginalSelector:@selector(windowDidLoad)
							alternativeSelector:@selector(_sx_windowDidLoad)];
		
		[_shared_instance swizzleMethodForClass:objc_getClass("BrowserWindowController")
								orginalSelector:@selector(windowWillLoad)
							alternativeSelector:@selector(_sx_windowWillLoad)];
	
		
		NSDocumentController* dc = [NSDocumentController sharedDocumentController];
		for (NSDocument* doc in [dc documents]) {
			for (NSWindowController* wc in [doc windowControllers]) {
				NSWindow* win = [wc window];
				[[win toolbar] insertItemWithItemIdentifier:TOOLBAR_BUTTON_ID atIndex:0];
			}
		}
	}
}

#pragma mark -
#pragma mark Event handler
- (void)takeScreenshot:(id)sender
{
	NSWindow* win = [sender window];
	NSWindowController* wc = [win windowController];
	NSDocument* doc = [wc document] ;
	
	WebView* web_view = [doc performSelector:@selector(currentWebView)];
	NSView* doc_view = [[[web_view mainFrame] frameView] documentView];
	
	NSBitmapImageRep* bitmap = [doc_view bitmapImageRepForCachingDisplayInRect:[doc_view bounds]];
	[doc_view cacheDisplayInRect:[doc_view bounds] toBitmapImageRep:bitmap];
	
	NSData* outdata = [bitmap representationUsingType:NSPNGFileType
										   properties:[NSDictionary dictionary]];
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
	NSString* path = [NSString stringWithFormat:@"%@/test.png", [paths objectAtIndex:0]];
	[outdata writeToFile:path atomically:YES];
	 NSLog(@"took a screenshot (from toolbar)");
	
}


#pragma mark -
#pragma mark NSToolbarDelegate
- (NSArray *)_sx_toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
	NSArray* ids = [self _sx_toolbarDefaultItemIdentifiers:toolbar];
	NSMutableArray* new_ids = [NSMutableArray arrayWithArray:ids];
	[new_ids addObject:TOOLBAR_BUTTON_ID];

//	NSLog(@"1:%@", ids);
	return new_ids;
}

- (NSArray *)_sx_toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
	NSArray* ids = [self _sx_toolbarAllowedItemIdentifiers:toolbar];
	NSMutableArray* new_ids = [NSMutableArray arrayWithArray:ids];
	[new_ids addObject:TOOLBAR_BUTTON_ID];

//	NSLog(@"2:%@", new_ids);
	return new_ids;
}

- (NSToolbarItem *)_sx_toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	NSToolbarItem* item;
	
	if ([itemIdentifier isEqualToString:TOOLBAR_BUTTON_ID]) {
		NSBundle* bundle = [NSBundle bundleForClass:[SXSafariToolbarSwizzler class]];

		NSString* path = [bundle pathForResource:@"toolbar_icon" ofType:@"tiff"];
		NSImage* image = [[[NSImage alloc] initWithContentsOfFile:path] autorelease];
		NSButton* button = [[[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 28, 23)] autorelease];
		[button setBezelStyle:NSTexturedRoundedBezelStyle];
		[button setTarget:_shared_instance];
		[button setAction:@selector(takeScreenshot:)];
		[button setImage:image];
		
		[button setToolTip:@"Take a screenshot"];

		item = [[[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier] autorelease];
		[item setView:button];
		[item setEnabled:YES];
	} else {
		item = [self _sx_toolbar:toolbar
		   itemForItemIdentifier:itemIdentifier
	   willBeInsertedIntoToolbar:flag];
	}
	return item;
}

#pragma mark -
#pragma mark NSToolbarItemValidaion protocl
/*
-(BOOL)validateToolbarItem:(NSToolbarItem *)toolbarItem
{
	BOOL is_enable = NO;
	NSLog(@"validateToolbarItem: was called: %@", toolbarItem);
	if ([[toolbarItem itemIdentifier] isEqualToString:TOOLBAR_BUTTON_ID]) {
		is_enable = YES;
	}
	return is_enable;
}
*/
#pragma mark -
#pragma mark BroserWindowController Swizzled Methods
- (void)_sx_windowWillLoad
{
	NSLog(@"_sx_windowWillLoad:%@", self);
//	NSLog(@" >> window: %@", [self window]);
	[self _sx_windowWillLoad];
}
- (void)_sx_windowDidLoad
{
	NSLog(@"_sx_windowDidLoad:%@", self);
//	NSLog(@" >> window: %@", [self window]);
	[self _sx_windowDidLoad];
}
@end
