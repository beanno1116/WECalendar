//
//  WECalendar.m
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WECalendar.h"
#import "Year.h"
#import "Month.h"

@implementation WECalendar
@synthesize _startDate, _endDate;
@synthesize _calendarType;
@synthesize locale;
@synthesize unitsForCalendar;
@synthesize doesCache;

-(WECalendar *)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    doesCache = YES;
    return self;
}

-(WECalendar *)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    doesCache = YES;
    _startDate = startDate;
    _endDate = endDate;
    
    unitsForCalendar = [[NSMutableArray alloc]init];
    [self calendarComponentSetup];
    
    return self;
}



-(void)calendarComponentSetup{
    [self calendarDays];
    [self setCurYear];
    [self setPrevYear];
    [self setNextYear];
    
    [self setCurMonth];
    [self setNextMonth];
    [self setPrevMonth];
}



-(BOOL)createNewEvent{
    return FALSE;
}
-(BOOL)removeEvent{
    return FALSE;
}
-(void)checkForEvents{
    
}


-(long)daysInMonth:(NSString *)month{
    NSDate *td = [self monthDateFromString:month];
    NSCalendar *tc = [NSCalendar currentCalendar];
    NSRange range = [tc rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:td];
    long days = range.length;
    
    return days;
}
-(NSDate *)monthDateFromString:(NSString *)mStr{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSDate *td = [df dateFromString:mStr];
    
    return td;
}
-(long)yearsInCalendar{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    NSCalendar *tc = [NSCalendar currentCalendar];
    NSDateComponents *dc = [tc components:NSCalendarUnitYear fromDate:_startDate toDate:_endDate options:0];
    long nyears = [dc year];
    
    return nyears;
}
-(NSString *)component:(NSString *)component fromDate:(NSDate *)date{
    
    NSString *rComponent;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    if ([component isEqualToString:@"day"]) {
        NSString *ts = [df stringFromDate:date];
        NSArray *dtArray = [ts componentsSeparatedByString:@" "];
        NSArray *dArray = [[dtArray objectAtIndex:0] componentsSeparatedByString:@"/"];
        rComponent = [dArray objectAtIndex:1];
    }else if ([component isEqualToString:@"month"]){
        NSString *ts = [df stringFromDate:date];
        NSArray *dtArray = [ts componentsSeparatedByString:@" "];
        NSArray *dArray = [[dtArray objectAtIndex:0] componentsSeparatedByString:@"/"];
        rComponent = [dArray objectAtIndex:0];
    }else if ([component isEqualToString:@"year"]){
        NSString *ts = [df stringFromDate:date];
        NSArray *dtArray = [ts componentsSeparatedByString:@" "];
        NSArray *dArray = [[dtArray objectAtIndex:0] componentsSeparatedByString:@"/"];
        rComponent = [dArray objectAtIndex:2];
    }
    
    if (rComponent != nil) {
        return rComponent;
    }else{
        return nil;
    }
}
-(NSDate *)nowDateTime{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *ts = [df stringFromDate:[NSDate date]];
    NSDate *rd = [df dateFromString:ts];
    return rd;
}

-(void)previousYear{
    nextYear = curYear;
    curYear = prevYear;
    prevYear = [self prevYearObject];
}
-(void)forwardYear{
    prevYear = curYear;
    curYear = nextYear;
    nextYear = [self nextYearObject];
}

-(void)previousMonth{
    nextMonth = curMonth;
    curMonth = prevMonth;
    prevMonth = [self prevMonthObject];
    
}
-(void)forwardMonth{
    prevMonth = curMonth;
    curMonth = nextMonth;
    nextMonth = [self nextMonthObject];
    
    
}

-(void)calendarDays{
    if ([self checkForCachedCalendar]) {
        [self unCacheCalendar];
    }else{
        long years  = [self yearsInCalendar];
        long startYear = [[self component:@"year" fromDate:_startDate] longLongValue];
        long monthCount = 12;
        for (int i = 0; i < years; i++) {
            
            Year *year = [[Year alloc]init];
            [year setYear:[NSString stringWithFormat:@"%ld",startYear]];
            
            for (int k = 0; k < monthCount; k++){
                
                NSString *tmpDateStr = [NSString stringWithFormat:@"0%d/01/%ld",k + 1,startYear];
                
                Month *month = [[Month alloc]init];
                [month setNumOfDays:[self daysInMonth:tmpDateStr]];
                [month setName:[Month monthNameFromNumber:(long)k]];
                [month setMonthNumber:(long)k + 1];
                [month setYearNumber:startYear];
                [month createDaysOfMonth];
                [month setStartDay:[month findStartDayForMonthInYear:startYear]];
                [month setEndDay:[month findEndDayForMonthInYear:startYear]];
                [[year monthArray] addObject:month];
                
            }
            
            NSString *tys = [NSString stringWithFormat:@"%ld",startYear];
            NSDictionary *tmp = @{
                                  @"year": tys,
                                  @"year_obj": year
                                  };
            [unitsForCalendar addObject:tmp];
            startYear++;
        }
        [self cacheCalendar];
    }
}


-(NSString *)getCurrentYear{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:@"yyyy"];
    NSDate *nd = [NSDate date];
    NSString *tmpDStr = [df stringFromDate:nd];
    if (tmpDStr) {
        return tmpDStr;
    }else{
        return nil;
    }
}

-(Year *)currentYearObject{
    Year *tmpy;
    for (NSDictionary *dd in unitsForCalendar) {
        if ([[dd objectForKey:@"year"] isEqualToString:[self getCurrentYear]]) {
            tmpy = [dd objectForKey:@"year_obj"];
            if (tmpy) {
                return tmpy;
            }
        }
    }
    NSLog(@"ERROR=> NO YEAR OBJECT FOUND!");
    return nil;
}
-(Year *)prevYearObject{
    long curYearNum = [[curYear year] longLongValue];
    long prevYearNum = curYearNum - 1;
    NSString *tmp = [NSString stringWithFormat:@"%ld",prevYearNum];
    Year *tmpy;
    for (NSDictionary *dd in unitsForCalendar) {
        if ([[dd objectForKey:@"year"] isEqualToString:tmp]) {
            tmpy = [dd objectForKey:@"year_obj"];
            if (tmpy) {
                return tmpy;
            }
        }
    }
    NSLog(@"ERROR=> NO YEAR OBJECT FOUND!");
    return nil;
}
-(Year *)nextYearObject{
    long curYearNum = [[curYear year] longLongValue];
    long nextYearNum = curYearNum + 1;
    NSString *tmp = [NSString stringWithFormat:@"%ld",nextYearNum];
    Year *tmpy;
    for (NSDictionary *dd in unitsForCalendar) {
        if ([[dd objectForKey:@"year"] isEqualToString:tmp]) {
            tmpy = [dd objectForKey:@"year_obj"];
            if (tmpy) {
                return tmpy;
            }
        }
    }
    NSLog(@"ERROR=> NO YEAR OBJECT FOUND!");
    return nil;
}

-(Month *)currentMonthObject{
    
    long nowMonth = [[self component:@"month" fromDate:[self nowDateTime]] longLongValue];
    if (nowMonth != 0) {
        return [[curYear monthArray] objectAtIndex:nowMonth - 1];
    }else{
        return nil;
    }
}
-(Month *)prevMonthObject{
    long curMonthNum = [Month monthNumberFromName:[curMonth name]];
    long prevMonthNum = 0;
    Month *tmp;
    if (nextMonth != nil) {
        if ([curMonth yearNumber] < [nextMonth yearNumber]) {
            [self previousYear];
        }
        if (curMonthNum == 1) {
            tmp = [[prevYear monthArray] lastObject];
        }else{
            prevMonthNum = curMonthNum - 1;
            tmp = [[curYear monthArray] objectAtIndex:prevMonthNum - 1];
        }
    }else{
        prevMonthNum = curMonthNum - 1;
        tmp = [[curYear monthArray] objectAtIndex:prevMonthNum - 1];
    }
    if (tmp) {
        return tmp;
    }else{
        return nil;
    }
}
-(Month *)nextMonthObject{
    long curMonthNum = [Month monthNumberFromName:[curMonth name]];
    long nextMonthNum = 0;
    Month *tmp;
    if (prevMonth != nil) {
        if([curMonth yearNumber] > [prevMonth yearNumber]){
            [self forwardYear];
        }
        if (curMonthNum == 12) {
            tmp = [[nextYear monthArray] objectAtIndex:0];
        }else{
            nextMonthNum = curMonthNum + 1;
            tmp = [[curYear monthArray] objectAtIndex:nextMonthNum - 1];
        }
    }else{
        nextMonthNum = curMonthNum + 1;
        tmp = [[curYear monthArray] objectAtIndex:nextMonthNum - 1];
    }
    if (tmp) {
        return tmp;
    }else{
        return nil;
    }
}


-(BOOL)cacheCalendar{
    
    BOOL didCache = FALSE;
    didCache = [NSKeyedArchiver archiveRootObject:unitsForCalendar toFile:[self cachePath]];
    if (didCache) {
        return YES;
    }else{
        return NO;
    }

}
-(BOOL)unCacheCalendar{
    NSArray *tmp = [NSKeyedUnarchiver unarchiveObjectWithFile:[self cachePath]];
    unitsForCalendar = [[NSMutableArray alloc]initWithArray:tmp];
    if ([unitsForCalendar count] != 0 || unitsForCalendar != nil) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)checkForCachedCalendar{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fm fileExistsAtPath:[self cachePath] isDirectory:&isDir]) {
        return YES;
    }else{
        return NO;
    }
}

-(NSString *)cachePath{
   return [[self getCacheDirectory]stringByAppendingPathComponent:@"cal.cache"];
}
-(NSString *)getCacheDirectory{
   
    NSString *t = [[self applicationSupport]stringByAppendingPathComponent:@"WECalendar"];
    [self isDirectory:t];
    return t;
    
}

-(BOOL)isDirectory:(NSString *)directoryPath{
    BOOL isDir;
    NSError *error;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if (![filemgr fileExistsAtPath:directoryPath isDirectory:&isDir]){
        [filemgr createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return isDir;
}


-(NSString *)applicationSupport{
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    return docsDir;
}

-(void)setCurMonth{
    curMonth = [self currentMonthObject];
}
-(Month *)curMonth{
    return curMonth;
}

-(void)setPrevMonth{
    prevMonth = [self prevMonthObject];
}
-(Month *)prevMonth{
    return prevMonth;
}

-(void)setNextMonth{
    nextMonth = [self nextMonthObject];
}
-(Month *)nextMonth{
    return nextMonth;
}

-(void)setCurYear{
    curYear = [self currentYearObject];
}
-(Year *)curYear{
    return curYear;
}

-(void)setPrevYear{
    prevYear = [self prevYearObject];
}
-(Year *)prevYear{
    return prevYear;
}

-(void)setNextYear{
    nextYear = [self nextYearObject];
}
-(Year *)nextYear{
    return nextYear;
}


@end


