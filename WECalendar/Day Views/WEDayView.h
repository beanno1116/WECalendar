//
//  WEDayView.h
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@interface WEDayView : NSView
{
    
    NSCollectionViewItemHighlightState highlightState;
    BOOL selected;
    
    
    NSTrackingRectTag trackingTag;
    NSTrackingArea *trackingArea;
    BOOL mouseInside;
    
    BOOL hasNumber;
    BOOL isEditing;
}



@property NSCollectionViewItemHighlightState highlightState;
@property (getter=isSelected) BOOL selected;

-(void)setIsEditing:(BOOL)flag;
-(BOOL)isEditing;



@property (assign)BOOL hasNumber;
@property (assign)NSTrackingRectTag trackingTag;
@property (strong)NSTrackingArea *trackingArea;
@property (assign)BOOL mouseInside;




-(void)updateTrackingAreas;
@end
