//
//  Year.m
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "Year.h"

@implementation Year

@synthesize monthArray;
@synthesize year;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    monthArray = [aDecoder decodeObjectForKey:@"monthArray"];
    year = [aDecoder decodeObjectForKey:@"year"];
    return self;
}

-(Year *)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    monthArray = [[NSMutableArray alloc]init];
    year = @"";
    
    return self;
}

-(long)yearNumber{
    long tl = [year longLongValue];
    if (tl != 0) {
        return tl;
    }else{
        return -1;
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
   
    [aCoder encodeObject:monthArray forKey:@"monthArray"];
    [aCoder encodeObject:year forKey:@"year"];
   
}

@end
