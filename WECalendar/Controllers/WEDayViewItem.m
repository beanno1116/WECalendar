//
//  WEDayViewItem.m
//  WECalendar
//
//  Created by BENJAMIN KLIMASZEWSKI on 3/14/18.
//  Copyright © 2018 WebEntities. All rights reserved.
//

#import "WEDayViewItem.h"
#import "CurrentDayHighlightView.h"
#import "WEDayView.h"
#import "Day.h"

@interface WEDayViewItem ()

@end

@implementation WEDayViewItem



-(void)setHighlightState:(NSCollectionViewItemHighlightState)newHighlightState {
    [super setHighlightState:newHighlightState];
    
    // Relay the newHighlightState to our AAPLSlideCarrierView.
    [(WEDayView *)[self view] setHighlightState:newHighlightState];
}
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    // Relay the new "selected" state to our AAPLSlideCarrierView.
    [(WEDayView *)[self view] setSelected:selected];
}
-(void)setIsEditing:(BOOL)flag{
    [(WEDayView *)[self view] setIsEditing:flag];
}
-(BOOL)isEditing{
    return [(WEDayView *)[self view] isEditing];
}


-(void)setRepresentedObject:(id)newRepresentedObject {
    [super setRepresentedObject:newRepresentedObject];
    
    if ([newRepresentedObject isKindOfClass:[Day class]]) {
        [self removeAllSubviews];
        Day *newDay = newRepresentedObject;
        [newDay setIsToday];
        if ([newDay isToday]) {
            [self showDayNumberLabel:[NSString stringWithFormat:@"%ld",[newDay _dayNumber]]];
            [self showDayNumberView];
        }else{
            [self showDayNumberLabel:[NSString stringWithFormat:@"%ld",[newDay _dayNumber]]];
        }
    }else if (newRepresentedObject == nil){

    
    }
}
-(void)showDayNumberLabel:(NSString *)dayNumber{
    NSSize tfSize = [self dayLabelSize];
    float vWidth = self.view.frame.size.width;
    float vHeight = self.view.frame.size.height;
    float tw = tfSize.width + 9;
    float th = tfSize.height;
    float to = 5.0f;
    float t2 = tw / 2;
    
    
    NSRect trect = NSMakeRect((vWidth / 2) - t2, (vHeight - th) - to, tw, th);
    dayNumberlabel = [[NSTextField alloc]initWithFrame:trect];
    [dayNumberlabel setDrawsBackground:NO];
    [dayNumberlabel setBordered:NO];
    [dayNumberlabel setBezeled:NO];
    [dayNumberlabel setSelectable:NO];
    
    
    
    [dayNumberlabel setAttributedStringValue:[self styledDayString:dayNumber]];
    [[self view] addSubview:dayNumberlabel];
    
}
-(void)showDayNumberView{
    
    currenDayHighlight = [[CurrentDayHighlightView alloc]initWithFrame:NSMakeRect(self.view.frame.size.width / 2 - 15,self.view.frame.size.height - 35,30,30)];
    [[self view] addSubview:currenDayHighlight positioned:NSWindowBelow relativeTo:dayNumberlabel];

}
-(NSSize)dayLabelSize{
    // BUILD CUSTOM FONT AND SIZE AND COLOR DEFAULT IMPACT 18.0f
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc]init];
    [ps setAlignment:NSTextAlignmentCenter];
    NSFont *font = [NSFont fontWithName:@"Impact" size:18.0f];
    NSDictionary *attrDict = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : ps, NSForegroundColorAttributeName : [NSColor blackColor]};
    NSSize tmpSize = [@"99" sizeWithAttributes:attrDict];
    return tmpSize;
}

-(NSAttributedString *)styledDayString:(NSString *)dayNumberStr{
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc]init];
    [ps setAlignment:NSTextAlignmentCenter];
    NSFont *font = [NSFont fontWithName:@"Impact" size:18.0f];
    NSDictionary *attrDict = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : ps, NSForegroundColorAttributeName : [NSColor blackColor]};
    NSAttributedString *tas = [[NSAttributedString alloc] initWithString:dayNumberStr attributes:attrDict];
    if (tas) {
        return tas;
    }else{
        return tas;
    }
}






-(void)removeAllSubviews{
    NSArray *tmpArray = [[NSArray alloc]init];
    [[self view] setSubviews:tmpArray];
}


- (void)mouseDown:(NSEvent *)theEvent {
    if ([theEvent clickCount] == 2) {
        NSLog(@"Double Clicked");
    } else {
        [super mouseDown:theEvent];
    }
}

@end
