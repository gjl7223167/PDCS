//
//  ZJLCtrlItem.m
//  GSSBusiness
//
//  Created by OO on 15/8/7.
//  Copyright (c) 2015年 OOMall. All rights reserved.
//

#import "ZJLCtrlItem.h"

#define KGapWidth  0
#define kPCtrlSColor    UIColorFromRGB(0xff7200)     //pageControl选中颜色
#define     KDfltBdWidth    0.6f
#define     KDfltLColor     UIColorFromRGB(0xf1f1f1)
#define kPCtrlDColor    UIColorFromRGB(0x666666)     //pageControl默认颜色


@implementation ZJLCtrlItem
- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)tString withIsFirst:(BOOL)isFirst withIsLast:(BOOL)isLast
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleStr = tString;
        self.isFirst = isFirst;
        self.isLast = isLast;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initItemViewWithFrame:frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)tString withImgName:(NSString*)imgName withIsFirst:(BOOL)isFirst withIsLast:(BOOL)isLast
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleStr = tString;
        self.isFirst = isFirst;
        self.isLast = isLast;
        self.imgName = imgName;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initItemViewWithFrame:frame];
    }
    return self;
}

- (void)initItemViewWithFrame:(CGRect)rect
{
    CGRect labFrame = CGRectMake(0, 6, rect.size.width, rect.size.height - 12);
    tLab = [[UILabel alloc]init];
    [tLab setFrame:labFrame];
    tLab.bottom = self.height - 5;
    [tLab setBackgroundColor:[UIColor clearColor]];
    tLab.font = [PDUtils appFontWithSize:15];
    [tLab setText:self.titleStr];
    [tLab setTextColor:kPCtrlDColor];
    [tLab setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:tLab];
    
    if (_imgName) {
        UIImage* image = [UIImage imageNamed:_imgName];
        CGFloat width = [PDUtils textLengthWith:_titleStr withFontSize:14];
        CGSize imgSize = image.size;
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake((rect.size.width - width) / 2.0 + width + 5, (rect.size.height - imgSize.height) / 2.0, imgSize.width, imgSize.height)];
        [imgView setImage:image];
        [self addSubview:imgView];
    }
    
    if (!_isLast) {
        rLine = [[UIView alloc]initWithFrame:CGRectMake(self.width - KDfltBdWidth, 8, KDfltBdWidth, self.height - 16)];
        rLine.backgroundColor = KDfltLColor;
        [self addSubview:rLine];
    }
    
    CGRect lFrame = CGRectMake(KGapWidth, rect.size.height - 2, rect.size.width - KGapWidth* 2, 2);
    lView = [[UIView alloc]initWithFrame:lFrame];
    [lView setBackgroundColor:kPCtrlSColor];
    [self addSubview:lView];
    lView.hidden = YES;
}

- (void)changeTitleWith:(NSString*)title
{
    self.titleStr = title;
    tLab.text = title;
}

- (void)changImgViewWith:(NSString*)imgStr
{
    imgView.image = nil;
    imgView.image = [UIImage imageNamed:imgStr];
}

- (void)setCurrentView
{
    [tLab setTextColor:kPCtrlSColor];
    tLab.font = [PDUtils appFontWithSize:14];
    lView.hidden = NO;
}

- (void)setDefaultView
{
    [tLab setTextColor:kPCtrlDColor];
    tLab.font = [PDUtils appFontWithSize:14];
    lView.hidden = YES;
}
@end
