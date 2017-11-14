//
//  PDCSSegmentedView.h
//  PDCS
//
//  Created by iMac on 2017/10/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDCSSegmentedViewDelegate;

@interface PDCSSegmentedView : UIView

#pragma mark - 属性
//标题数组
@property (nonatomic, copy) NSArray *titles;
//未选中文字、边框、滑块颜色
@property (nonatomic, strong) UIColor *textColor;
//背景、选中文字颜色，当设置为透明时，选中文字为白色
@property (nonatomic, strong) UIColor *viewColor;
//选中的标题
@property (nonatomic) NSInteger selectNumber;

#pragma mark - 方法
/*
 初始化方法
 设置标题
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/*
 设置标题
 */
- (void)setTitles:(NSArray *)titles;

/*
 设置选中的标题
 超出范围，则为最后一个标题
 
 或者使用隐藏的
 - (void)setSelectNumber:(NSInteger)selectNumber
 方法，默认无动画效果。
 */
- (void)setSelectNumber:(NSInteger)selectNumber animate:(BOOL)animate;

#pragma mark - 代理

@property (nonatomic, weak) id <PDCSSegmentedViewDelegate> delegate;

@end


@protocol PDCSSegmentedViewDelegate <NSObject>

@optional

/*
 当滑动XSSegmentedView滑块时，或者XSSegmentedView被点击时，会调用此方法。
 */
- (void)xsSegmentedView:(PDCSSegmentedView *)XSSegmentedView selectTitleInteger:(NSInteger)integer;

/*
 是否允许被选中
 返回YES可以被选中
 返回NO不可以被选中
 */
- (BOOL)xsSegmentedView:(PDCSSegmentedView *)XSSegmentedView didSelectTitleInteger:(NSInteger)integer;

@end
