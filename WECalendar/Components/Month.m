//
//  Month.m
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "Month.h"
#import "Day.h"

@implementation Month

@synthesize startDay, endDay, name;
@synthesize numOfDays, monthNumber, yearNumber;
@synthesize daysOfMonth;

-(Month *)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    daysOfMonth = [[NSMutableArray alloc]init];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    startDay = [aDecoder decodeObjectForKey:@"startDay"];
    endDay = [aDecoder decodeObjectForKey:@"endDay"];
    name = [aDecoder decodeObjectForKey:@"name"];
    numOfDays = [aDecoder decodeIntegerForKey:@"numOfDays"];
    monthNumber = (long)[aDecoder decodeIntegerForKey:@"monthNumber"];
    yearNumber = (long)[aDecoder decodeIntegerForKey:@"yearNumber"];
    daysOfMonth = [aDecoder decodeObjectForKey:@"daysOfMonth"];
    return self;
}

+(NSString *)monthNameFromNumber:(long)monthNum{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSString *ts = [[df monthSymbols] objectAtIndex:monthNum];
    if (ts) {
        return ts;
    }else{
        return ts;
    }
}
+(long)monthNumberFromName:(NSString *)monthName{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    long tl = -1;
    tl = [[df monthSymbols] indexOfObject:monthName];
    if (tl >= 0) {
        return tl + 1;
    }else{
        return tl;
    }
}




-(void)createDaysOfMonth{
    if (numOfDays != 0) {
        for (int i = 0; i < numOfDays; i++) {
            Day *td = [[Day alloc] initWithDayNumber:i + 1 andMonthNumber:monthNumber andYearNumber:yearNumber];
            [daysOfMonth addObject:td];
        }
    }
}


-(NSString *)findStartDayForMonthInYear:(long)year{
    
    NSDate *curDate = [self dateForStartInYear:year];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:curDate];
    if (dayName) {
        return dayName;
    }else{
        return nil;
    }
}
-(NSString *)findEndDayForMonthInYear:(long)year{
    NSDate *curDate = [self dateForEndInYear:year];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:curDate];
    if (dayName) {
        return dayName;
    }else{
        return nil;
    }
}


-(NSDate *)dateForStartInYear:(long)year{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSString *tmpDateStr = [NSString  stringWithFormat:@"0%ld/01/%ld",[Month monthNumberFromName:name],year];
    NSDate *td = [df dateFromString:tmpDateStr];
    if (td) {
        return td;
    }else{
        return nil;
    }
}
-(NSDate *)dateForEndInYear:(long)year{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSString *tmpDateStr = [NSString  stringWithFormat:@"0%ld/%ld/%ld",[Month monthNumberFromName:name],numOfDays,year];
    NSDate *td = [df dateFromString:tmpDateStr];
    
    if (td) {
        return td;
    }else{
        return nil;
    }
}
-(NSString *)component:(NSString *)component fromDate:(NSDate *)date{
    
    NSString *rComponent;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy"];
    if ([component isEqualToString:@"day"]) {
        NSString *ts = [df stringFromDate:date];
        NSArray *dArray = [ts componentsSeparatedByString:@"/"];
        rComponent = [dArray objectAtIndex:1];
    }else if ([component isEqualToString:@"month"]){
        NSString *ts = [df stringFromDate:date];
        NSArray *dArray = [ts componentsSeparatedByString:@"/"];
        rComponent = [dArray objectAtIndex:0];
    }else if ([component isEqualToString:@"year"]){
        NSString *ts = [df stringFromDate:date];
        NSArray *dArray = [ts componentsSeparatedByString:@"/"];
        rComponent = [dArray objectAtIndex:2];
    }
    
    if (rComponent != nil) {
        return rComponent;
    }else{
        return nil;
    }
}



-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:startDay forKey:@"startDay"];
    [aCoder encodeObject:endDay forKey:@"endDay"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeInteger:numOfDays forKey:@"numOfDays"];
    [aCoder encodeInteger:monthNumber forKey:@"monthNumber"];
    [aCoder encodeInteger:yearNumber forKey:@"yearNumber"];
    [aCoder encodeObject:daysOfMonth forKey:@"daysOfMonth"];
    
}
@end
