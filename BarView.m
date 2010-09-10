//
//  BarView.m
//  GitGame
//
//  Created by Neal Stewart on 10-09-03.
//  Copyright 2010 n time. All rights reserved.
//

#import "BarView.h"



@implementation BarView
@synthesize currentColor;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
	
    if (self) {
		self.currentColor = [NSColor greenColor];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [currentColor set];
	NSRectFill(dirtyRect);
}

- (void)setCurrentColor:(NSColor *)color {
	currentColor = color;
	[self setNeedsDisplay:YES];
}

@end
