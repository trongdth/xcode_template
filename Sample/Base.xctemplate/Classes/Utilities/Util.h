//
//  Util.h
//  karaoke
//
//  Created by Trong Dinh on 2/25/13.
//  Copyright (c) 2013 Mroom Software. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

@interface Util : NSObject

+ (void) saveCacheWithJSON:(id)json name:(NSString*)_name;
+ (NSString*) loadCacheString:(NSString *)_name;
+ (void) showLoading:(UIView*)vw;
+ (void) showLoading:(UIView*)vw withMsg:(NSString*)msg;
+ (void) hideLoading:(UIView*)vw;
+ (void) showInfoMsg:(NSString*)msg inView:(UIView*)vw;
+ (void) showVersionMsg:(NSString*)msg inView:(UIView*)vw;
+ (NSString*) sha1:(NSString*)input;
+ (BOOL) validateEmail: (NSString *) email;
+ (BOOL) validateUsername: (NSString *) username;
+ (void)showAlertViewMessage:(NSString *)info title:(NSString *)title delegate:(id)del;
+ (NSString *)convertValue:(int)value fromUnit:(UnitType)fUnit toUnit:(UnitType)tUnit;

@end

//==================================================
//  TIMER BLOCK
//==================================================
@interface TimerBlock : NSObject {
    void(^onExec)(NSTimer*);
}

//----------------------------------------
//  MAIN
//----------------------------------------
- (id) initWithBlock:(void(^)(NSTimer*))_onExec;
- (void) execWithTimer:(NSTimer*)timer;
@end

//==================================================
//  NSTIMER - Override
//==================================================
@interface NSTimer (Override)

//----------------------------------------
//  STATIC
//----------------------------------------

//when call start session,all nstimer which be created will belong to session within name
//call endsession if you need to destroy all timers of particular session
+ (void) startSession:(NSString*)name;
+ (void) continueSession:(NSString*)name;
+ (void) endSession:(NSString*)name;
+ (int) countOfRunningTimers;

+ (id) timerWithTimeout:(float)seconds andBlock:(void(^)(NSTimer*))onTimeout;
+ (id) timerWithInterval:(float)seconds andBlock:(void(^)(NSTimer*))onInterval;

@end