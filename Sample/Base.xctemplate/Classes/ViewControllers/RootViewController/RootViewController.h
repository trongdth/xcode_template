//
//  RootViewController.h
//  xemHDFilm
//
//  Created by Trong Dinh on 7/15/14.
//  Copyright (c) 2014 com.mroom.xemHDFilm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface RootViewController : UIViewController <REFrostedViewControllerDelegate> {
    BOOL isLoaded;
}

@property (nonatomic, strong) NSMutableArray *arrRetains;

//STATIC
+ (RootViewController*) shared;
- (void)run;

@end
