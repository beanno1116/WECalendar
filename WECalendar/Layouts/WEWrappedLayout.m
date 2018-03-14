//
//  WEWrappedLayout.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WEWrappedLayout.h"


@implementation WEWrappedLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setItemSize:NSMakeSize(50, 50)];
        [self setMinimumInteritemSpacing:10];
        [self setMinimumLineSpacing:10];
        [self setSectionInset:NSEdgeInsetsMake(10, 10, 10, 10)];
    }
    return self;
}

- (NSCollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSCollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [attributes setZIndex:[indexPath item]];
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(NSRect)rect {
    NSArray *layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
    for (NSCollectionViewLayoutAttributes *attributes in layoutAttributesArray) {
        [attributes setZIndex:[[attributes indexPath] item]];
    }
    return layoutAttributesArray;
}
@end
