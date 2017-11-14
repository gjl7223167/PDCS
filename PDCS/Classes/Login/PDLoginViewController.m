//
//  PDLoginViewController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDLoginViewController.h"
#import "PDNavigationController.h"
#import "PDLoginController.h"


#import "AppDelegate.h"

@interface PDLoginViewController ()

@end

@implementation PDLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initImgView];
    [self performSelector:@selector(gotoMain) withObject:self afterDelay:2];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)initImgView
{
    CGSize vSize = self.contentView.size;
    CGRect iFrame = CGRectMake(0, 0, vSize.width, vSize.height);
    if ([PDUtils getIOSVersion] < 7.0) {
        iFrame.origin.y = -20;
        iFrame.size.height += 20;
    }
    
    NSString* imgName = @"750-1334.png";
    if (IS_IPHONE_4_OR_LESS) {
        imgName = @"640-960";
    }else if(IS_IPHONE_5){
        imgName = @"640-1136";
    }else if (IS_IPHONE_6P){
        imgName = @"1242-2208";
    }
    
    UIImage* image = [UIImage imageNamed:imgName];
    
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:iFrame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
    [self.contentView addSubview:imgView];
}

- (void)gotoMain{
    
    BOOL isFt = [kUserDefault boolForKey:KIsFirstUse];
    
    if (isFt) {
        MyTabbar* tabar = [MyTabbar sharedMyTabbar];
        [self curtainRevealViewController:tabar.tabbarController];
    }else{
        PDLoginController* vc = [[PDLoginController alloc]init];
        [self curtainRevealViewController:vc];
    }
}


- (void)curtainRevealViewController:(UIViewController *)viewControllerToReveal
{
    AppDelegate *appDelegate = [AppDelegate getAppDelegate];
    
    UIImage *selfPortrait = [self imageWithView:self.contentView];
    
    CGSize vSize = self.contentView.size;
    CGRect iFrame = CGRectMake(0, 0, vSize.width, vSize.height);
    UIImageView* myImgView = [[UIImageView alloc]initWithFrame:iFrame];
    myImgView.image = selfPortrait;
    
    if ([viewControllerToReveal isKindOfClass:[UITabBarController class]]) {
        appDelegate.window.rootViewController = viewControllerToReveal;
    }else{
        PDNavigationController* navi = [[PDNavigationController alloc]initWithRootViewController:viewControllerToReveal];
        appDelegate.window.rootViewController = navi;
    }
    [appDelegate.window addSubview:myImgView];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        myImgView.alpha = 0;
    } completion:^(BOOL finished){
        [myImgView removeFromSuperview];
    }];
}


#pragma mark - loading  start
- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
