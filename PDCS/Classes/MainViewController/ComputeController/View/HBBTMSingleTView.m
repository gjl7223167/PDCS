//
//  HBBTMSingleTView.m
//  besttravel
//
//  Created by iOS on 16/4/8.
//  Copyright © 2016年 第一出行. All rights reserved.
//

#import "HBBTMSingleTView.h"
#import "HBSglLabCell.h"

@interface HBBTMSingleTView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView*                mainView;
@property (nonatomic, strong)UILabel*               tLabel;
@property (nonatomic, assign)BOOL                   isOK;
@property (nonatomic, copy)  NSString*              pStr;
@property (nonatomic, strong)UIButton*              aBtn, *uBtn;
@property (nonatomic, strong)UITableView*           myTableView;

@end

@implementation HBBTMSingleTView

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
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, vSize.height - 225, SCREEN_WIDTH, 225)];
    _mainView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    [self addSubview:_mainView];
    
    UIButton* cleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleBtn.frame = CGRectMake(0, 0, 80, 40);
    cleBtn.titleLabel.font = [HBUtils appFontWithSize:14];
    cleBtn.backgroundColor = [UIColor clearColor];
    [cleBtn setTitleColor:KTSubmTClr forState:UIControlStateNormal];
    [cleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cleBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cleBtn.tag   =  10001;
    [_mainView addSubview:cleBtn];
    
    UIButton* subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 80, 40);
    subBtn.titleLabel.font = [HBUtils appFontWithSize:14];
    subBtn.backgroundColor = [UIColor clearColor];
    [subBtn setTitleColor:KCurrColor forState:UIControlStateNormal];
    [subBtn setTitle:@"确定" forState:UIControlStateNormal];
    [subBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    subBtn.tag = 10002;
    [_mainView addSubview:subBtn];
    
    _tLabel = [HBUtils createLabel:@"标题" with:KTMainTClr frame:CGRectMake(0, 0, SCREEN_WIDTH, subBtn.height) with:14];
    _tLabel.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:_tLabel];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(KEdgeGap*2, subBtn.bottom + 5, SCREEN_WIDTH - KEdgeGap*4, _mainView.height - subBtn.height - 10) style:UITableViewStylePlain];
    _myTableView.delegate       = self;
    _myTableView.dataSource     = self;
    _myTableView.backgroundColor= [UIColor whiteColor];
    _myTableView.layer.borderWidth = KDfltBdWidth;
    _myTableView.layer.borderColor = KDfltBdColor;
    [_mainView addSubview:_myTableView];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (_dataArray.count < 5) {
        CGFloat cheight = (5- _dataArray.count) * 35.0f;
        self.height -= cheight;
        self.top    += cheight;
        _myTableView.height -= cheight;
    }
    [self reloadData];
}

- (void)setSlctIndex:(NSInteger)slctIndex
{
    _slctIndex = slctIndex;
}

- (void)reloadData
{
    [_myTableView reloadData];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:(_slctIndex < 0)?0:_slctIndex inSection:0];
    [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray && _dataArray.count > 0) {
        return _dataArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row       = indexPath.row;
    NSString* cellIndentifer = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (!cell) {
        cell = [[HBSglLabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifer];
    }
    
    if (_dataArray.count > 0) {
        HBSglLabCell* cCell = (HBSglLabCell*)cell;
        [cCell updateCellWith:_dataArray[row] isCurr:(row == _slctIndex)];
        return cCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    _slctIndex = indexPath.row;
    [_myTableView reloadData];
}


- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


- (void)btnClicked:(UIButton*)btn
{
    if (btn.tag == 10001) {
        Log(@"取消了");
        [self dismiss];
    }else if(btn.tag == 10002){
        if (_slctIndex < 0) {
            [SVProgressHUD showImage:nil status:@"请选择一个时间"];
            return;
        }
        Log(@"确定了");
        if (_iBlock) {
            _iBlock(_slctIndex);
        }
        [self dismiss];
    }else if (btn.tag == 10003){
        Log(@"可以出租");
        _isOK = YES;
    }else{
        _isOK = NO;
        Log(@"不出租");
    }
}

- (void)dismiss
{
    [UIView animateKeyframesWithDuration:0.5 delay:0.3 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        CGRect mFrame = _mainView.frame;
        mFrame.origin.y = self.height;
        _mainView.frame = mFrame;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
