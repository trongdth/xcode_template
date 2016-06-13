//
//  APIService.m
//  SmartDesk
//
//  Created by Trong_iOS on 4/16/15.
//  Copyright (c) 2015 Robotbase. All rights reserved.
//

#import "APIService.h"
#import "AFNetworking.h"
#import "Validations.h"

@implementation APIService

static APIService *_shared = nil;

+ (APIService*) shared {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _shared = [[APIService alloc] init];
    });
    
    // returns the same object each time
    return _shared;
}

- (id)init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (NSString*) getBaseUrl
{
    return [AppConfig sharedInstance].serviceUrl;
}

@end
