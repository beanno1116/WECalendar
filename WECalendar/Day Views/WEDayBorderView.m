//
//  WEDayBorderView.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WEDayBorderView.h"

@implementation WEDayBorderView

- (NSColor *)borderColor {
    return borderColor;
}

- (void)setBorderColor:(NSColor *)newBorderColor {
    if (borderColor != newBorderColor) {
        borderColor = [newBorderColor copy];
        [self setNeedsDisplay:YES];
    }
}

#pragma mark Visual State

// A AAPLSlideCarrierView wants to receive -updateLayer so it can set its backing layer's contents property, instead of being sent -drawRect: to draw its content procedurally.
- (BOOL)wantsUpdateLayer {
    return YES;
}

- (void)updateLayer {
    CALayer *layer = self.layer;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = (borderColor ? 0.5 : 0.0);
    
}
@end
