//
//  GitGameWindowController.h
//  GitGame
//
//  Created by Neal Stewart on 10-09-03.
//  Copyright 2010 n time. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BarView.h"


@interface GitGameWindowController : NSWindowController {
}

+(NSString *) repoToObserve;
+(void) setRepoToObserve:(NSString *)repoToSet;
@property IBOutlet BarView *barView;
@property (readwrite, assign) int currentHealth;
@property IBOutlet NSView *contentView;

@end
