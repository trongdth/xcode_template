//
//  ViewControllerBase.m
//  instant
//
//  Created by Trong Dinh on 11/5/13.
//  Copyright (c) 2013 goodsplatform.com. All rights reserved.
//

#import "BaseViewController.h"

// define here
#define BASE_IMG_BTN_BACK_NORMAL        @"menu"
#define BASE_IMG_BTN_BACK_ACTIVE        @""
#define BASE_IMG_BTN_DONE_NOMRAL        @""
#define BASE_IMG_BTN_DONE_ACTIVE        @""
#define BASE_IMG_NAV_BAR                @"nav_bar"
#define BASE_IMG_NAV_BAR_IPAD           @"nav_bar"
#define kSHADOW_KEY_TAG                 1234

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize dictImgStore;

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString    *nibName = nibNameOrNil;
    if (IS_4INCHES == YES) {
        // is nib file exists ?
        NSFileManager   *fileMan = [NSFileManager defaultManager];
        NSString    *testNib = [NSString stringWithFormat:@"%@/%@%@.nib",[[NSBundle mainBundle] bundlePath],nibName,DEFAULT_IPHONE_5_NIB_EXT];
        if ([fileMan fileExistsAtPath:testNib]) {
            nibName = [nibName stringByAppendingString:DEFAULT_IPHONE_5_NIB_EXT];
        };
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initObjs];
    }
    return self;
}

- (void) awakeFromNib
{
    [self initObjs];    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    [dictImgStore removeAllObjects];
}

#pragma mark - View lifecycle

- (void)navigationController:(UINavigationController *)navigationController 
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController 
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initObjs];
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:BASE_IMG_NAV_BAR_IPAD] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forBarMetrics: UIBarMetricsDefault];
        } else {
            [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:BASE_IMG_NAV_BAR] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forBarMetrics: UIBarMetricsDefault];
        }
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        if(![self.navigationController.navigationBar viewWithTag:kSHADOW_KEY_TAG]) {
            imvShadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, 320, 6)];
            imvShadow.image = [[UIImage imageNamed:@"shadow-topmenu.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
            imvShadow.tag = kSHADOW_KEY_TAG;
            [self.navigationController.navigationBar addSubview:imvShadow];        
        }
    }

    backBarBtnItem = [self createBarButtonItemWithImageNormalState:[UIImage imageNamed:BASE_IMG_BTN_BACK_NORMAL]
                                           withImageHighlightState:[UIImage imageNamed:BASE_IMG_BTN_BACK_ACTIVE]
                                                      withWidthCap:5
                                                  withTopCapHeight:0
                                                   withButtonWidth:(IS_iPAD)?[NSNumber numberWithInt:11]:[NSNumber numberWithInt:35]
                                                         withTitle:@"    "
                                                          withFont:[UIFont boldSystemFontOfSize:13]
                                                         withColor:[UIColor darkGrayColor]
                                                        withTarget:self
                                                       forSelector:@selector(doGoBack)];

    doneBarBtnItem = [self createBarButtonItemWithImageNormalState:[UIImage imageNamed:BASE_IMG_BTN_DONE_NOMRAL]
                                           withImageHighlightState:[UIImage imageNamed:BASE_IMG_BTN_DONE_ACTIVE]
                                                      withWidthCap:5
                                                  withTopCapHeight:0
                                                   withButtonWidth:[NSNumber numberWithInt:22]
                                                         withTitle:@"    "
                                                          withFont:fREGULAR(@"15.0")
                                                         withColor:[UIColor darkGrayColor]
                                                        withTarget:self
                                                       forSelector:@selector(doDone)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self.dictImgStore removeAllObjects];
    self.dictImgStore = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

-(void) preDrawNavigationBar {

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - selector methods

- (void)doGoBack {
    
}

- (void)doDone {
    
}

- (void)scrollToTop {
    
}

- (void)btnTopTouched:(id)sender {
    if ([self respondsToSelector:@selector(scrollToTop)]) {
        [self performSelectorOnMainThread:@selector(scrollToTop) withObject:nil waitUntilDone:NO];
    }
}


#define BUTTON_GAP 20

-(UIBarButtonItem*) createBarButtonItemWithImageNormalState:(UIImage*) imgNormalState
                                    withImageHighlightState:(UIImage*) imgHighlightState
                                               withWidthCap:(int) widthCap
                                           withTopCapHeight:(int) topCapHeight
                                            withButtonWidth:(NSNumber*) btnWidth
                                                  withTitle:(NSString*) aTitle
                                                   withFont:(UIFont*)font
                                                  withColor:(UIColor*)color
                                                 withTarget:(id) target
                                                forSelector:(SEL) aSelector {
    // prepare some UI component
    UIButton    *btn = [self createButtonWithImageNormalState:imgNormalState
                                      withImageHighlightState:imgHighlightState
                                                 withWidthCap:widthCap
                                             withTopCapHeight:topCapHeight
                                              withButtonWidth:btnWidth
                                             withButtonHeight:imgNormalState.size.height
                                                     withFont:font
                                                    withColor:color
                                                    withTitle:aTitle
                                                   withTarget: target
                                                  forSelector:aSelector];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    barBtnItem.title = aTitle;
    return barBtnItem;
}

-(UIBarButtonItem*) createBarButtonItemWithImageNormalState:(UIImage*) imgNormalState
                                    withImageHighlightState:(UIImage*) imgHighlightState
                                                   iconName:(NSString*) str
                                                  iconFrame:(CGRect)iconFrame
                                            withButtonWidth:(int) btnWidth
                                           withButtonHeight:(int) btnHeight
                                                 withTarget:(id) target
                                                  withTitle:(NSString *)aTitle
                                                forSelector:(SEL) aSelector {
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(aTitle.length == 0) {
        btn.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    } else {
        btn.frame = CGRectMake(0, 0, [self getSizeOfString:aTitle forFont:fREGULAR(@"15.0")].width + 10, btnHeight);
    }

    if(imgNormalState) {
        [btn setBackgroundImage:[imgNormalState stretchableImageWithLeftCapWidth:8 topCapHeight:0] forState:UIControlStateNormal];
    }
    
    if(imgHighlightState) {
        [btn setBackgroundImage:[imgHighlightState stretchableImageWithLeftCapWidth:8 topCapHeight:0] forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
    if(aTitle.length > 0) {
        UILabel  *lbTitle = [[UILabel alloc] initWithFrame:btn.frame];
        lbTitle.font = fREGULAR(@"15.0");
        lbTitle.backgroundColor = [UIColor clearColor];
        lbTitle.textColor = BlueColor;
        lbTitle.shadowColor = [UIColor whiteColor];
        lbTitle.shadowOffset = CGSizeMake(0, 0.5);
        lbTitle.text = aTitle;
        lbTitle.textAlignment = NSTextAlignmentRight;
        [lbTitle sizeToFit];
        lbTitle.frame = CGRectMake(7, (btn.frame.size.height - lbTitle.frame.size.height)/2 -1, lbTitle.frame.size.width, lbTitle.frame.size.height);
        [btn addSubview:lbTitle];
        
    } else {
        UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:str]];
        imv.frame = iconFrame;
        imv.center = CGPointMake(btnWidth/2, btnHeight/2);
        [btn addSubview:imv];
        
    }
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtnItem;
}

-(UIBarButtonItem*) createStandardButtonWithTitle:(NSString*) aTitle withTarget:(id) target forSelector:(SEL) aSelector {
    return [self createBarButtonItemWithImageNormalState:[UIImage imageNamed:BASE_IMG_BTN_DONE_NOMRAL]
                                 withImageHighlightState:[UIImage imageNamed:BASE_IMG_BTN_DONE_ACTIVE]
                                            withWidthCap:17
                                        withTopCapHeight:0
                                         withButtonWidth:nil
                                               withTitle:aTitle
                                                withFont:[UIFont boldSystemFontOfSize:13]
                                               withColor:[UIColor darkGrayColor]
                                              withTarget:target
                                             forSelector:aSelector];
}

-(UIButton*) createButtonWithImageNormalState:(UIImage*) imgNormalState
                      withImageHighlightState:(UIImage*) imgHighlightState
                                 withWidthCap:(int) widthCap withTopCapHeight:(int) topCapHeight
                              withButtonWidth:(NSNumber*) btnWidth
                             withButtonHeight:(int) btnHeight
                                     withFont:(UIFont*) aFont
                                    withColor:(UIColor*) aColor
                                    withTitle:(NSString*) aTitle
                                   withTarget:(id) target
                                  forSelector:(SEL) aSelector {
    UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    int buttonWith;
    if (btnWidth!= nil) {
        buttonWith = [btnWidth intValue];
    }
    else
        buttonWith = [self getSizeOfString:aTitle forFont:aFont].width + BUTTON_GAP;
    btn.frame = CGRectMake(0, 0, buttonWith, btnHeight);
    [btn setBackgroundImage:[imgNormalState stretchableImageWithLeftCapWidth:widthCap topCapHeight:topCapHeight] forState:UIControlStateNormal];
    [btn setBackgroundImage:[imgHighlightState stretchableImageWithLeftCapWidth:widthCap topCapHeight:topCapHeight] forState:UIControlStateHighlighted];
    [btn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lbTitle     = [[UILabel alloc] initWithFrame:btn.frame];
    lbTitle.font = (aFont)?aFont:[UIFont systemFontOfSize:12];
    lbTitle.text = aTitle;
    lbTitle.textColor = aColor;
    lbTitle.shadowColor = [UIColor clearColor];
    lbTitle.shadowOffset = CGSizeMake(0, 1);
    [lbTitle sizeToFit];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.frame = CGRectMake(11, (btn.frame.size.height - lbTitle.frame.size.height)/2 -1, lbTitle.frame.size.width, lbTitle.frame.size.height);
    [btn addSubview:lbTitle];
    
    return btn;
}

#pragma mark - Objects

- (void)initObjs {
    if(!dictImgStore) {
        dictImgStore = [[NSMutableDictionary alloc] init];
    }
}

#pragma mark - Utilities

-(CGSize) getSizeOfString:(NSString*) aString forFont:(UIFont*) aFont {
    CGSize maximumSize = CGSizeMake(275, 9999);
    return [aString sizeWithFont:aFont
               constrainedToSize:maximumSize
                   lineBreakMode:NSLineBreakByTruncatingTail];
}

#pragma mark - UI

- (void)setTitleWithString:(NSString*) aTitle andFont:(UIFont*)aFont {
    UILabel *lbTitle  = (UILabel*)self.navigationItem.titleView;
    
    if (lbTitle.tag != 1899)
    {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTopTouched:)];
        lbTitle     = [[UILabel alloc] initWithFrame:CGRectMake(0,0,800,48)];
        lbTitle.font = (aFont)?aFont:[UIFont systemFontOfSize:12];
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.text = aTitle;
        lbTitle.textColor = [UIColor whiteColor];
        lbTitle.shadowColor = [UIColor clearColor];
        lbTitle.shadowOffset = CGSizeMake(0, 0.5);
        lbTitle.backgroundColor = [UIColor clearColor];
        [lbTitle addGestureRecognizer:tapGestureRecognizer];
        lbTitle.userInteractionEnabled = YES;
        lbTitle.tag = 1899;
        self.navigationItem.titleView = lbTitle;
    }
    
    lbTitle.text = aTitle;
    lbTitle.font = (aFont)?aFont:[UIFont systemFontOfSize:12];
}

- (void)setTitleImageName:(NSString *)strImg {
    UIImageView *imvTitle  = (UIImageView*)self.navigationItem.titleView;
    
    if (imvTitle.tag != 1899)
    {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTopTouched:)];
        imvTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strImg]];
        [imvTitle addGestureRecognizer:tapGestureRecognizer];
        imvTitle.userInteractionEnabled = YES;
        self.navigationItem.titleView = imvTitle;
    }
}

#pragma mark - cache

-(void) saveCacheWithJSONString:(NSString*) jsonStr {
    if (!baseCacheName) {
        DLog(@"HEY, baseCacheName is nil . DID YOU FORGET TO SET IT?");
        return;
    }
    NSString    *path = [PATH_DOCUMENT_FOLDER stringByAppendingFormat:@"/%@.json",baseCacheName];
    [jsonStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //NSString    *jsonContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

-(void) saveCacheWithJSON:(id)json {
    if (!baseCacheName) {
        DLog(@"HEY, baseCacheName is nil . DID YOU FORGET TO SET IT?");
        return;
    }
    if([json isKindOfClass:[NSDictionary class]]) {
        NSData *dataToSave =  [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        NSString    *path = [PATH_DOCUMENT_FOLDER stringByAppendingFormat:@"/%@.json",baseCacheName];
        [dataToSave writeToFile:path atomically:YES];
        
    }
}

-(NSString*) loadCacheString {
    if (!baseCacheName) {
        DLog(@"HEY, baseCacheName is nil . DID YOU FORGET TO SET IT?");
        return nil;
    }

    NSString    *path = [PATH_DOCUMENT_FOLDER stringByAppendingFormat:@"/%@.json",baseCacheName];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

@end