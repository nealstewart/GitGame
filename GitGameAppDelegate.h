//
//  GitGameAppDelegate.h
//  GitGame
//
//  Created by Neal Stewart on 10-09-03.
//  Copyright 2010 n time. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GitGameAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
