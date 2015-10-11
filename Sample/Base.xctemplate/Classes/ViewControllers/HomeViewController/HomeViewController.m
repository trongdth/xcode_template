//
//  HomeViewController.m
//  ClockControl
//
//  Created by Trong_iOS on 3/24/15.
//  Copyright (c) 2015 Robotbase. All rights reserved.
//

#import "HomeViewController.h"
#import "MyNavigationViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initObj];
    [self createUI];
    
}

-  (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Obj

- (void)initObj {
   
}

#pragma mark - UI

- (void)createUI {
    [self createNav];
}

- (void)createNav {

}


@end