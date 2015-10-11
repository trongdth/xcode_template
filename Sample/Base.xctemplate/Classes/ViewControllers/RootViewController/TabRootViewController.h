//
//  RootViewController.h
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//all tags from 600000 is global tag,dont use it
#define VTAG_CONTAINER              600000

@class HomeViewController;
@interface TabRootViewController : UITabBarController <UIActionSheetDelegate>
{
    NSMutableArray* _tabButtons;
    HomeViewController *vcHome;
}

@property (nonatomic) CGSize keyboardSize;

//STATIC
+ (TabRootViewController*) shared;
- (void)showTabBar:(BOOL)show;
- (void)onTabBarItemTap:(UIButton*)sender;
- (void)setIndexFocus:(int)index;

@end
