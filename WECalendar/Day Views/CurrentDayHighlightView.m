//
//  CurrentDayHighlightView.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "CurrentDayHighlightView.h"

@implementation CurrentDayHighlightView
@synthesize isDisplayed;



- (void)drawRect:(NSRect)dirtyRect {
    
    NSRect newRect = dirtyRect;
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:newRect];
    [path addClip];
    NSGradient* aGradient = [[NSGradient alloc]
                             initWithStartingColor:[NSColor blueColor]
                             endingColor:[NSColor redColor]];
    [aGradient drawInBezierPath:path angle:90.0f];
    [super drawRect:newRect];
    
}
@end
