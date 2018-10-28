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
#import "DLQuoteWebView.h"

@interface PDJYYSController ()
{
    currentType ctype;
}
@property(nonatomic,strong)PDCSSegmentedButtonView * segmenterBut;

@property(nonatomic,strong)TwoTableView * tableListView;
@property(nonatomic,strong)NSArray * segmentedTitles;


@property(nonatomic,strong)NSMutableArray * titlesFHAry;//分行
@property(nonatomic,strong)NSMutableArray * titlesSRAry;//收入

@property (nonatomic,strong) DLQuoteWebView * webView;
@property (nonatomic,copy) NSString * typeString;
@property (nonatomic,copy) NSString * timeString;
@property (nonatomic,copy) NSString * brankString;
@end

@implementation PDJYYSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.view addSubview:self.segmenterBut];
    [self initAry];
    [self initView];
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
            if (type == selectZYZKFHtype){
                weakSelf.brankString = number;
                weakSelf.typeString = @"";
                weakSelf.timeString = [NSString monthString];
                [weakSelf.webView requestURL:[NSString stringWithFormat:@"%@state_chart_511.html",RDefaultUrl] JSString:[NSString stringWithFormat:@"APPLoadData('%@','%@')",weakSelf.timeString,number]];
            }else if (type == selectZYZKYStype){
                weakSelf.typeString = number;
                weakSelf.timeString = [NSString monthString];
                [weakSelf webViewRequest:number time: weakSelf.timeString index:selectIndex];
            }
            NSLog(@"%@  -- %@  ---- %ld -- %u",number,dicStr,selectIndex,type);
        };
        
        self.tableListView.cancelBlock = ^(){
            [weakSelf tableListCancael];
        };
        
        [self.view addSubview:_tableListView];
        
    }else{
        [self.tableListView updata:info AndType:type];
    }
}

-(void)webViewRequest:(NSString*)orgid time:(NSString*)time index:(NSInteger)index{
    if (![NSString isStringEmpty:orgid]){
        if (![NSString isStringEmpty:time]){
            self.timeString = [NSString monthString];
        }
        NSString * url = nil;
        NSString * jsUrl = nil;
        if (index == 0){
            url = [NSString stringWithFormat:@"%@state_table_512.html",RDefaultUrl];
            jsUrl = [NSString stringWithFormat:@"APPLoadData('%@','%@','%@')",self.brankString,time,orgid];
        }else if (index == 1){
            url =  [NSString stringWithFormat:@"%@state_chart_521.html",RDefaultUrl];
            jsUrl =  [NSString stringWithFormat:@"APPLoadData('%@','%@')",time,orgid];
        }else if (index == 2){
            url = [NSString stringWithFormat:@"%@state_chart_531.html",RDefaultUrl];
            jsUrl =  [NSString stringWithFormat:@"APPLoadData('%@','%@')",time,orgid];
        }else if (index == 3){
            url = [NSString stringWithFormat:@"%@state_table_542.html",RDefaultUrl];
            jsUrl = [NSString stringWithFormat:@"APPLoadData('%@','%@','%@')",self.brankString,time,orgid];
        }else if (index == 4){
        jsUrl = [NSString stringWithFormat:@"APPLoadData('%@','%@','%@')",self.brankString,time,orgid];
            url = [NSString stringWithFormat:@"%@state_table_522.html",RDefaultUrl];
        }
        if (![NSString isStringEmpty:url]){
             [_webView requestURL:url JSString:jsUrl];
        }
       
    }
    
}


-(void)tableListCancael{
    if ( self.tableListView ) {
        self.tableListView  = nil;
    }
}


-(void)reqstJYZK:(NSInteger )selectIndex AndType:(currentType )type{
    if (type == selectZYZKYStype) {
        
//        [PDJYZKModel requestComputModel:selectIndex ParamDic:nil blok:^(NSDictionary *dict) {
//
//        }];
        
    }
}


#pragma  mark -**  WKWebview **-
-(void)initView{
    CGSize vSize = self.view.size;
    if (_webView == nil) {
        
        _webView = [[DLQuoteWebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height - SegmentedH) configuration:nil VC:self];
        [self.view addSubview:_webView];
    
        NSString * today  = [NSString monthString];
        self.timeString = today;
        self.typeString = @"CNY";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 指标完成情况
 页面地址
 http://lanshaoqi.cn/state_table_512.html
 
 获取页面数据
 
 APPLoadData(BNAME, MONTH_ID, ORG_ID)
 参数说明（该页面所需要的参数其实是从上一个页面传过来的。例如5-1-1页面跳转页面的方法第一个参数）
 BNAME          银行名称
 MONTH_ID       查询月份格式：yyyyMM
 ORG_ID          用户所属机构代码
 */

@end
