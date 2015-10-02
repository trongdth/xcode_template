//
//  Defines.h
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//



#ifndef MroomSoftware_Defines_h
#define MroomSoftware_Defines_h

#ifdef DEBUG
#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

#define     kDatabaseName                           @"data.db"
#define     SCREEN_SIZE                             [UIScreen mainScreen].bounds.size
#define     IS_4INCHES                              [UIScreen mainScreen].bounds.size.height == 568.0
#define     DEFAULT_IPHONE_5_NIB_EXT                @"-iphone5"
#define     ApplicationDelegate                     (AppDelegate *) [UIApplication sharedApplication].delegate
#define     PATH_DOCUMENT_FOLDER                    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define     PATH_CACHE_FOLDER                       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define     IS_iPAD                                 UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define     RGB(r, g, b)                            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define     HEX(c)                                  [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define     kDEFAULT_ITEM                               10

typedef void(^MayaSuccess)(id object);
typedef void(^MayaError)(NSError *err);

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// Convenient RGB macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BlueColor                                   RGB(92, 192, 223)
#define GrayColor                                   RGB(191, 191, 183)

#define RUN_ON_MAIN_QUEUE(BLOCK_CODE)               dispatch_async(dispatch_get_main_queue(),BLOCK_CODE)
#define RUN_ON_BACKGROUND_QUEUE(BLOCK_CODE)         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),BLOCK_CODE)
#define IS_SIMULATOR                                ([[[UIDevice currentDevice].model lowercaseString] rangeOfString:@"simulator"].location != NSNotFound)

/******* FONT and COLORS *****/
#define     fREGULAR(font_size)                     [UIFont fontWithName:@"Avenir Next" size:[font_size doubleValue]]
#define     fBOLD(font_size)                        [UIFont fontWithName:@"AvenirNext-Regular" size:[font_size doubleValue]]
#define     fITALIC(font_size)                      [UIFont fontWithName:@"AvenirNext-Italic" size:[font_size doubleValue]]


/****** NOTIFICATION *******/


/***** ENUM ******/
typedef enum : NSUInteger {
    kMillimeter,
    kFeet,
    kInches
} UnitType;

#endif
