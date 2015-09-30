//
//  BaseTableViewController.m
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize tblView = _tblView;
@synthesize tblDelegate = _tblDelegate, tblDataSource = _tblDataSource;
@synthesize _reloading;
@synthesize refreshHeaderView = _refreshHeaderView;

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundleWithPullToRefresh:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isPullToRefresh = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundleWithMovingNavBar:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isMovingNavBar = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isPullToRefresh = NO;
    }
    return self;
}

#pragma mark - View life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    
    if(isPullToRefresh) {
        [self createEGO];
        
    }
}

-(void) viewDidUnload {
    [super viewDidUnload];
    _refreshHeaderView = nil;
    self.tblDataSource = nil;
    self.tblDelegate = nil;
    self.tblView = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.scrollForHideNavigation){
        float topInset = self.navigationController.navigationBar.frame.size.height;
        self.scrollForHideNavigation.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    } else {
        self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                   0,
                                                                   self.navigationController.navigationBar.frame.size.width,
                                                                   self.navigationController.navigationBar.frame.size.height);
    }
}

#pragma mark - UI

- (void)createEGO {
    _reloading = NO;
    
    if (isPullToRefresh) {
        [self setupPullToRefresh];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
-(void) setupPullToRefresh {
    if (_refreshHeaderView == nil) {
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tblView.bounds.size.height, 320.0f, _tblView.bounds.size.height)];
		[_tblView addSubview:_refreshHeaderView];
		_tblView.showsVerticalScrollIndicator = YES;
	}
}

- (void) enablePullToRefresh
{
    isPullToRefresh = YES;
}

- (void)reloadTableViewDataSource{
    _reloading = YES;
}

- (void)doneLoadingTableViewData{
    // model should call this when its done loading
    _reloading = NO;
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[_tblView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
    
    if ([_refreshHeaderView state] != EGOOPullRefreshNormal) {
        [_refreshHeaderView setState:EGOOPullRefreshNormal];
        [_refreshHeaderView setCurrentDate];  //  should check if data reload was successful
    }
}

#pragma mark ego forward event
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView.isDragging && isPullToRefresh) {
		if (_refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[_refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (_refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[_refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
    
    if(isMovingNavBar) {
        if(self.scrollForHideNavigation != scrollView)
            return;
        if(scrollView.frame.size.height >= scrollView.contentSize.height)
            return;
        
        if(scrollView.contentOffset.y > -self.navigationController.navigationBar.frame.size.height && scrollView.contentOffset.y < 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if(scrollView.contentOffset.y >= 0)
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        if(lastOffsetY < scrollView.contentOffset.y && scrollView.contentOffset.y >= -self.navigationController.navigationBar.frame.size.height){//moving up
            
            if(self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y  > 0){//not yet hidden
                float newY = self.navigationController.navigationBar.frame.origin.y - (scrollView.contentOffset.y - lastOffsetY);
                if(newY < -self.navigationController.navigationBar.frame.size.height)
                    newY = -self.navigationController.navigationBar.frame.size.height;
                self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                           newY,
                                                                           self.navigationController.navigationBar.frame.size.width,
                                                                           self.navigationController.navigationBar.frame.size.height);
            }
        } else
            if(self.navigationController.navigationBar.frame.origin.y < [UIApplication sharedApplication].statusBarFrame.size.height  &&
               (self.scrollForHideNavigation.contentSize.height > self.scrollForHideNavigation.contentOffset.y + self.scrollForHideNavigation.frame.size.height)){//not yet shown
                float newY = self.navigationController.navigationBar.frame.origin.y + (lastOffsetY - scrollView.contentOffset.y);
                if(newY > [UIApplication sharedApplication].statusBarFrame.size.height)
                    newY = [UIApplication sharedApplication].statusBarFrame.size.height;
                self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                           newY,
                                                                           self.navigationController.navigationBar.frame.size.width,
                                                                           self.navigationController.navigationBar.frame.size.height);
            }
        
        lastOffsetY = scrollView.contentOffset.y;
    }

    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    if (scrollView.contentOffset.y <= - 65.0f && !_reloading && isPullToRefresh) {
        _reloading = YES;
        [self reloadTableViewDataSource];
        [_refreshHeaderView setState:EGOOPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        self.tblView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
	}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    isDecelerating = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    isDecelerating = NO;
}


#pragma mark - Functions

- (BaseTableDataSource*) getDataSource {
    return self.tblDataSource;
}

- (BaseTableDelegate*)  getDelegate {
    return self.tblDelegate;
}

-(void) resizeTableToFrame:(CGRect) tableRect {
    _tblView.frame = tableRect;
}

@end
