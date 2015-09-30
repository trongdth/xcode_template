//
//  TouchUITableView.m
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import "TouchUITableView.h"

@implementation TouchUITableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // send action to delegate
    if ([self.delegate respondsToSelector:@selector(didTouchTable:)]) {
        [self.delegate performSelector:@selector(didTouchTable:) withObject:event];
    }
    //call didSelectRow of tableView again, by passing the touch to the super class
    [super touchesBegan:touches withEvent:event];
}

- (void)reloadData {
    NSLog(@"BEGIN reloadData");
    [super reloadData];
    NSLog(@"END reloadData");
}

@end
