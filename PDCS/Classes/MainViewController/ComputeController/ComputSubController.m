//
//  ComputSubController.m
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputSubController.h"
#import "ComputRequestModel.h"
#import "ComputDataModel.h"

#import "ZJLPageControl.h"
#import "ComputTableView.h"
#import "HBBTMSingleTView.h"




#define     kPageCtrlH       45.0f

@interface ComputSubController ()<ZJLPageControlDelegate>
{
    NSMutableDictionary * requestDic;
    NSIndexPath *  selctIndex;
}
@property(nonatomic,strong)NSArray * titlesAry;
@property(nonatomic,assign)NSInteger        toIndex;
@property (nonatomic, strong)ZJLPageControl * pageCtrl;
@property(nonatomic,strong)ComputTableView *tableView;
@property(nonatomic,strong)NSMutableArray * keyArys;


@property(nonatomic,strong)NSMutableArray * titleAry;

@property(nonatomic,strong)NSMutableDictionary * infoDic;
@end

@implementation ComputSubController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     [self initData];
   CGRect bouns = [UIScreen mainScreen].bounds;
    self.view.frame = CGRectMake(0, 0,bouns.size.width , bouns.size.height);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWithMethod];
   
}

-(void)requestWithMethod{
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    
    WEAKSELF
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [ComputRequestModel computRequest:PDCR_CPSSType_Url Parameter:dict Obj:^(id obj) {
        [weakSelf aryAndDict:obj];
    }];
}


-(void)aryAndDict:(id)obj{
    if (_titleAry == nil) {
        _titleAry = [NSMutableArray arrayWithCapacity:5];
        _keyArys = [NSMutableArray arrayWithCapacity:5];
    }
    
    NSArray * ary = obj[@"LIST"];
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_titleAry addObject:obj[@"NAME"]];
        [_keyArys addObject:obj[@"PRD_CAL_TYPE"]];
    }];
    
    [self PageControView];
    
}


-(void)initData{
    if (self.infoDic == nil) {
        self.infoDic = [[NSMutableDictionary alloc] init];
        requestDic = [[NSMutableDictionary alloc] init];
    }else{
        [self.infoDic removeAllObjects];
        [requestDic removeAllObjects];
    }
    
    [self.infoDic setDictionary:[ComputDataModel initWithDictModel]];
    
}


-(void)initView{

}


-(void)PageControView{
    CGRect pRect = CGRectMake(0, 0, SCREEN_WIDTH, kPageCtrlH);
    _pageCtrl = [[ZJLPageControl alloc]initWithFrame:pRect titles:_titleAry defaultP:_toIndex isWidthChange:NO];
    _pageCtrl.pageDelegate = self;
    _pageCtrl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_pageCtrl];
}

-(void) pageIndexChanged:(NSInteger) pageIndex{
    [self showTableListAndData:pageIndex];
}


-(void)showTableListAndData:(NSInteger )dTag{
    
    
    
    [requestDic setObject:_keyArys[dTag] forKey:@"PRD_CAL_TYPE"];
    
    if (self.tableView == nil) {
     
        WEAKSELF
        self.tableView = [[ComputTableView alloc] initWithFrame:CGRectMake(0, kPageCtrlH, SCREEN_WIDTH, self.contentView.height) InfoData:self.infoDic];
        
        self.tableView.cellDidClickBlock = ^(NSIndexPath * index) {
            NSLog(@"______%ld",(long)index);
            [weakSelf dataWithInfoDict:index];
        };
     
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(kPageCtrlH);
            make.top.equalTo(self.view);
            make.left.right.bottom.equalTo(self.view);
        }];
    }else{
        
//        [self.tableListView updata:info AndType:type];
        
    }
}




//点击cell 请求方法
-(void)dataWithInfoDict:(NSIndexPath *)index {
    selctIndex = index;
    WEAKSELF
    [ComputDataModel requestComputModel:index ParamDic:requestDic blok:^(NSDictionary *dict) {
        [weakSelf singleTableView:dict];
        [weakSelf nollWithData:index];
    }];
    
}


-(void)singleTableView:(NSDictionary *)dict{
    
   
    
    NSArray * names = dict[@"name"];
    CGRect btmFrame = SCREEN_BOUNDS;
    if (!ISIOS7ORLATER) {
        btmFrame.size.height -= 20;
    }
    
    WEAKSELF
    HBBTMSingleTView* btmView = [[HBBTMSingleTView alloc]initWithFrame:btmFrame];
    btmView.slctIndex = 0;//初始值
    btmView.dataArray = names;//数据Data
    btmView.iBlock = ^(NSInteger iItem){
        NSArray * value = dict[@"value"];
        NSLog(@"____%@",value[iItem]);
        NSLog(@"____%@ld",selctIndex);
        
        
        [weakSelf infoWithData:value[iItem]];
    };
    
    [btmView show];
}

/*
 ywxx 业务信息
 cpxx  产品信息
 jgxx  机构信息

 */

-(void)infoWithData:(NSDictionary *)dictY
{
    NSInteger section = selctIndex.section;
    NSInteger row = selctIndex.row;
    if (section == 0) {
        switch (row) {
            case 0:
                {
                    [requestDic setValue:dictY[@"DEP_TXBM"] forKey:@"ywmk"];
                    NSDictionary * dict = self.infoDic[@"ywxx"];
                    NSArray * ary = dict[@"value"];
                    NSMutableDictionary * mDict = ary[row];
                    [mDict setObject:dictY[@"DEP_TXMC"] forKey:@"value"];
                    [self.tableView setInfoDate:self.infoDic];
                }
                break;
            case 1:
            {
                [requestDic setValue:dictY[@"DEP_TXBM"] forKey:@"ywlx"];
                
                NSDictionary * dict = self.infoDic[@"ywxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"DEP_TXMC"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
            case 2:
            {
                [requestDic setValue:dictY[@"DEP_TXBM"] forKey:@"ywxt"];
                
                NSDictionary * dict = self.infoDic[@"ywxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"DEP_TXMC"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
                
            }
                break;
            default:
                break;
        }
    }else if (section == 1){
        switch (row) {
            case 0:
                {
                    [requestDic setValue:dictY[@"DEP_TXBM"] forKey:@"cpmc"];
                    
                    NSDictionary * dict = self.infoDic[@"cpxx"];
                    NSArray * ary = dict[@"value"];
                    NSMutableDictionary * mDict = ary[row];
                    [mDict setObject:dictY[@"DEP_TXMC"] forKey:@"value"];
                    [self.tableView setInfoDate:self.infoDic];
                }
                break;
            case 1:
            {
                [requestDic setValue:dictY[@"TERM_TS"] forKey:@"TERM_TS"];//限期天数
                [requestDic setValue:dictY[@"TERM_QXBM"] forKey:@"TERM_QXBM"];//限期编码
                
                NSDictionary * dict = self.infoDic[@"cpxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"TERM_QXMC"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
            case 2:
            {
                [requestDic setValue:dictY[@"CURR_ISO"] forKey:@"bz"];//币种
                
                NSDictionary * dict = self.infoDic[@"cpxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"CURR_ZWM"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
            case 3:
            {
                [requestDic setValue:dictY[@"CUST_LVL"] forKey:@"khlb"];//币种
                
                NSDictionary * dict = self.infoDic[@"cpxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"CUST_LVL_NAME"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
            default:
                break;
        }
    }else if (section == 2){
        switch (row) {
                
            case 0:
            {
                [requestDic setValue:dictY[@"ORG_ID"] forKey:@"scfh"];//所属分行
                
                NSDictionary * dict = self.infoDic[@"jgxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"ORG_NAME"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
            case 1:
            {
                [requestDic setValue:dictY[@"ORG_ID"] forKey:@"sczh"];//所属分行
                
                NSDictionary * dict = self.infoDic[@"jgxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"ORG_NAME"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
            case 2:
            {
                [requestDic setValue:dictY[@"ORG_ID"] forKey:@"scwd"];//所属分行
                
                NSDictionary * dict = self.infoDic[@"jgxx"];
                NSArray * ary = dict[@"value"];
                NSMutableDictionary * mDict = ary[row];
                [mDict setObject:dictY[@"ORG_NAME"] forKey:@"value"];
                [self.tableView setInfoDate:self.infoDic];
            }
                break;
                
            default:
                break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 "PRD_CAL_TYPE" = 1; 当前样式
 "TERM_QXBM" = 101; 合同限制
 "TERM_TS" = 1; 合同期限
 bz = CNY; 币种
 cpmc = 10111010101; 产品名称
 khlb = 01001; 客户类别
 scfh = 10001; 所属分行
 sczh = 0042; 所属支行
 ywlx = 1011; 业务类型
 ywmk = 10;  业务模块
 ywxt = 1011101; 业务线条
 */

-(void)nollWithData:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row   = indexPath.row;
    
    if (section == 0) {
        if (row == 1) {
            NSDictionary * dict = self.infoDic[@"ywxx"];
            NSArray * ary = dict[@"value"];
            NSMutableDictionary * mDict = ary[2];
            [mDict setObject:@"" forKey:@"value"];
           
        }
        
        NSDictionary * dict = self.infoDic[@"jgxx"];
        NSArray * ary = dict[@"value"];
        for (NSMutableDictionary * mDic in ary) {
            [mDic setObject:@"" forKey:@"value"];
        }
        
        NSDictionary * cdict = self.infoDic[@"cpxx"];
        NSArray * cary = cdict[@"value"];
        for (NSMutableDictionary * mDic in cary) {
            [mDic setObject:@"" forKey:@"value"];
        }

        [self.tableView setInfoDate:self.infoDic];
    }else if (section == 1){
        NSDictionary * dict = self.infoDic[@"cpxx"];
        NSArray * cary = dict[@"value"];
        
        for (NSMutableDictionary * mDic in cary) {
            [mDic setObject:@"" forKey:@"value"];
        }
    }else if (section == 2){
        
    }
   
    
    
     [self.tableView setInfoDate:self.infoDic];
}


@end
