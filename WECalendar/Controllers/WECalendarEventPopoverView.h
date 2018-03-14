//
//  WECalendarEventPopoverView.h
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Day,WEDayViewItem;

@protocol NewEventPopoverDelegate;

@protocol NewEventPopoverDelegate <NSObject>

-(void)cancelNewTaskForItem:(WEDayViewItem *)eventDayItem;

@end


@interface WECalendarEventPopoverView : NSViewController <NSPopoverDelegate>
{
    id <NewEventPopoverDelegate> delegate;
    WEDayViewItem *dayItem;
}

-(WECalendarEventPopoverView *)initWithDay:(WEDayViewItem *)eventDayItem;


@property (strong)id <NewEventPopoverDelegate> delegate;
@property (strong) IBOutlet NSDatePicker *startTimePicker;

@property (strong) IBOutlet NSDatePicker *endTimePicker;
@property (strong) IBOutlet NSTextField *eventAddressTF;
@property (strong) IBOutlet NSTextView *eventDescriptionTV;
@property (strong) IBOutlet NSTextField *startMonthLabel;
@property (strong) IBOutlet NSTextField *startDayLabel;
@property (strong) IBOutlet NSTextField *startHourLabel;
@property (strong) IBOutlet NSTextField *startMinuteLabel;

- (IBAction)newEventViewAction:(NSButton *)sender;
- (IBAction)timePickerAction:(NSDatePicker *)sender;


@end
