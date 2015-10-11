//
//  RootViewController.m
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import "TabRootViewController.h"
#import "HomeViewController.h"
#import "MyNavigationViewController.h"

@interface TabRootViewController ()

@end

@implementation TabRootViewController
static TabRootViewController* shared_ = nil;

//STATIC
+ (TabRootViewController*) shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared_ = [[TabRootViewController alloc] init];
    });
    
    return shared_;
}

//INIT

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        //Custom initialization           
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showTabBar:NO];
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    UIImageView* bkg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bkg.image = [[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [self.view insertSubview:bkg atIndex:0];
//    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbar_bg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    
	// Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor clearColor];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    vcHome = [storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    vcHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:1];
    MyNavigationViewController *navHome = [[MyNavigationViewController alloc] initWithRootViewController:vcHome];
    [self addChildViewController:navHome];

    
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (![self.tabBar viewWithTag:1001])
    {
        _tabButtons = [[NSMutableArray alloc] init];
        
        //fix tabbar item here
        UIView* myBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
        myBar.tag = 1001;
        int count = 1;
        float perWidth = 320/count;
        for (int i= 0; i<count;i++)
        {
            UIButton* bt = [[UIButton alloc] initWithFrame:CGRectMake(i*perWidth, 0, perWidth, 49)];
            bt.adjustsImageWhenHighlighted = NO;
            [myBar addSubview:bt];
            bt.tag = i;
            [_tabButtons addObject:bt];
            [bt addTarget:self action:@selector(onTabBarItemTap:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [self.tabBar addSubview:myBar];
        
        [self onTabBarItemTap:[_tabButtons objectAtIndex:0]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Tabbar

-(void)showTabBar:(BOOL)show {
    UITabBar* tabBar = self.tabBar;
    
    if ((!show && tabBar.frame.origin.y == [UIScreen mainScreen].bounds.size.height+1) || (show && tabBar.frame.origin.y == [UIScreen mainScreen].bounds.size.height-50))
        return;
    
    [UIView animateWithDuration:0.3 animations:^(void) {
        if (!show) {
            tabBar.frame = CGRectMake(tabBar.frame.origin.x, tabBar.frame.origin.y+50, tabBar.frame.size.width, tabBar.frame.size.height);
            UIView* subview = [self.view.subviews objectAtIndex:0];
            CGRect frame = subview.frame;
            frame.size.height += tabBar.frame.size.height * (show ? -1 : 1);
            subview.frame = frame;
        }
        else {
            tabBar.frame = CGRectMake(tabBar.frame.origin.x, tabBar.frame.origin.y-50, tabBar.frame.size.width, tabBar.frame.size.height);
        }
        
    } completion:^(BOOL finished) {
        if (show) {
            UIView* subview = [self.view.subviews objectAtIndex:0];
            CGRect frame = subview.frame;
            frame.size.height += tabBar.frame.size.height * (show ? -1 : 1);
            subview.frame = frame;
        }
    }];
}


#pragma mark - Selector methods

- (void)onTabBarItemTap:(UIButton*)sender
{
    int idx = (int)sender.tag;
    for (UIButton *bt in _tabButtons)
    {
        [bt setSelected:NO];
    }
    [sender setSelected:YES];
    [self setSelectedIndex:idx];
}

- (void)setIndexFocus:(int)index{
    [self onTabBarItemTap:[_tabButtons objectAtIndex:index]];
}

@end
