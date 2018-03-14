//
//  WECalendarCollectionView.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WECalendarCollectionView.h"

@implementation WECalendarCollectionView

@synthesize addEventShowing;

-(WECalendarCollectionView *)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)setBackgroundView:(NSView *)backgroundView{
    [super setBackgroundView:backgroundView];
}

-(void)deselectAll:(id)sender{
    [super deselectAll:sender];
}

@end
