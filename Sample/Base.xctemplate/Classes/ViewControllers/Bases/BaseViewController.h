//
//  ViewControllerBase.h
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController {
    UIBarButtonItem *backBarBtnItem, *doneBarBtnItem;
    NSString *baseCacheName;
    UIImageView *imvShadow;
}

@property (nonatomic,strong)  NSMutableDictionary *   dictImgStore;

-(UIBarButtonItem*) createBarButtonItemWithImageNormalState:(UIImage*) imgNormalState
                                    withImageHighlightState:(UIImage*) imgHighlightState
                                               withWidthCap:(int) widthCap
                                           withTopCapHeight:(int) topCapHeight
                                            withButtonWidth:(NSNumber*) btnWidth
                                                  withTitle:(NSString*) aTitle
                                                   withFont:(UIFont*)font
                                                  withColor:(UIColor*)color
                                                 withTarget:(id) target
                                                forSelector:(SEL) aSelector;

-(UIButton*) createButtonWithImageNormalState:(UIImage*) imgNormalState
                      withImageHighlightState:(UIImage*) imgHighlightState
                                 withWidthCap:(int) widthCap
                             withTopCapHeight:(int) topCapHeight
                              withButtonWidth:(NSNumber*) btnWidth
                             withButtonHeight:(int) btnHeight
                                     withFont:(UIFont*) aFont
                                    withColor:(UIColor*) aColor
                                    withTitle:(NSString*) aTitle
                                   withTarget:(id) target
                                  forSelector:(SEL) aSelector;

-(UIBarButtonItem*) createBarButtonItemWithImageNormalState:(UIImage*) imgNormalState
                                    withImageHighlightState:(UIImage*) imgHighlightState
                                                   iconName:(NSString*) str
                                                  iconFrame:(CGRect)iconFrame
                                            withButtonWidth:(int) btnWidth
                                           withButtonHeight:(int) btnHeight
                                                 withTarget:(id) target
                                                  withTitle:(NSString *)aTitle
                                                forSelector:(SEL) aSelector;

-(void) saveCacheWithJSONString:(NSString*) jsonStr;
-(void) saveCacheWithJSON:(id)json;
-(NSString*) loadCacheString;
-(void)setTitleWithString:(NSString*) aTitle andFont:(UIFont*)aFont;
-(void)setTitleImageName:(NSString *)strImg;
-(CGSize) getSizeOfString:(NSString*) aString forFont:(UIFont*) aFont;

@end
