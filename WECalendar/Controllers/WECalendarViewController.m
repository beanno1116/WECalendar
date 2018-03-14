//
//  WECalendarViewController.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/13/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WECalendarViewController.h"
#import "WECalendarCollectionView.h"
#import "WECalendar.h"
#import "WEDayView.h"
#import "WEDayViewItem.h"
#import "WEDefaultLayout.h"
#import "WECalendarBackgroundView.h"
#import "WECalendarEventPopoverView.h"
#import "WEWrappedLayout.h"
#import "WEGridLayout.h"
#import "Day.h"
#import "Month.h"
#import "Year.h"

static NSString *selectionIndexPathsKey = @"selectionIndexPaths";


@interface WECalendarViewController ()



@end

@implementation WECalendarViewController

@synthesize dayCollectionView;
@synthesize activeCalendar;
@synthesize eventPO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self buildModel];
    [self updateLayout];
    NSView *bgView = [[WECalendarBackgroundView alloc]initWithFrame:NSMakeRect(0, 0, 100, 100)];
    [dayCollectionView setBackgroundView:bgView];
    
    
    [dayCollectionView addObserver:self forKeyPath:selectionIndexPathsKey options:0 context:NULL];
}

-(void)buildModel{
    NSDate *sd = [self dateTimeFromString:@"11/16/1983 00:00:00"];
    NSDate *ed = [self dateTimeFromString:@"11/16/2023 23:59:00"];
    
    activeCalendar = [[WECalendar alloc]initWithStartDate:sd endDate:ed];
    
}
- (void)updateLayout {
    
    NSCollectionViewLayout *layout = nil;
    layout = [[WEGridLayout alloc]init];
    if (layout) {
        if (NSAnimationContext.currentContext.duration > 0.0) {
            NSAnimationContext.currentContext.duration = 0.5;
            dayCollectionView.animator.collectionViewLayout = layout;
        } else {
            dayCollectionView.collectionViewLayout = layout;
        }
    }
}

-(NSDate *)dateTimeFromString:(NSString *)dateStr{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *td = [df dateFromString:dateStr];
    if (td == nil) {
        [df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        td = [df dateFromString:dateStr];
    }
    return td;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == dayCollectionView && [keyPath isEqual:selectionIndexPathsKey]) {
        
    
    }
}



-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    NSLog(@"SELECTED");
    NSIndexPath *tmpPath = [[indexPaths allObjects] firstObject];
    if ([eventPO isShown]) {
        
        [eventPO close];
    }else{
        if (tmpPath != nil) {
            WEDayViewItem *di = (WEDayViewItem *)[collectionView itemAtIndexPath:tmpPath];
            if ([[[di view] subviews] count] > 0) {
                [di setIsEditing:YES];
                eventPopoverViewController = [[WECalendarEventPopoverView alloc]initWithDay:di];
                eventPO = [[NSPopover alloc]init];
                [eventPopoverViewController setDelegate:self];
                [eventPO setDelegate:eventPopoverViewController];
                [eventPO setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];
                [eventPO setContentViewController:eventPopoverViewController];
                [eventPO showRelativeToRect:di.view.bounds ofView:di.view preferredEdge:NSRectEdgeMaxY];
            }
        }
    }
    
}



-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 35;
}

-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NSCollectionViewItem *day = [collectionView makeItemWithIdentifier:@"WEDayViewItem" forIndexPath:indexPath];
    long startNumber = [Day dayNumberFromString:[[activeCalendar curMonth] startDay]];
    long index = [indexPath item] - startNumber;
    if (index < [[[activeCalendar curMonth] daysOfMonth]count]) {
        if ([indexPath item] > startNumber - 1) {
            day.representedObject = [[[activeCalendar curMonth]daysOfMonth]objectAtIndex:index];
        }else{
            day.representedObject = nil;
        }
    }else{
        day.representedObject = nil;
    }
    return day;
}




-(void)cancelNewTaskForItem:(WEDayViewItem *)eventDayItem{
    if ([eventPO isShown]) {
        [dayCollectionView deselectAll:dayCollectionView];
        [eventDayItem setIsEditing:NO];
        [eventPO performClose:self];
        eventPopoverViewController = nil;
        eventPO = nil;
    }
}

@end
