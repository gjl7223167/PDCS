//
//  ZJLPageControl.h
//  GSSBusiness
//
//  Created by OO on 15/8/7.
//  Copyright (c) 2015年 OOMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ZJLCtrlItem.h"

//特效需要的最小数量
#define KSpecailMinItems 5
//最大支持可视item数量
#define KMaxSupportItems 30

@protocol ZJLPageControlDelegate <NSObject>
-(void) pageIndexChanged:(NSInteger) pageIndex;
@optional
-(void) titlePosChanged:(CGFloat) postion;
-(void) pageIndexChanged:(NSInteger)pageIndex fromPageIndex:(NSInteger)oldIndex;
@end

@interface ZJLPageControl : UIView{
    NSMutableArray*         itemArray;
    NSInteger               currentPage;
    NSInteger               itemsVisableNum;
    CALayer*                flagLayer;
    CGFloat                 itemWidth;
    CGPoint                 lastPos;
    BOOL                    isDragged;
}

@property(nonatomic, assign)id<ZJLPageControlDelegate> pageDelegate;
@property(nonatomic, strong)UIScrollView*               scrollView;
@property(nonatomic, strong)NSMutableArray*             widthArray;
@property(nonatomic, assign)BOOL                        isAutoLength;


- (ZJLCtrlItem*) viewForpage:(NSInteger) page;
- (NSString*) titleForpage:(NSInteger) page;
- (UILabel*) currentItemView;
- (id)initWithFrame:(CGRect)frame titles:(NSArray*) textArray defaultP:(NSInteger)index;
- (id)initWithFrame:(CGRect)frame titles:(NSArray*) textArray defaultP:(NSInteger)index isWidthChange:(BOOL)isChange;
- (id)initWithFrame:(CGRect)frame titles:(NSArray*) textArray defaultP:(NSInteger)index needshowImgIndexArray:(NSArray*)indexArray andImgArray:(NSArray*)imgArray;
- (void) setPageToIndex:(NSInteger ) index animate:(BOOL) animation;
- (void)itemChangeImgWith:(NSString*)imgStr forItemIndex:(NSInteger)index;
- (NSInteger) currentPageIndex;
@end
