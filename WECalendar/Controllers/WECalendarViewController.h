//
//  WECalendarViewController.h
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/13/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WECalendarEventPopoverView.h"


@class WECalendar,WECalendarCollectionView;

@interface WECalendarViewController : NSViewController <NSCollectionViewDelegate,NSCollectionViewDataSource,NSPopoverDelegate,NewEventPopoverDelegate>
{
    IBOutlet NSCollectionView *__weak dayCollectionView;
    WECalendar *activeCalendar;
    
    WECalendarEventPopoverView *eventPopoverViewController;
    NSPopover *eventPO;
}

@property (weak)IBOutlet NSCollectionView *dayCollectionView;
@property (strong)WECalendar *activeCalendar;
@property (strong)NSPopover *eventPO;

@end
