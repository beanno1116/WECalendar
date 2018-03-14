//
//  Day.h
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WECalendarEvent;

@interface Day : NSObject <NSCoding>
{
    long _dayNumber,_monthNumber,_yearNumber;
    long position;
    NSString *name;
    BOOL isToday;
    NSMutableArray *dayEvents;
}

@property (assign)long _dayNumber,_monthNumber,_yearNumber;
@property (copy)NSString *name;
@property (strong)NSMutableArray *dayEvents;

+(NSString *)dayStringFromNumber:(long)dayNumber;
+(long)dayNumberFromString:(NSString *)dayString;

-(Day *)init;
-(Day *)initWithDayNumber:(long)dayNumber andMonthNumber:(long)monthNumber andYearNumber:(long)yearNumber;
-(void)dayNameString;

-(NSString *)stringDateWithFormat:(NSString *)format;
-(NSDate *)date;


-(void)setIsToday;
-(BOOL)isToday;

@end
