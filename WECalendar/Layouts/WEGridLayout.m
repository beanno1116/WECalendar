//
//  WEGridLayout.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WEGridLayout.h"

@implementation WEGridLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setMaximumNumberOfRows:5];
        [self setMaximumNumberOfColumns:7];
        [self setMaximumItemSize:NSMakeSize(150, 150)];
        [self setMinimumItemSize:NSMakeSize(50, 50)];
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

-(NSCollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    NSCollectionViewLayoutAttributes *attrs = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    [attrs setAlpha:0];
    return attrs;
}
-(NSCollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    NSCollectionViewLayoutAttributes *attrs = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    [attrs setAlpha:0];
    return attrs;
}

@end
