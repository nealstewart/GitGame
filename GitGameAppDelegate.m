//
//  GitGameAppDelegate.m
//  GitGame
//
//  Created by Neal Stewart on 10-09-03.
//  Copyright 2010 n time. All rights reserved.
//

#import "GitGameAppDelegate.h"
#import "GitGameWindowController.h"

@implementation GitGameAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	GitGameWindowController *con = [[GitGameWindowController alloc] initWithWindowNibName:@"GitGameWindowController"];
	[con showWindow:self];
}

@end
