//
//  RootViewController.m
//  xemHDFilm
//
//  Created by Trong Dinh on 7/15/14.
//  Copyright (c) 2014 com.mroom.xemHDFilm. All rights reserved.
//

#import "RootViewController.h"
#import "TabRootViewController.h"
#import "Validations.h"
#import "MyNavigationViewController.h"
#import "MenuViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

//STATIC
+ (RootViewController*) shared
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initObj {
    _arrRetains = [NSMutableArray new];
}

#pragma mark - view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initObj];
    [self createUI];
}

- (void)didReceiveMemoryWarning
{
    [_arrRetains removeAllObjects];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {

}

#pragma mark - UI

- (void)createUI {
    NSLog(@"createUI:");
    [self run];
}

#pragma mark - Functions

- (void)run {
    if(!isLoaded) {
        isLoaded = YES;
        
        MyNavigationViewController *navigationController = [[MyNavigationViewController alloc] initWithRootViewController:[TabRootViewController shared]];
        [[TabRootViewController shared].tabBar setHidden:YES];
        navigationController.navigationBarHidden = YES;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MenuViewController *menuController = [storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];
        
        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
        frostedViewController.direction = REFrostedViewControllerDirectionLeft;
        frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
        frostedViewController.panGestureEnabled = YES;
        frostedViewController.liveBlur = YES;
        frostedViewController.delegate = self;

        [self.view addSubview:frostedViewController.view];
        [_arrRetains addObject:frostedViewController];
    }
}

#pragma mark - REFrostedViewControllerDelegate methods

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    DLog(@"didRecognizePanGesture");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController
{
    DLog(@"willShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    DLog(@"didShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController
{
    DLog(@"willHideMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController
{
    DLog(@"didHideMenuViewController");
}

@end
