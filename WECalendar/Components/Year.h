//
//  Year.h
//  CollectionViewTest
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/6/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Year : NSObject <NSCoding>
{
    NSMutableArray *monthArray;
    NSString *year;
}

@property (strong,nonatomic)NSMutableArray *monthArray;
@property (strong,nonatomic)NSString *year;

-(Year *)init;
-(long)yearNumber;
@end
