//
//  WECalendarBackgrounView.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WECalendarBackgroundView.h"

@implementation WECalendarBackgroundView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        NSColor *centerColor = [NSColor colorWithCalibratedRed:0.333 green:0.494 blue:0.749 alpha:1.0];
        NSColor *outerColor = [NSColor colorWithCalibratedRed:0.203 green:0.388 blue:0.682 alpha:1.0];
        gradient = [[NSGradient alloc] initWithStartingColor:centerColor endingColor:outerColor];
    }
    return self;
}

- (BOOL)isOpaque {
    return YES;
}



- (void)drawRect:(NSRect)dirtyRect {
    

    [gradient drawInRect:self.bounds relativeCenterPosition:NSZeroPoint];
 
}
@end
