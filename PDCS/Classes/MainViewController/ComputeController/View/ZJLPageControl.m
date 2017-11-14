//
//  ZJLPageControl.m
//  GSSBusiness
//
//  Created by OO on 15/8/7.
//  Copyright (c) 2015年 OOMall. All rights reserved.
//

#import "ZJLPageControl.h"

#define KSideMargine 0
#define     KDfltBdWidth    0.6f
#define     KDfltLColor     UIColorFromRGB(0xf1f1f1)

@implementation ZJLPageControl
@synthesize isAutoLength;
@synthesize widthArray;
@synthesize pageDelegate;


-(void) layoutContens{
    CGFloat offx = 0.0f;
    CGPoint point = _scrollView.contentOffset;
    if (isAutoLength) {
        CGSize cSize = _scrollView.contentSize;
        if (cSize.width <= self.width) {
            point.x = offx;
            _scrollView.contentOffset = point;
            for (int i = 0; i < [itemArray count]; i++) {
                ZJLCtrlItem* item = [itemArray objectAtIndex:i];
                if (currentPage == i) {
                    [item setCurrentView];
                }else{
                    [item setDefaultView];
                }
            }
            [self updateLayer:YES];
            return;
        }
        if (cSize.width > self.width) {
            if (currentPage + 1 != itemArray.count) {
                //offx = (currentPage + 1.5) * itemWidth - self.width;
                ZJLCtrlItem* item = [itemArray objectAtIndex:currentPage];
                CGFloat px = item.left;
                offx = px + [[widthArray objectAtIndex:currentPage] floatValue] + [[widthArray objectAtIndex:currentPage+1] floatValue] - self.width;
            }else{
                ZJLCtrlItem* item = [itemArray objectAtIndex:currentPage];
                CGFloat px = item.left;
                //                offx = (currentPage + 1) * itemWidth - self.width;
                offx = px + [[widthArray objectAtIndex:currentPage] floatValue] - self.width;
            }
        }
        point.x = offx;
        if (offx <= 0) {
            point.x = 0;
        }else{
            point.x = offx;
        }
    }else{
        if (itemArray.count <= KSpecailMinItems) {
            point.x = offx;
            _scrollView.contentOffset = point;
            for (int i = 0; i < [itemArray count]; i++) {
                ZJLCtrlItem* item = [itemArray objectAtIndex:i];
                if (currentPage == i) {
                    [item setCurrentView];
                }else{
                    [item setDefaultView];
                }
            }
            [self updateLayer:YES];
            return;
        }
        
        if (currentPage+1 > KSpecailMinItems) {
            if (currentPage + 1 != itemArray.count) {
                offx = (currentPage + 1.5) * itemWidth - self.width;
            }else{
                offx = (currentPage + 1) * itemWidth - self.width;
            }
        }
        point.x = offx;
        if (offx <= 0) {
            point.x = 0;
        }else{
            point.x = offx;
        }
    }
    
    [_scrollView setContentOffset:point animated:NO];
    
    for (int i = 0; i < [itemArray count]; i++) {
        ZJLCtrlItem* item = [itemArray objectAtIndex:i];
        if (currentPage == i) {
            [item setCurrentView];
        }else{
            [item setDefaultView];
        }
    }
    [self updateLayer:YES];
    
}

//设置滚动条字体
-(void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context{
    for (int i = 0; i < [itemArray count]; i++) {
        ZJLCtrlItem* item = [itemArray objectAtIndex:i];
        if (i == currentPage) {
            [item setCurrentView];
        } else{
            [item setDefaultView];
        }
    }
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray*) textArray defaultP:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        if (_scrollView == nil) {
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 0.5f)];
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            _scrollView.bounces = NO;
        }
        itemsVisableNum = KSpecailMinItems;
        if ([textArray count] <= KSpecailMinItems) {
            itemsVisableNum = [textArray count];
        }
        
        itemArray = [[NSMutableArray alloc]init];
        
        itemWidth = frame.size.width / itemsVisableNum;
        if ([textArray count] > KSpecailMinItems) {
            itemWidth = frame.size.width / (KSpecailMinItems + 0.5);
        }
        
        UIImage* imgBg = [PDUtils imageWithColor:[PDUtils colorWithInt:0xf5f5f5] size:CGSizeMake(1, 45)];
        self.backgroundColor = [UIColor colorWithPatternImage: imgBg];
        for (int i = 0; i < [textArray count]; i++) {
            CGRect iframe = CGRectMake(i * itemWidth, 0, itemWidth, frame.size.height - 0.5f);
            BOOL isFirst = NO;
            BOOL isLast = NO;
            if (i == 0) {
                isFirst = YES;
            }
            if (i == [textArray count] - 1) {
                isLast = YES;
            }
            ZJLCtrlItem* item = [[ZJLCtrlItem alloc]initWithFrame:iframe withTitle:[textArray objectAtIndex:i] withIsFirst:isFirst withIsLast:isLast];
            if (i == index) {
                [item setCurrentView];
            }
            item.titleStr = [textArray objectAtIndex:i];
            if (i == 0) {
                item.isFirst = YES;
            }
            if(i == ([textArray count] - 1)){
                item.isLast = YES;
            }
            [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = i;
            [itemArray addObject:item];
            [_scrollView addSubview:item];
            if(item.isLast == NO)
            {
                UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(item.right - 1, 5, 1, item.height - 10)];
                lineView.backgroundColor = [PDUtils colorWithInt:0xdddddd];
                [_scrollView addSubview:lineView];
            }
        }
        [_scrollView setContentSize:CGSizeMake(itemWidth * itemArray.count, self.height)];
        currentPage = index;
        ZJLCtrlItem* item = [itemArray objectAtIndex:currentPage];
        [item setCurrentView];
        [self addSubview:_scrollView];
        flagLayer = [CALayer layer];
        UIImage* layerImage = [UIImage imageNamed:@"flagLayer.png"];
        flagLayer.frame = CGRectMake(item.frame.origin.x , self.frame.size.height - layerImage.size.height-10, layerImage.size.width, layerImage.size.height);
        flagLayer.contents = (id)layerImage.CGImage;
        [_scrollView.layer addSublayer:flagLayer];
        [self layoutContens];
        
        UIView* lv = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - KDfltBdWidth, frame.size.width, KDfltBdWidth)];
        [lv setBackgroundColor:KDfltLColor];
        [self addSubview:lv];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame titles:(NSArray*) textArray defaultP:(NSInteger)index isWidthChange:(BOOL)isChange
{
    self = [super initWithFrame:frame];
    if (self) {
        if (_scrollView == nil) {
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 0.5f)];
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            _scrollView.bounces = NO;
        }
        
        
        itemArray = [[NSMutableArray alloc]init];
        if (isChange) {
            isAutoLength = YES;
            widthArray = [[NSMutableArray alloc]initWithCapacity:5];
        }else{
            itemsVisableNum = KSpecailMinItems;
            if ([textArray count] <= KSpecailMinItems) {
                itemsVisableNum = [textArray count];
            }
            itemWidth = frame.size.width / itemsVisableNum;
            if ([textArray count] > KSpecailMinItems) {
                itemWidth = frame.size.width / (KSpecailMinItems + 0.5);
            }
        }
        
        _scrollView.contentSize = CGSizeMake(0, self.height);
//        UIImage* imgBg = [ZUtils imageWithColor:[ZUtils colorWithInt:0xf5f5f5] size:CGSizeMake(1, 45)];
        self.backgroundColor = [UIColor clearColor];
        for (int i = 0; i < [textArray count]; i++) {
            CGSize cSize = _scrollView.contentSize;
            NSString* itemStr = [textArray objectAtIndex:i];
            CGRect iframe = CGRectMake(cSize.width, 0, itemWidth, frame.size.height- 0.5f);
            if (isAutoLength) {
                CGFloat iWith = [PDUtils textLengthWith:itemStr withFontSize:14] + 20;
                iframe.size.width = iWith;
                [widthArray addObject:[NSNumber numberWithFloat:iWith]];
                cSize.width += iWith;
            }else{
                cSize.width += itemWidth;
            }
            BOOL isFirst = NO;
            BOOL isLast = NO;
            if (i == 0) {
                isFirst = YES;
            }
            if (i == [textArray count] - 1) {
                isLast = YES;
            }
            ZJLCtrlItem* item = [[ZJLCtrlItem alloc]initWithFrame:iframe withTitle:itemStr withIsFirst:isFirst withIsLast:isLast];
//            if (i == index) {
//                [item setCurrentView];
//            }
            item.titleStr = [textArray objectAtIndex:i];
            if (i == 0) {
                item.isFirst = YES;
            }
            if(i == ([textArray count] - 1)){
                item.isLast = YES;
            }
            [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = i;
            [itemArray addObject:item];
            [_scrollView addSubview:item];
            _scrollView.contentSize = cSize;
        }
        //        [_scrollView setContentSize:CGSizeMake(itemWidth * itemArray.count, self.height)];
        currentPage = index;
//        ZJLCtrlItem* item = [itemArray objectAtIndex:currentPage];
//        [item setCurrentView];
        [self addSubview:_scrollView];
//        flagLayer = [CALayer layer];
//        UIImage* layerImage = [UIImage imageNamed:@"flagLayer.png"];
//        flagLayer.frame = CGRectMake(item.frame.origin.x , self.frame.size.height - layerImage.size.height-10, layerImage.size.width, layerImage.size.height);
//        flagLayer.contents = (id)layerImage.CGImage;
//        [_scrollView.layer addSublayer:flagLayer];
//        [self layoutContens];
        UIView* lv = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - KDfltBdWidth, frame.size.width, KDfltBdWidth)];
        [lv setBackgroundColor:KDfltLColor];
        [self addSubview:lv];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray*) textArray defaultP:(NSInteger)index needshowImgIndexArray:(NSArray*)indexArray andImgArray:(NSArray*)imgArray
{
    self = [super initWithFrame:frame];
    if (self) {
        if (_scrollView == nil) {
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 0.5f)];
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            _scrollView.bounces = NO;
        }
        
        
        itemArray = [[NSMutableArray alloc]init];
        itemsVisableNum = KSpecailMinItems;
        if ([textArray count] <= KSpecailMinItems) {
            itemsVisableNum = [textArray count];
        }
        itemWidth = frame.size.width / itemsVisableNum;
        if ([textArray count] > KSpecailMinItems) {
            itemWidth = frame.size.width / (KSpecailMinItems + 0.5);
        }
        
        _scrollView.contentSize = CGSizeMake(0, self.height);
        UIImage* imgBg = [PDUtils imageWithColor:[PDUtils colorWithInt:0xf5f5f5] size:CGSizeMake(1, 45)];
        self.backgroundColor = [UIColor colorWithPatternImage: imgBg];
        for (int i = 0; i < [textArray count]; i++) {
            CGSize cSize = _scrollView.contentSize;
            NSString* itemStr = [textArray objectAtIndex:i];
            CGRect iframe = CGRectMake(cSize.width, 0, itemWidth, frame.size.height- 0.5f);
            if (isAutoLength) {
                CGFloat iWith = [PDUtils textLengthWith:itemStr withFontSize:14] + 20;
                iframe.size.width = iWith;
                [widthArray addObject:[NSNumber numberWithFloat:iWith]];
                cSize.width += iWith;
            }else{
                cSize.width += itemWidth;
            }
            BOOL isFirst = NO;
            BOOL isLast = NO;
            if (i == 0) {
                isFirst = YES;
            }
            if (i == [textArray count] - 1) {
                isLast = YES;
            }
            
            NSString* imgName = nil;
            if (indexArray && indexArray.count>0) {
                for (NSInteger j = 0; j < [indexArray count]; j++) {
                    NSInteger indexxx = [[indexArray objectAtIndex:j] integerValue];
                    if (indexxx == i) {
                        imgName = [imgArray objectAtIndex:j];
                    }
                }
            }
            
            
            ZJLCtrlItem* item = [[ZJLCtrlItem alloc]initWithFrame:iframe withTitle:itemStr  withImgName:imgName withIsFirst:isFirst withIsLast:isLast];
            if (i == index) {
                [item setCurrentView];
            }
            item.titleStr = [textArray objectAtIndex:i];
            if (i == 0) {
                item.isFirst = YES;
            }
            if(i == ([textArray count] - 1)){
                item.isLast = YES;
            }
            [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = i;
            [itemArray addObject:item];
            [_scrollView addSubview:item];
            _scrollView.contentSize = cSize;
        }
        //        [_scrollView setContentSize:CGSizeMake(itemWidth * itemArray.count, self.height)];
        currentPage = 0;
        ZJLCtrlItem* item = [itemArray objectAtIndex:currentPage];
        [item setCurrentView];
        [self addSubview:_scrollView];
        flagLayer = [CALayer layer];
        UIImage* layerImage = [UIImage imageNamed:@"flagLayer.png"];
        flagLayer.frame = CGRectMake(item.frame.origin.x , self.frame.size.height - layerImage.size.height-10, layerImage.size.width, layerImage.size.height);
        flagLayer.contents = (id)layerImage.CGImage;
        [_scrollView.layer addSublayer:flagLayer];
        [self layoutContens];
        UIView* lv = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - KDfltBdWidth, frame.size.width, KDfltBdWidth)];
        [lv setBackgroundColor:KDfltLColor];
        [self addSubview:lv];
    }
    return self;
}

-(void) setPageToIndex:(NSInteger) index animate:(BOOL) animation{
    if (index >= 0 && index < [itemArray count]) {
        if (animation == YES) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            currentPage = index;
            [self layoutContens];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            [UIView commitAnimations];
            [self updateLayer:NO];
        } else {
            currentPage = index;
            [self layoutContens];
            for (int i = 0; i < [itemArray count]; i++) {
                ZJLCtrlItem* item = [itemArray objectAtIndex:i];
                if (i == currentPage) {
                    [item setCurrentView];
                } else{
                    [item setDefaultView];
                }
            }
        }
    }
}

//- (void)updateCtrlNameWith:(NSArray*)tArray
//{
//    for (NSInteger i = 0; i < tArray.count; i++) {
//        ZJLCtrlItem* item = [self viewForpage:i];
//        
//    }
//}

-(void) updateLayer:(BOOL) disableActions{
    [CATransaction setDisableActions:disableActions];
    CGRect rect = [self currentItemView].frame;
    flagLayer.opacity = 1;
    flagLayer.frame = CGRectMake(CGRectGetMidX(rect) -flagLayer.frame.size.width/2 , self.frame.size.height - flagLayer.frame.size.height - 4, flagLayer.frame.size.width, flagLayer.frame.size.height);
}

- (void)itemClicked:(UIControl*)contrl
{
    NSInteger oldIndex = currentPage;
    currentPage = contrl.tag;
    [self layoutContens];
    if (pageDelegate && [pageDelegate respondsToSelector:@selector(pageIndexChanged:fromPageIndex:)]) {
        [pageDelegate pageIndexChanged:currentPage fromPageIndex:oldIndex];
        return;
    }
    if ([pageDelegate respondsToSelector:@selector(pageIndexChanged:)]) {
        [pageDelegate pageIndexChanged:contrl.tag];
    }
}

-(void) dealloc{
    [itemArray removeAllObjects];
}

-(ZJLCtrlItem*) currentItemView{
    return [itemArray objectAtIndex:currentPage];
}

-(ZJLCtrlItem*) viewForpage:(NSInteger) page{
    if (page >= 0 && page < itemArray.count) {
        return [itemArray objectAtIndex:page];
    }
    return nil;
}

-(NSString*) titleForpage:(NSInteger) page{
    if (page >= 0 && page < itemArray.count) {
        ZJLCtrlItem* label =  [itemArray objectAtIndex:page];
        return label.titleStr;
    }
    return nil;
}

-(ZJLCtrlItem*) preView{
    if (currentPage == 0) {
        return nil;
    }
    return [itemArray objectAtIndex:currentPage - 1];
}

-(ZJLCtrlItem*) nextView{
    if ((currentPage + 1) == [itemArray count]) {
        return nil;
    }
    return [itemArray objectAtIndex:currentPage + 1];
}

-(NSInteger) currentPageIndex{
    return currentPage;
}

- (void)itemChangeImgWith:(NSString*)imgStr forItemIndex:(NSInteger)index
{
    ZJLCtrlItem* item = [itemArray objectAtIndex:index];
    [item changImgViewWith:imgStr];
}

#pragma mark - 其他辅助功能
#pragma mark 取消所有button点击状态
-(void)changeButtonsToNormalState{
    for (UIButton *vButton in itemArray) {
        vButton.selected = NO;
    }
}

#pragma mark 模拟选中第几个button
-(void)clickButtonAtIndex:(NSInteger)aIndex{
    UIButton *vButton = [itemArray objectAtIndex:aIndex];
    [self menuButtonClicked:vButton];
}

#pragma mark 改变第几个button为选中状态，不发送delegate
-(void)changeButtonStateAtIndex:(NSInteger)aIndex{
    if (itemArray.count <= aIndex) {
        return;
    }
    UIButton *vButton = [itemArray objectAtIndex:aIndex];
    [self changeButtonsToNormalState];
    vButton.selected = YES;
    [self moveScrolViewWithIndex:aIndex];
}

#pragma mark 移动button到可视的区域
-(void)moveScrolViewWithIndex:(NSInteger)aIndex{
    if (itemArray.count < aIndex) {
        return;
    }
    //宽度小于320肯定不需要移动
    if (itemArray.count <= 4) {
        return;
    }
}

#pragma mark - 点击事件
-(void)menuButtonClicked:(UIButton *)aButton{
    [self changeButtonStateAtIndex:aButton.tag];
    if ([pageDelegate respondsToSelector:@selector(pageIndexChanged:)]) {
        [pageDelegate pageIndexChanged:aButton.tag];
    }
}
@end
