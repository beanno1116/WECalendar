//
//  WEDayViewItem.h
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CurrentDayHighlightView;

@interface WEDayViewItem : NSCollectionViewItem
{
    CurrentDayHighlightView *currenDayHighlight;
    NSTextField *dayNumberlabel;
    BOOL isEditing;
    
}

-(void)setIsEditing:(BOOL)flag;
-(BOOL)isEditing;




@end
