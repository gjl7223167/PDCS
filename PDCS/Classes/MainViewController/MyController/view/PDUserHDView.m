//
//  PDUserHDView.m
//  PDCS
//
//  Created by iMac on 2017/9/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDUserHDView.h"
#define rBImgWidth   50.0f
#define uHdImgWidth  v(66.0f)
#define uRedDotWt    5.0f
@interface PDUserHDView()
@property (nonatomic, strong)UIImageView*       imgView;
@property (nonatomic, strong)UILabel*           nickName;
@property (nonatomic, strong)UIImageView*       rzImgV;
@property (nonatomic, strong)UIView*            redDot;
@property (nonatomic, strong)HBSingleImgCtrl*   hdCtrl;
@end

@implementation PDUserHDView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGSize vSize = self.size;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, vSize.width, vSize.height)];
    [_imgView setImage:[UIImage imageNamed:@"user_topB.jpg"]];
    _imgView.userInteractionEnabled = YES;
    
    _imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imgView];
    
    UIButton* rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rBtn.frame = CGRectMake(vSize.width - KDfltGap/2.0 - rBImgWidth, KDfltGap, rBImgWidth, rBImgWidth);
    UIImage* img = [UIImage imageNamed:@"user_rtBtnImg.png"];
    [rBtn setImage:img forState:UIControlStateNormal];
    rBtn.tag = 1050;
    [rBtn addTarget:self action:@selector(btnClickedWith:) forControlEvents:UIControlEventTouchUpInside];
    
    _redDot = [[UIView alloc]initWithFrame:CGRectMake(rBtn.right - KDfltGap*2 + 3, rBtn.top + KDfltGap*1.5, uRedDotWt, uRedDotWt)];
    _redDot.backgroundColor = [UIColor redColor];
    _redDot.layer.masksToBounds = YES;
    _redDot.layer.cornerRadius  = uRedDotWt / 2.0;
    //    [self addSubview:_redDot];
    
    _hdCtrl = [[HBSingleImgCtrl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - uHdImgWidth) / 2.0, 30, uHdImgWidth, uHdImgWidth)];
    _hdCtrl.centerY         = vSize.height / 2.0 - KDfltGap;
    _hdCtrl.layer.cornerRadius = uHdImgWidth / 2.0;
    _hdCtrl.layer.masksToBounds= YES;
    //_hdCtrl.layer.borderWidth = 4.0;
    //_hdCtrl.layer.borderColor = [HBUtils colorWithInt:0xffffff alpha:0.5].CGColor;
    [self addSubview:_hdCtrl];
    _hdCtrl.tag = 1060;
    
    [_hdCtrl addTarget:self action:@selector(btnClickedWith:) forControlEvents:UIControlEventTouchUpInside];
    _nickName = [PDUtils createNormalLabel:@"我是昵称" with:[UIColor whiteColor] frame:CGRectMake(KEdgeGap, _hdCtrl.bottom + v(12.0), SCREEN_WIDTH - KEdgeGap * 2, 20) Fontwith:18];
    _nickName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nickName];
    
    UIImage* rzImg = [UIImage imageNamed:@"user_Krz.jpg"];
    CGSize rSize = rzImg.size;
    _rzImgV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - rSize.width) / 2.0, _nickName.bottom+ 8, rSize.width, rSize.height)];
    _rzImgV.image = rzImg;
    [self addSubview:_rzImgV];
}

- (void)upLoadViewInfo
{
//    HBGlobalModel* gModel = [HBGlobalModel sharedHBGlobalModel];
//    if (gModel.isLogin) {
//        _nickName.text  = gModel.userInfo.nickName;
        [_hdCtrl updateViewWith:@"user_PImg.jpg" imgPath:nil orImgUrl:nil];
//        if (gModel.userInfo.status == 1) {
//            _rzImgV.hidden  = NO;
//        }else{
//            _rzImgV.hidden = YES;
//        }
//    }else{
//        _rzImgV.hidden      = YES;
//        _nickName.text      = @"点击头像登录";
//        _redDot.hidden      = YES;
//        [_hdCtrl updateViewWith:@"user_PImg.jpg" imgPath:@"" orImgUrl:@""];
//    }
}

- (void)redDotShowWith:(BOOL)isShow
{
    _redDot.hidden      = !isShow;
}

- (void)btnClickedWith:(UIControl*)ctrl
{
    if (_btnClickBlock) {
        _btnClickBlock(ctrl.tag - 1000);
    }
}

@end
