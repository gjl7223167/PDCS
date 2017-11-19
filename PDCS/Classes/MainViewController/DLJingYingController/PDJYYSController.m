//
//  PDJYYSController.m
//  PDCS
//
//  Created by Long on 2017/11/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDJYYSController.h"

#import "PDCSSegmentedButtonView.h"
#import "TwoTableView.h"
#import "PDJYZKModel.h"

@interface PDJYYSController ()
{
    currentType ctype;
}
@property(nonatomic,strong)PDCSSegmentedButtonView * segmenterBut;

@property(nonatomic,strong)TwoTableView * tableListView;
@property(nonatomic,strong)NSArray * segmentedTitles;


@property(nonatomic,strong)NSMutableArray * titlesFHAry;//分行
@property(nonatomic,strong)NSMutableArray * titlesSRAry;//收入
@end

@implementation PDJYYSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.view addSubview:self.segmenterBut];
    [self initAry];
}

-(void)initAry{
    _titlesFHAry = [NSMutableArray arrayWithCapacity:2];
    if (_titlesSRAry == nil) {

        _titlesSRAry = [[NSMutableArray alloc] initWithObjects:@{@"name":@"指标完成情况",@"value":@"0"},@{@"name":@"资产和负债占比",@"value":@"1"},@{@"name":@"资产和负债利率变化",@"value":@"2"},@{@"name":@"收入来源情况",@"value":@"3"},@{@"name":@"利润构成情况",@"value":@"4"},nil];
    }
}


-(PDCSSegmentedButtonView *)segmenterBut{

    WEAKSELF
    self.segmentedTitles = [NSArray arrayWithObjects:@"PDCS银行分行",@"收入来源情况",nil];
    if (_segmenterBut == nil) {
        _segmenterBut = [[PDCSSegmentedButtonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SegmentedH) titles:self.segmentedTitles];
        _segmenterBut.clickBlock = ^(NSInteger bTag) {
            if (bTag == 0) {
                [weakSelf requestData];
            }else{
                [weakSelf clickBlockIndex:bTag];
            }
          
        };
    }
    return _segmenterBut;
}


-(void)requestData{
    
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSMutableDictionary * dFH = [[NSMutableDictionary alloc] init];
    [dFH setObject:model.USER_ID forKey:@"USER_ID"];
    [dFH setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [dFH setObject:model.ORG_ID forKey:@"ORG_ID"];
    [dFH setObject:@"2" forKey:@"LBDM"];
    
    WEAKSELF
    [PDJYZKModel computRequest:PDCR_CPJGype_Url Parameter:dFH Obj:^(id obj) {
        [weakSelf aryAndJGDict:obj];
    }];
    
}




-(void)aryAndJGDict:(id)obj{
    [_titlesFHAry setArray:obj[@"LIST"]];
    [self clickBlockIndex:0];
}


-(void)clickBlockIndex:(NSInteger )cIndex{
    
    ctype = 0;
    id data = nil;
    switch (cIndex) {
        case 0:
        {
            ctype = selectZYZKFHtype;
            data = _titlesFHAry;
        }
            break;
        case 1:
        {
            ctype = selectZYZKYStype;
            data = _titlesSRAry;
        }
            break;
        default:
            break;
    }
    
    [self showTableListView:ctype AndData:data];
}

#pragma  mark -**  显示tableview列表 **-

-(void)showTableListView:(currentType )type AndData:(id)info{
    
    if (self.tableListView == nil) {
        WEAKSELF;
        self.tableListView = [[TwoTableView alloc] initWithFrame:CGRectMake(0, SegmentedH, SCREEN_WIDTH, SCREEN_HEIGHT) InfoData:info CuurentType:type];
        
        self.tableListView.endBlack = ^(NSString *number, NSString *dicStr, NSInteger selectIndex) {
  
            [weakSelf reqstJYZK:selectIndex AndType:type];
//            [weakSelf.webView requestJSString:[weakSelf appJSString:type value:number]];
            
            NSLog(@"%@  -- %@  ---- %ld",number,dicStr,selectIndex);
        };
        
        self.tableListView.cancelBlock = ^(){
            [weakSelf tableListCancael];
        };
        
        [self.view addSubview:_tableListView];
        
    }else{
        [self.tableListView updata:info AndType:type];
    }
}

-(void)tableListCancael{
    if ( self.tableListView ) {
        self.tableListView  = nil;
    }
}


-(void)reqstJYZK:(NSInteger )selectIndex AndType:(currentType )type{
    if (type == selectZYZKYStype) {
        
        [PDJYZKModel requestComputModel:selectIndex ParamDic:nil blok:^(NSDictionary *dict) {
            
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
