//
//  MyController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "MyController.h"
#import "PDUserHDView.h"
#import "PDUserCell.h"

#import "PDNavigationController.h"
#import "PDLoginViewController.h"

@interface MyController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)PDUserHDView * topHeader;
@property (nonatomic, strong)NSMutableArray*        headerViews;


@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView
{
    [self initHeaderViews];
    CGSize vSize                = self.contentView.size;
    _myTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, vSize.height - kTabbarH) style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource     = self;
    _myTableView.delegate       = self;
    _myTableView.backgroundColor= [UIColor clearColor];
    [self.contentView addSubview:_myTableView];
    _topHeader                  = [[PDUserHDView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.7)];
    WEAKSELF
    _topHeader.btnClickBlock    = ^(NSInteger cTag){
        [weakSelf dealCtrlClickWith:cTag];
    };
    [_topHeader upLoadViewInfo];
    [self addHeader];
    //    header = [CExpandHeader expandWithScrollView:_myTableView expandView:_topHeader];
}
- (void)addHeader
{
    WEAKSELF
    // 添加下拉刷新头部控件
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (!_isLogin) {
            [weakSelf.myTableView.mj_header endRefreshing];
            return;
        }
        [self getUserInfo];
        [weakSelf.myTableView.mj_header beginRefreshing];
    }];
}

#pragma maek TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SCREEN_WIDTH * 0.7;
    }else{
        return KSecHeight;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section >= 1) {
        UIView* view = _headerViews[section - 1];
        return view;
    }else{
        return _topHeader;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDUserCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIndentifer = @"indentifier";
    PDUserCell * cell= [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (cell == nil) {
        cell = [[PDUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifer];
    }
    
    return cell;
}

- (void)initHeaderViews
{

    _headerViews = [[NSMutableArray alloc]initWithCapacity:3];
    for (NSInteger i = 0; i < 11; i++) {
        UIView* view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_headerViews addObject:view];
    }
}

- (void)getUserInfo{
    
}

- (void)dealCtrlClickWith:(NSInteger)cTag{
    [kUserDefault setBool:NO forKey:KIsFirstUse];
    
    PDLoginViewController* aVc = [[PDLoginViewController alloc]init];
    PDNavigationController *navi=[[PDNavigationController alloc]initWithRootViewController:aVc];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = navi;
}

@end
