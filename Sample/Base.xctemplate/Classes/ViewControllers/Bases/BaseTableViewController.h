//
//  BaseTableViewController.h
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TouchUITableView.h"
#import "EGORefreshTableHeaderView.h"

@class BaseTableDelegate;
@class BaseTableDataSource;
@interface BaseTableViewController : BaseViewController <UIScrollViewDelegate> {
    BOOL isPullToRefresh, isMovingNavBar;
    
    CGFloat lastOffsetY;
    BOOL isDecelerating;
}

@property  (nonatomic, strong) BaseTableDataSource *tblDataSource;
@property  (nonatomic, strong) BaseTableDelegate *tblDelegate;
@property  (nonatomic, strong) IBOutlet TouchUITableView *tblView;
@property  (nonatomic, strong) IBOutlet UIScrollView *scrollForHideNavigation;
@property  (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property   (nonatomic) BOOL   _reloading;;

- (id)initWithNibName:(NSString *)nibNameOrNil bundleWithPullToRefresh:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString *)nibNameOrNil bundleWithMovingNavBar:(NSBundle *)nibBundleOrNil;

- (void) resizeTableToFrame:(CGRect) tableRect;
- (BaseTableDataSource*) getDataSource;
- (BaseTableDelegate*)  getDelegate;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void) setupPullToRefresh;

@end
