//
//  AppDelegate.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/13/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "AppDelegate.h"
#import "WECalendarViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize calendarViewController;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    calendarViewController = [[WECalendarViewController alloc]initWithNibName:@"WECalendarViewController" bundle:nil];
    [self.window setContentViewController:calendarViewController];
    [self.window makeKeyWindow];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
