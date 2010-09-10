//
//  GitGameMenuController.m
//  GitGame
//
//  Created by Neal Stewart on 10-09-09.
//  Copyright 2010 n time. All rights reserved.
//

#import "GitGameMenuController.h"
#import "GitGameWindowController.h"


@implementation GitGameMenuController

- (IBAction) open:(id) pId {
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setCanChooseDirectories:YES];
	[op setCanChooseFiles:NO];
	if ([op runModal] == NSOKButton) {
		NSString *filename = [op filename];
		
		[GitGameWindowController setRepoToObserve:filename];
	}
}

@end
