//
//  WECalendar.h
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Month,Year;

@interface WECalendar : NSObject 
{
    NSInteger _calendarType;
    NSLocale *locale;
    NSDate *_startDate;
    NSDate *_endDate;
    
    NSMutableArray *unitsForCalendar;
    
    Month *prevMonth;
    Month *curMonth;
    Month *nextMonth;
    
    Year *prevYear;
    Year *curYear;
    Year *nextYear;
    
    BOOL doesCache;
    
    
}


@property (strong)NSMutableArray *unitsForCalendar;
@property (strong)NSDate *_startDate, *_endDate;
@property (assign)NSInteger _calendarType;
@property (assign)BOOL doesCache;
@property (strong)NSLocale *locale;


-(WECalendar *)init;
-(WECalendar *)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

-(BOOL)createNewEvent;
-(BOOL)removeEvent;
-(void)checkForEvents;

-(void)previousYear;
-(void)forwardYear;
-(Year *)prevYear;
-(Year *)curYear;
-(Year *)nextYear;

-(void)previousMonth;
-(void)forwardMonth;
-(Month *)prevMonth;
-(Month *)curMonth;
-(Month *)nextMonth;


-(NSString *)cachePath;
@end
