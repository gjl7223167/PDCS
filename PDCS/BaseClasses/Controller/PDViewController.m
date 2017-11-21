//
//  PDViewController.m
//  PDCS
//
//  Created by iMac on 2017/9/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDViewController.h"

#define NaviBarDepX  15.0f
#define NaviBarDepY  7.0f

@interface PDViewController ()
@property (nonatomic, strong)UIButton* leftBtn;
@property (nonatomic, strong)UIButton* rightBtn;
@end

@implementation PDViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    if (ISIOS7AndAbove) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    
    [self initNaviBarView];
    self.navigationController.toolbar.hidden = YES;
    
//    CGSize size = self.view.frame.size;
//    CGRect cFrame = CGRectMake(0, 0, SCREEN_WIDTH, size.height);
//    if ([PDUtils getIOSVersion] < 7.0) {
//        cFrame.origin.y = 0;
//    }
//
//    self.contentView = [[UIView alloc]initWithFrame:cFrame];
//    [self.contentView setBackgroundColor:kViewBgColor];
//    [self.view addSubview:self.contentView];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.view);
//    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.toolbarHidden = YES;
    if (self.navigationController.navigationBar.hidden == YES) {
        [self.navigationController setNavigationBarHidden:NO];
        self.navigationController.navigationBar.hidden = NO;
    }

    _rightBtn.hidden = YES;
    
}


- (void)initNaviBarView
{
    UIImage* lBtnImg = [UIImage imageNamed:@"sysBack.png"];
    CGSize lbSize = lBtnImg.size;
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setFrame:CGRectMake(0, 0, lbSize.width, lbSize.height)];
    [_leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:lBtnImg forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    
    CGSize rbSize = CGSizeMake(80, 35);
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(0, 0, rbSize.width, rbSize.height)];
    [_rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font = [PDUtils appFontWithSize:14];
    [_rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:KCurrColor forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
}

- (void)leftBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"leftBtnClicked");
}

- (void)rightBtnClicked:(id)sender
{
    //[];
    NSLog(@"rightBtnClicked");
    //    OOSearchViewController* vc = [[OOSearchViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showRightBtn
{
    _rightBtn.hidden = NO;
}

- (void)hiddenRightBtn
{
    _rightBtn.hidden = YES;
}

- (void)rightBtnImgWith:(NSString*)imgName
{
    UIImage* img = [UIImage imageNamed:imgName];
    [_rightBtn setTitle:@"" forState:UIControlStateNormal];
    CGSize iSize = img.size;
    [_rightBtn setImage:img forState:UIControlStateNormal];
    _rightBtn.width     = iSize.width + 5;
    _rightBtn.height    = 35.0f;
}


-(void)subVCContentViewHeight{

}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
}

- (void)rightBtnTitleWith:(NSString*)tStr
{
    CGFloat tWidth = [PDUtils textLengthWith:tStr withFontSize:14];
    _rightBtn.size = CGSizeMake(tWidth + 5, 35);
    [_rightBtn setTitle:tStr forState:UIControlStateNormal];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)addSigleImg
{
    
}

@end
