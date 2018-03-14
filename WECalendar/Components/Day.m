//
//  Day.m
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "Day.h"

@implementation Day


@synthesize _dayNumber,_monthNumber,_yearNumber;
@synthesize dayEvents;
@synthesize name;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _dayNumber = [aDecoder decodeIntegerForKey:@"_dayNumber"];
    _monthNumber = [aDecoder decodeIntegerForKey:@"_monthNumber"];
    _yearNumber = [aDecoder decodeIntegerForKey:@"_yearNumber"];
    isToday = [aDecoder decodeBoolForKey:@"isToday"];
    name = [aDecoder decodeObjectForKey:@"name"];
    return self;
}

+(NSString *)dayStringFromNumber:(long)dayNumber{
    NSString *rStr;
    switch (dayNumber) {
        case 1:
            rStr = @"saturday";
            break;
        case 2:
            rStr = @"monday";
            break;
        case 3:
            rStr = @"tuesday";
            break;
        case 4:
            rStr = @"wednesday";
            break;
        case 5:
            rStr = @"thursday";
            break;
        case 6:
            rStr = @"friday";
            break;
        case 7:
            rStr = @"saturday";
            break;
        default:
            break;
    }
    if (rStr != nil) {
        return rStr;
    }else{
        return nil;
    }
}
+(long)dayNumberFromString:(NSString *)dayString{
    
    if ([[dayString lowercaseString] isEqualToString:@"monday"]) {
        return 1;
    }else if ([[dayString lowercaseString] isEqualToString:@"tuesday"]){
        return 2;
    }else if ([[dayString lowercaseString] isEqualToString:@"wednesday"]){
        return 3;
    }else if ([[dayString lowercaseString] isEqualToString:@"thursday"]){
        return 4;
    }else if ([[dayString lowercaseString] isEqualToString:@"friday"]){
        return 5;
    }else if ([[dayString lowercaseString] isEqualToString:@"saturday"]){
        return 6;
    }else if ([[dayString lowercaseString] isEqualToString:@"sunday"]){
        return 0;
    }else{
        return -1;
    }
}


-(Day *)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}
-(Day *)initWithDayNumber:(long)dayNumber andMonthNumber:(long)monthNumber andYearNumber:(long)yearNumber{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _dayNumber = dayNumber;
    _monthNumber = monthNumber;
    _yearNumber = yearNumber;
    dayEvents = [[NSMutableArray alloc]init];
    [self dayNameString];
    [self setIsToday];
    
    return self;
}

-(void)dayNameString{
    if (_dayNumber != 0 && _monthNumber != 0 && _yearNumber != 0) {
        NSString *tmp = [NSString stringWithFormat:@"%ld/%ld/%ld",_monthNumber,_dayNumber,_yearNumber];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        NSTimeZone *tz = [NSTimeZone defaultTimeZone];
        [df setTimeZone:tz];
        [df setDateFormat:@"M/d/yyyy"];
        NSDate *td = [df dateFromString:tmp];
        [df setDateFormat:@"EEEE"];
        tmp = [df stringFromDate:td];
        if (tmp) {
            name = tmp;
        }else{
            name = nil;
        }
    }
}

-(NSString *)stringDateWithFormat:(NSString *)format{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    [df setDateFormat:format];
    NSDate *td = [self date];
    NSString *ts = [df stringFromDate:td];
    if (ts) {
        return ts;
    }else{
        return nil;
    }
}

-(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [df setTimeZone:tz];
    NSString *ts = [NSString stringWithFormat:@"%ld/%ld/%ld %d:%d",_monthNumber,_dayNumber,_yearNumber,00,00];
    [df setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *td = [df dateFromString:ts];
    if (td) {
        return td;
    }else{
        return nil;
    }
}
-(NSArray *)eventData{
    return nil;
}

-(void)setIsToday{
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"M/d/yyyy"];
    NSString *ts = [df stringFromDate:today];
    today = [df dateFromString:ts];
    NSDate *nd = [df dateFromString:[NSString stringWithFormat:@"%ld/%ld/%ld",_monthNumber,_dayNumber,_yearNumber]];
    if (today == nd) {
        isToday = TRUE;
    }else{
        isToday = FALSE;
    }
}
-(BOOL)isToday{
    return isToday;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:_dayNumber forKey:@"_dayNumber"];
    [aCoder encodeInteger:_monthNumber forKey:@"_monthNumber"];
    [aCoder encodeInteger:_yearNumber forKey:@"_yearNumber"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeBool:isToday forKey:@"isToday"];

    
}

-(NSString *)boolToString{
    if (isToday) {
        return @"TRUE";
    }else{
        return @"FALSE";
    }
}

-(BOOL)stringToBOOL:(NSString *)bStr{
    if ([bStr isEqualToString:@"TRUE"]) {
        return YES;
    }else if ([bStr isEqualToString:@"FALSE"]){
        return NO;
    }else{
        return NO;
    }
}
@end
