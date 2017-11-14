//
//  HBSingleImgCtrl.m
//  besttravel
//
//  Created by iOS on 16/1/4.
//  Copyright © 2016年 第一出行. All rights reserved.
//

#import "HBSingleImgCtrl.h"

@interface HBSingleImgCtrl()

@property (nonatomic, strong)UIImageView*   imageView;

@end

@implementation HBSingleImgCtrl

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
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, vSize.width, vSize.height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    _imageView.height = height;
}

- (void)updateViewWith:(NSString*)pName imgPath:(NSString*)imgPath orImgUrl:(NSString*)imgUrl
{
    if (imgUrl && imgUrl.length > 0) {
        UIImage* pImg = [UIImage imageNamed:pName];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:pImg];
    }else if (imgPath && imgPath.length > 0) {
        _imageView.image = [UIImage imageWithContentsOfFile:imgPath];
    }else{
        UIImage* pImg = [UIImage imageNamed:pName];
        _imageView.image = pImg;
    }
}

@end
