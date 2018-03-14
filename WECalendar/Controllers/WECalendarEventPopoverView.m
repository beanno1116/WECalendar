//
//  WECalendarEventPopoverView.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WECalendarEventPopoverView.h"
#import "WEDayViewItem.h"
#import "Day.h"

@interface WECalendarEventPopoverView ()

@end

@implementation WECalendarEventPopoverView
@synthesize delegate;

-(WECalendarEventPopoverView *)initWithDay:(WEDayViewItem *)eventDayItem{
    self = [super initWithNibName:@"WECalendarEventPopoverView" bundle:nil];
    if (!self) {
        return nil;
    }
    
    dayItem = eventDayItem;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_startTimePicker setDatePickerStyle:NSTextFieldDatePickerStyle];
    [self startPickerStartDate];
    
}

-(BOOL)newEvent{
    if ([[self validateEventData]count] == 0) {
        return YES;
    }else{
        return NO;
    }
}

-(NSArray *)validateEventData{
    NSMutableArray *tma = [[NSMutableArray alloc]init];
    if ([[_eventAddressTF stringValue] isEqualToString:@""]) {
        [tma addObject:[NSNumber numberWithLong:[_eventAddressTF tag]]];
    }
    if ([[_eventDescriptionTV string] isEqualToString:@"Add event description..."] || [[_eventDescriptionTV string] isEqualToString:@""]){
        [tma addObject:[NSNumber numberWithUnsignedLong:[_eventDescriptionTV tag]]];
    }
    
    return [NSArray arrayWithArray:tma];
}

-(void)startPickerStartDate{
    Day *td = (Day*)[dayItem representedObject];
    NSDate *sd = [td date];
    [_startTimePicker setDateValue:sd];
    [self updateStartPickerDisplay];
}

-(void)updateStartPickerDisplay{
    Day *td = (Day*)[dayItem representedObject];
    NSArray *dateTimeComponents = [[td stringDateWithFormat:@"MMM d, HH:mm"] componentsSeparatedByString:@" "];
    long count = [dateTimeComponents count];
    _startMonthLabel.stringValue = [dateTimeComponents objectAtIndex:0];
    _startDayLabel.stringValue = [dateTimeComponents objectAtIndex:1];
    
}

- (IBAction)newEventViewAction:(NSButton *)sender {
    switch ([sender tag]) {
        case 1:
            [delegate cancelNewTaskForItem:dayItem];
            break;
        case 2:
            [self newEvent];
            break;
        default:
            break;
    }
}

- (IBAction)timePickerAction:(NSDatePicker *)sender {
}
@end
