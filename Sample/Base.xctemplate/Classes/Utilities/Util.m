//
//  Util.m
//  karaoke
//
//  Created by Trong Dinh on 2/25/13.
//  Copyright (c) 2013 Mroom Software. All rights reserved.
//

#import "Util.h"
#import "MBProgressHUD.h"
#import "Validations.h"

@implementation Util

+(void) saveCacheWithJSON:(id)json name:(NSString*)_name {
    if([json isKindOfClass:[NSDictionary class]]) {
        NSError *error;
        NSData *dataToSave =  [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error ];
        NSString    *path = [PATH_DOCUMENT_FOLDER stringByAppendingFormat:@"/%@.json",_name];
        [dataToSave writeToFile:path atomically:NO];
        
    }
}

+(NSString*) loadCacheString:(NSString *)_name {
    NSString    *path = [PATH_DOCUMENT_FOLDER stringByAppendingFormat:@"/%@.json",_name];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

+ (void) showLoading:(UIView*)vw
{
    [MBProgressHUD hideHUDForView:vw animated:NO];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:vw animated:YES];
    hud.labelText = @"";
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // lock
    vw.userInteractionEnabled = NO;
}

+ (void) showLoading:(UIView*)vw withMsg:(NSString*)msg
{
    [MBProgressHUD hideHUDForView:vw animated:NO];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:vw animated:YES];
//    hud.labelText = msg;
    hud.detailsLabelText = msg;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    // lock
    vw.userInteractionEnabled = NO;
}

+ (void) hideLoading:(UIView*)vw
{
    [MBProgressHUD hideHUDForView:vw animated:YES];
    // unlock
    vw.userInteractionEnabled = YES;
}

+ (void) showInfoMsg:(NSString*)msg inView:(UIView*)vw
{
    [MBProgressHUD hideAllHUDsForView:vw animated:YES];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:vw
                                              animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"";
    hud.detailsLabelText = msg;
    
    __weak UIView *__vw = vw;
    [NSTimer timerWithTimeout:2.0 andBlock:^(NSTimer* tmr){
        if (!__vw) return;
        [MBProgressHUD hideHUDForView:__vw animated:YES];
    }];
}

+ (void) showVersionMsg:(NSString*)msg inView:(UIView*)vw
{
    [MBProgressHUD hideAllHUDsForView:vw animated:YES];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:vw
                                              animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"";
    hud.detailsLabelText = msg;
}

+ (NSString*) sha1:(NSString*)input
{
//    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

+(BOOL) validateEmail: (NSString *) email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}

+(BOOL) validateUsername: (NSString *) username
{
    NSString *usernameRegex = @"[A-Z0-9a-z._%+]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
    BOOL isValid = [emailTest evaluateWithObject:username];
    return isValid;
}

+ (void)showAlertViewMessage:(NSString *)info title:(NSString *)title delegate:(id)del {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:info delegate:del cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+ (NSString *)convertValue:(int)value fromUnit:(UnitType)fUnit toUnit:(UnitType)tUnit {
    switch (tUnit) {
        case kMillimeter:
            switch (fUnit) {
                case kMillimeter:
                    return [NSString stringWithFormat:@"%d", value];
                    break;
                    
                case kFeet:
                    return [NSString stringWithFormat:@"%f", value*304.8];
                    break;
                    
                case kInches:
                    return [NSString stringWithFormat:@"%.1f", value*25.4];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case kFeet: {
            switch (fUnit) {
                case kMillimeter:
                    return [NSString stringWithFormat:@"%.1f", value*0.00328084];
                    break;
                    
                case kFeet:
                    return [NSString stringWithFormat:@"%d", value];
                    break;

                case kInches:
                    return [NSString stringWithFormat:@"%.1f", value*0.0833333];
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
            
        case kInches: {
            switch (fUnit) {
                case kMillimeter:
                    return [NSString stringWithFormat:@"%.1f", value*0.0393701];
                    
                    break;
                    
                case kFeet:
                    return [NSString stringWithFormat:@"%d", value*12];
                    
                    break;
                    
                case kInches:
                    return [NSString stringWithFormat:@"%d", value];
                    
                    break;
                    
                default:
                    break;
            }
        }
            
        default:
            break;
    }
    
    return @"";
}


@end

//==================================================
//  TIMER BLOCK
//==================================================
@implementation TimerBlock

#pragma mark MAIN
//----------------------------------------
//  MAIN
//----------------------------------------
-(id) initWithBlock:(void(^)(NSTimer*))_onExec
{
    self=[super init];
    onExec=[_onExec copy];
    
    return self;
}

-(void) execWithTimer:(NSTimer*)timer
{
    if (onExec!=nil) onExec(timer);
}

-(void) dealloc
{
    onExec = nil;
}
@end

//==================================================
//  NSTIMER - Override
//==================================================
@implementation NSTimer(Override)

#pragma mark STATIC
//----------------------------------------
//  STATIC
//----------------------------------------
static NSMutableDictionary* sessions_=nil;
static NSString* currentSessionName_=nil;

+(void) startSession:(NSString*)name
{
    if (sessions_==nil) sessions_=[[NSMutableDictionary alloc] init];
    
    if ([sessions_ objectForKey:name]==nil)
        [sessions_ setObject:[NSMutableArray array] forKey:name];
    
    currentSessionName_=name;
    DLog(@"[NSTimer] start session %@",name);
}

+(void) continueSession:(NSString*)name
{
    currentSessionName_=name;
    DLog(@"[NSTimer] continue session %@",name);
}

+(void) endSession:(NSString*)name
{
    NSMutableArray* arr=[sessions_ objectForKey:name];
    if (arr!=nil)
    {
        for (NSTimer* tm in arr) [tm invalidate];
        [arr removeAllObjects];
    }
    DLog(@"[NSTimer] end sessionc %@",name);
}

+ (int) countOfRunningTimers
{
    NSArray* arr=[sessions_ objectForKey:currentSessionName_];
    if (arr!=nil) return arr.count;
    return 0;
}

+(id) timerWithTimeout:(float)seconds andBlock:(void(^)(NSTimer*))onTimeout
{
    TimerBlock *tmrBlock=[[TimerBlock alloc] initWithBlock:onTimeout];
    NSTimer* tm=[NSTimer scheduledTimerWithTimeInterval:seconds target:tmrBlock selector:@selector(execWithTimer:) userInfo:[NSNumber numberWithInt:1] repeats:NO];
    
    if (currentSessionName_!=nil)
    {
        NSMutableArray* arr=[sessions_ objectForKey:currentSessionName_];
        [arr addObject:tm];
    }
    
    return tm;
}

+(id) timerWithInterval:(float)seconds andBlock:(void(^)(NSTimer*))onInterval
{
    TimerBlock *tmrBlock=[[TimerBlock alloc] initWithBlock:onInterval];
    
    NSTimer *tm= [NSTimer scheduledTimerWithTimeInterval:seconds target:tmrBlock selector:@selector(execWithTimer:) userInfo:nil repeats:YES];
    
    if (currentSessionName_!=nil)
    {
        NSMutableArray* arr=[sessions_ objectForKey:currentSessionName_];
        [arr addObject:tm];
    }
    
    return tm;
}

@end
