//
//  GitGameWindowController.m
//  GitGame
//
//  Created by Neal Stewart on 10-09-03.
//  Copyright 2010 n time. All rights reserved.
//

#import "GitGameWindowController.h"


static const int GitGameTotalHealth = 100;

@implementation GitGameWindowController
@synthesize barView;
@synthesize contentView;
@synthesize currentHealth;


- (NSArray *) gitDiffDir:(NSString *)dirToDiff {
	NSTask *task;
    task = [[NSTask alloc] init];
	[task setCurrentDirectoryPath:dirToDiff];
    [task setLaunchPath: @"/usr/local/bin/git"];
	
    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"diff", @"--numstat", nil];
    [task setArguments: arguments];
	
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
	
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
	
    [task launch];
    [task waitUntilExit];
	
    NSData *data;
    data = [file readDataToEndOfFile];
	
    NSString *diffResultsString;
    diffResultsString = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    diffResultsString = [diffResultsString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	NSArray *diffResults = [diffResultsString componentsSeparatedByString:@"\n"];
	
	return diffResults ;
}

- (int) numberChangedFiles:(NSArray *) diffResults {
	return diffResults.count;
}

- (int) numberAddedLines:(NSArray *) diffResults {
	int totalLinesAdded = 0;
	for (NSString *line in diffResults) {
		NSArray *splitLine = [line componentsSeparatedByString:@"\t"];
		NSString *linesAddedString = [splitLine objectAtIndex:0];
		
		totalLinesAdded += [linesAddedString intValue];
	}
	
	NSLog(@"Total lines added: %i", totalLinesAdded);
	
	return totalLinesAdded;
}

- (int) numberDeletedLines:(NSArray *) diffResults {
	int totalLinesDeleted = 0;
	for (NSString *line in diffResults) {
		NSArray *splitLine = [line componentsSeparatedByString:@"\t"];

		if ([splitLine count] > 1) {
			NSString *linesDeletedString = [splitLine objectAtIndex:1];

			totalLinesDeleted += [linesDeletedString intValue];
		}
	}
	
	NSLog(@"Total lines delete: %i", totalLinesDeleted); 
	
	return totalLinesDeleted;
}

- (void) calcCurrentHealth {
	NSArray *diffs = nil;
	
	if ([GitGameWindowController repoToObserve] == nil) {
		diffs = [self gitDiffDir:@"/Users/neal/Sites/work/urtak/fbapp"];
	} else {
		diffs = [self gitDiffDir:[GitGameWindowController repoToObserve]];
		NSLog(@"%@", [GitGameWindowController repoToObserve]);
	}
	
	// Get the current health of the repo and display it.
	int linesChanged = [self numberAddedLines:diffs] + [self numberDeletedLines:diffs];
	
	[self setCurrentHealth:(GitGameTotalHealth - linesChanged)];
}

- (void) drawCycle {
	[self calcCurrentHealth];
	
	if (currentHealth < 50 && currentHealth > 25) {
		[barView setCurrentColor:[NSColor yellowColor]];
	} else if (currentHealth <= 25) {
		[barView setCurrentColor:[NSColor redColor]];
	}
	
	int windowHeight = [((NSWindow *) [self window]) frame].size.height - 50;
	
	NSRect frame = [barView frame];
	frame.size.height = windowHeight * currentHealth / GitGameTotalHealth;
	[barView setFrame:frame];
	
	[self performSelector:@selector(drawCycle) withObject:NULL afterDelay:5];
}

- (void) windowDidLoad {
	[super windowDidLoad];
	self.currentHealth = GitGameTotalHealth;
	
	[self drawCycle];
}

- (float) randomBetweenZeroAndOne {
	float randVal = (arc4random() % 1000000);
	randVal /= 1000000;
	
	return randVal;
}


static NSString *_repoToObserve = nil;
+ (NSString *) repoToObserve {
	return _repoToObserve;
}

+ (void) setRepoToObserve:(NSString *) repoToSet {
	_repoToObserve = repoToSet;
	NSLog(_repoToObserve);
}


@end
