//
//  Month.h
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Month : NSObject <NSCoding>
{
    long numOfDays;
    NSMutableArray *daysOfMonth;
    
    NSString *name;
    long monthNumber;
    long yearNumber;
    NSString *startDay;
    NSString *endDay;
}

@property (strong, nonatomic)NSString *name, *startDay, *endDay;
@property (strong, nonatomic)NSMutableArray *daysOfMonth;
@property (assign)long numOfDays, yearNumber, monthNumber;


-(Month *)init;

+(NSString *)monthNameFromNumber:(long)monthNum;
+(long)monthNumberFromName:(NSString *)monthName;


-(void)createDaysOfMonth;

-(NSString *)findStartDayForMonthInYear:(long)year;
-(NSString *)findEndDayForMonthInYear:(long)year;
@end
