//
//  AppConfig.m
//  SmartDesk
//
//  Created by Trong_iOS on 3/27/15.
//  Copyright (c) 2015 Robotbase. All rights reserved.
//

#import "AppConfig.h"
#import "Validations.h"

@implementation AppConfig

+ (AppConfig *)sharedInstance
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

- (id) init
{
    if (self = [super init]) {
        [self loadDefaults];
    }
    return self;
}

- (void) loadDefaults
{
    _serviceUrl = @"";
}

- (void)load
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs synchronize];
}

- (void)save
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs synchronize];
}

@end

