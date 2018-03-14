//
//  WECalendarCollectionView.h
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WECalendarCollectionView : NSCollectionView
{
    BOOL addEventShowing;
}

-(WECalendarCollectionView *)init;


@property (assign)BOOL addEventShowing;

@end
