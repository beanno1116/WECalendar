//
//  WEDayView.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WEDayView.h"
#import "WEDayBorderView.h"
#import "WECalendarCollectionView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WEDayView
@dynamic mouseInside;
@synthesize trackingTag;
@synthesize trackingArea;
@synthesize hasNumber;



+ (id)defaultAnimationForKey:(NSString *)key {
    static CABasicAnimation *basicAnimation = nil;
    if ([key isEqual:@"frameOrigin"]) {
        if (basicAnimation == nil) {
            basicAnimation = [[CABasicAnimation alloc] init];
            [basicAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        }
        return basicAnimation;
    } else {
        return [super defaultAnimationForKey:key];
    }
}

- (nonnull instancetype)initWithFrame:(NSRect)frameRect {
    
    self = [super initWithFrame:frameRect];
    if (self) {
        highlightState = NSCollectionViewItemHighlightNone;
        [[self window] setAcceptsMouseMovedEvents:YES];
        trackingArea = [[NSTrackingArea alloc]initWithRect:[self frame] options:NSTrackingMouseMoved | NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp owner:self userInfo:NULL];
        [self addTrackingArea:trackingArea];
    }
    return self;
}

- (NSCollectionViewItemHighlightState)highlightState {
    return highlightState;
}
- (void)setHighlightState:(NSCollectionViewItemHighlightState)newHighlightState {
   
    if (highlightState != newHighlightState) {
        highlightState = newHighlightState;
        
        // Cause our -updateLayer method to be invoked, so we can update our appearance to reflect the new state.
        [self setNeedsDisplay:YES];
    }
}

- (BOOL)isSelected {
    return selected;
}
- (void)setSelected:(BOOL)flag {
    if (selected != flag) {
        selected = flag;
        
        // Cause our -updateLayer method to be invoked, so we can update our appearance to reflect the new state.
        [self setNeedsDisplay:YES];
    }
}

-(void)setIsEditing:(BOOL)flag{
    if (isEditing != flag) {
        isEditing = flag;
        [self setNeedsDisplay:YES];
    }
}
-(BOOL)isEditing{
    return isEditing;
}









- (BOOL)wantsUpdateLayer {
    return YES;
}

- (WEDayBorderView *)borderView {
    for (NSView *subview in self.subviews) {
        if ([subview isKindOfClass:[WEDayBorderView class]]) {
            return (WEDayBorderView *)subview;
        }
    }
    return nil;
}

- (void)updateBorderView {
    NSColor *borderColor = nil;
    if (highlightState == NSCollectionViewItemHighlightForSelection) {
        
        // Item is a candidate to become selected: Show an orange border around it.
        borderColor = [NSColor orangeColor];
        
    } else if (highlightState == NSCollectionViewItemHighlightAsDropTarget) {
        
        // Item is a candidate to receive dropped items: Show a red border around it.
        borderColor = [NSColor redColor];
        
    } else if (selected && highlightState != NSCollectionViewItemHighlightForDeselection) {
        
        // Item is selected, and is not indicated for proposed deselection: Show an Aqua border around it.
        borderColor = [NSColor colorWithCalibratedRed:0.0 green:0.5 blue:1.0 alpha:1.0]; // Aqua
        
    } else {
        // Item is either not selected, or is selected but not highlighted for deselection: Sbhow no border around it.
        borderColor = nil;
    }
    
    // Add/update or remove a AAPLSlideBorderView subview, according to whether borderColor != nil.
    WEDayBorderView *borderView = self.borderView;
    if (borderColor) {
        if (borderView == nil) {
            NSRect bounds = self.bounds;
            borderView = [[WEDayBorderView alloc] initWithFrame:bounds];
            [self addSubview:borderView];
        }
        borderView.borderColor = borderColor;
    } else {
        [borderView removeFromSuperview];
    }
}

- (void)updateLayer {
    // Provide the SlideCarrierView's backing layer's contents directly, instead of via -drawRect:.
    if ([[self subviews] count] > 0) {
        if (mouseInside) {
            
            if ([[(NSCollectionView *)[self superview] selectionIndexPaths] count] == 0) {
                self.layer.backgroundColor = [[NSColor redColor] CGColor];
            }
            
        }else{
            if (!isEditing) {
                self.layer.backgroundColor = nil;
            }
        }
        // Use this as an opportunity to update our AAPLSlideBorderView.
        [self updateBorderView];
        
    }
}



-(void)stopTracking{
    [super removeTrackingArea:trackingArea];
    [self removeTrackingArea:trackingArea];
}
-(void)startTracking{
    [self updateTrackingAreas];
}



-(BOOL)verifyReceivesHoverEffect{
    if ([[self subviews] count] > 0) {
        if ([[[[self subviews] firstObject] stringValue] isEqualToString:@""]) {
            NSLog(@"FOUND STRING=> %@",[[[self subviews] firstObject] stringValue]);
            return NO;
        }else{
            return YES;
        }
    }else{
        NSLog(@"ERROR=> NO SUBVIEWS IN CURRENT VIEW");
        return NO;
    }
}

- (void)ensureTrackingArea {
    if (trackingArea == nil) {
        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame] options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
    }
}

-(void)updateTrackingAreas{
    [super updateTrackingAreas];
    [self ensureTrackingArea];
    if (![[self trackingAreas] containsObject:trackingArea]) {
        [self addTrackingArea:trackingArea];
    }
}

- (void)setMouseInside:(BOOL)value {
    if (mouseInside != value) {
        mouseInside = value;
        [self setNeedsDisplay:YES];
    }
}

- (BOOL)mouseInside {
    return mouseInside;
    
}

-(void)mouseEntered:(NSEvent *)event{
    [self setMouseInside:YES];
}

-(void)mouseExited:(NSEvent *)event{
    [self setMouseInside:NO];
}








- (NSBezierPath *)slideShape {
    NSRect bounds = self.bounds;
    NSRect shapeBox = NSInsetRect(bounds, 0.5, 0.5);
    return [NSBezierPath bezierPathWithRoundedRect:shapeBox xRadius:0 yRadius:0];
}

- (NSView *)hitTest:(NSPoint)aPoint {
    // Hit-test against the slide's rounded-rect shape.
    NSPoint pointInSelf = [self convertPoint:aPoint fromView:self.superview];
    NSRect bounds = self.bounds;
    if (!NSPointInRect(pointInSelf, bounds)) {
        return nil;
    } else if (![self.slideShape containsPoint:pointInSelf]) {
        return nil;
    } else {
        return [super hitTest:aPoint];
    }
}

@end
