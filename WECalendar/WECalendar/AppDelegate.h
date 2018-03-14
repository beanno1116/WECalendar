//
//  AppDelegate.h
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/13/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WECalendarViewController;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    WECalendarViewController *calendarViewController;
}

@property (strong)WECalendarViewController *calendarViewController;
@end

