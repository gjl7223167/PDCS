//
//  ZJLCtrlItem.h
//  GSSBusiness
//
//  Created by OO on 15/8/7.
//  Copyright (c) 2015年 OOMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJLCtrlItem : UIControl
{
    UILabel*    tLab;
    UIView*     rLine;
    UIView*     lView;
    UIImageView* imgView;
}

@property (strong, nonatomic)NSString* titleStr;
@property (strong, nonatomic)NSString* imgName;

@property (assign, nonatomic)BOOL      isFirst;
@property (assign, nonatomic)BOOL      isLast;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)tString withIsFirst:(BOOL)isFirst withIsLast:(BOOL)isLast;
- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)tString withImgName:(NSString*)imgName withIsFirst:(BOOL)isFirst withIsLast:(BOOL)isLast;

- (void)setCurrentView;
- (void)setDefaultView;

- (void)changImgViewWith:(NSString*)imgStr;
- (void)changeTitleWith:(NSString*)title;

@end
