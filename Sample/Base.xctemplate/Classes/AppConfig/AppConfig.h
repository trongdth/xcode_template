//
//  AppConfig.h
//  SmartDesk
//
//  Created by Trong_iOS on 3/27/15.
//  Copyright (c) 2015 Robotbase. All rights reserved.
//

@interface AppConfig : NSObject {

}

@property (nonatomic, strong) NSString *serviceUrl;

+ (AppConfig *)sharedInstance;
- (void)load;
- (void)save;

@end
