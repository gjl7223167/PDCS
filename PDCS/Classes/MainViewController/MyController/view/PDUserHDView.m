//
//  PDUserHDView.m
//  PDCS
//
//  Created by iMac on 2017/9/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDUserHDView.h"
#define rBImgWidth   50.0f
#define uHdImgWidth  v(40)
#define uRedDotWt    5.0f
@interface PDUserHDView()
@property (nonatomic, strong)UILabel*           nickName;
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
    
    UIButton* rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rBtn.frame = CGRectMake(vSize.width - KDfltGap/2.0 - rBImgWidth, KDfltGap, rBImgWidth, rBImgWidth);
    UIImage* img = [UIImage imageNamed:@"user_rtBtnImg.png"];
    [rBtn setImage:img forState:UIControlStateNormal];
    rBtn.tag = 1050;
    [rBtn addTarget:self action:@selector(btnClickedWith:) forControlEvents:UIControlEventTouchUpInside];
    
    _hdCtrl = [[HBSingleImgCtrl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - uHdImgWidth) / 2.0, 30, uHdImgWidth, uHdImgWidth)];
    _hdCtrl.centerY         = vSize.height / 2.0 - KDfltGap;
    _hdCtrl.layer.cornerRadius = uHdImgWidth / 2.0;
    _hdCtrl.layer.masksToBounds= YES;
    //_hdCtrl.layer.borderWidth = 4.0;
    //_hdCtrl.layer.borderColor = [HBUtils colorWithInt:0xffffff alpha:0.5].CGColor;
    [self addSubview:_hdCtrl];
    _hdCtrl.tag = 1060;

    [_hdCtrl addTarget:self action:@selector(btnClickedWith:) forControlEvents:UIControlEventTouchUpInside];
    _nickName = [PDUtils createNormalLabel:@"编辑头像" with:[UIColor grayColor] frame:CGRectMake(KEdgeGap, _hdCtrl.bottom + v(12.0), SCREEN_WIDTH - KEdgeGap * 2, 20) Fontwith:15];
    
    _nickName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nickName];
    
}

- (void)upLoadViewInfo
{
    UserModel * userModel = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSString * baseStr = userModel.HEAD_IMG_INFO;
    if (baseStr){
        NSData *decodedImageData = [[NSData alloc]
                                    
                                    initWithBase64EncodedString:baseStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        [_hdCtrl imageData:decodedImageData];
    }else{
        [_hdCtrl imageData:nil];
    }
//    HBGlobalModel* gModel = [HBGlobalModel sharedHBGlobalModel];
//    if (gModel.isLogin) {
//        _nickName.text  = gModel.userInfo.nickName;
//        [_hdCtrl updateViewWith:@"user_PImg.jpg" imgPath:nil orImgUrl:nil];
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


- (void)btnClickedWith:(UIControl*)ctrl
{
    if (_btnClickBlock) {
        _btnClickBlock(ctrl.tag - 1000);
    }
}

@end
