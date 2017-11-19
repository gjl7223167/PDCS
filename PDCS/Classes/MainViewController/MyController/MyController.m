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

@property (nonatomic,strong) NSArray * dataArray;

@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)rightBarUISet{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 40,40)];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [PDUtils appFontWithSize:14];
 
    [rightBtn setTitleColor:KCurrColor forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}
-(void)rightBtnClicked:(UIButton*)button{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView
{
    [self initHeaderViews];
    CGSize vSize                = self.view.size;
    _myTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, vSize.height - kTabbarH) style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource     = self;
    _myTableView.delegate       = self;
    _myTableView.backgroundColor= [UIColor clearColor];
    [self.view addSubview:_myTableView];
    _topHeader                  = [[PDUserHDView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.7)];
    WEAKSELF
    _topHeader.btnClickBlock    = ^(NSInteger cTag){
        [weakSelf dealCtrlClickWith:cTag];
    };
    [_topHeader upLoadViewInfo];
    [self addHeader];
    //    header = [CExpandHeader expandWithScrollView:_myTableView expandView:_topHeader];
    
    UserModel * userModel = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSDictionary * dic = userModel.userDictionary;
    self.dataArray = @[
                       @{@"title":@"用户编号",@"value":dic[@"USER_ID"]},
                       @{@"title":@"用户姓名",@"value":dic[@"NAME_CN"]},
                       @{@"title":@"用户性别",@"value":dic[@"USER_SEX"]},
                       @{@"title":@"所属机构",@"value":dic[@"ORG_NAME"]},
                       @{@"title":@"用户类型",@"value":dic[@"USER_TYP_NAME"]},
                       @{@"title":@"用户职位",@"value":dic[@"USER_PRIVILEGE_NAME"]},
                       @{@"title":@"电子邮箱",@"value":dic[@"USER_EMAIL"]},
                       @{@"title":@"电话号码",@"value":dic[@"USER_TEL"]},
                       @{@"title":@"住址",@"value":dic[@"USER_ADDR"]},
                       @{@"title":@"备注",@"value":dic[@"COMM"]}
                     ];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SCREEN_WIDTH * 0.7;
    }else{
        return KSecHeight;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section >= 1) {
//        UIView* view = _headerViews[section - 1];
//        return view;
//    }else{
    if (section == 0)
        return _topHeader;
//    }
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
    NSDictionary * dic = self.dataArray[indexPath.row];
    [cell updateCellInfoWith:dic[@"title"] andText:dic[@"value"]];
    
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

    UserModel * userModel = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSDictionary* dic =@{@"USER_ID":userModel.USER_ID};
    MJWeakSelf;
    [NetTool post:PDCR_QueryUserInfo_URL params:dic success:^(id JSON) {
        UserModel * model = [[UserModel alloc] initWithDataModel:JSON];
        [[UserModelTool sharedUserModelTool] storgaeObject:model];
        [weakSelf.myTableView.mj_header endRefreshing];
    } failure:^(NetError *error) {
        [SVProgressHUD showImage:nil status:error.errStr];
         [weakSelf.myTableView.mj_header endRefreshing];
    }];
}

- (void)dealCtrlClickWith:(NSInteger)cTag{
    [kUserDefault setBool:NO forKey:KIsFirstUse];
    
    PDLoginViewController* aVc = [[PDLoginViewController alloc]init];
    PDNavigationController *navi=[[PDNavigationController alloc]initWithRootViewController:aVc];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = navi;
}

-(void)setIsLogin:(BOOL)isLogin{
    if (_isLogin != isLogin){
        _isLogin = isLogin;
    }
}

@end
