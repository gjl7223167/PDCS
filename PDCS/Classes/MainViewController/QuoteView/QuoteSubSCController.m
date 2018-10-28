//
//  QuoteSubSCController.m
//  PDCS
//
//  Created by iMac on 2017/10/27.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "QuoteSubSCController.h"
#import "QuoteHeader.h"
#import "DLQuoteWebView.h"
@interface QuoteSubSCController ()<WKUIDelegate,WKNavigationDelegate>
{
    QuoteDataModel * dataTypeModel;
    NSInteger cSelectIndex;
    currentType ctype;
    NSString * RATE_LLLX;
}
@property(nonatomic,strong)DLQuoteWebView * webView;

@property(nonatomic,strong)NSMutableArray * titlesAry;
@property(nonatomic,strong)NSMutableArray * titlesRMBAry;
@property(nonatomic,strong)NSMutableArray * titlesRMBCAry;


@property(nonatomic,strong)PDCSSegmentedButtonView * segmenterBut;
@property(nonatomic,strong)TwoTableView * tableListView;

@property(nonatomic,copy)NSString * disStr;

@property(nonatomic,strong)NSArray * segmentedTitles;

@property (nonatomic,copy) NSString * daleiString;
@property (nonatomic,copy) NSString * qianString;
@property (nonatomic,copy) NSString * timeString;
@property (nonatomic,copy) NSString * lilvString;
@end

@implementation QuoteSubSCController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segmenterBut];
    cSelectIndex = 0;
    RATE_LLLX = @"0";
    
    [self initData];
    [self initView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWithMethod];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initData{
    if (self.titlesAry == nil) {
        self.titlesAry = [NSMutableArray arrayWithCapacity:5];
        self.titlesRMBAry = [NSMutableArray arrayWithCapacity:5];
        self.titlesRMBCAry = [NSMutableArray arrayWithCapacity:5];
    }
}

#pragma  mark -**  数据请求 **-
-(void)requestWithMethod{
    
    if (_titlesAry){
        [_titlesAry removeAllObjects];
    }
    
    if (_titlesRMBAry)
        [_titlesRMBAry removeAllObjects];
    
    if (_titlesRMBCAry)
        [_titlesRMBCAry removeAllObjects];
   
    
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    WEAKSELF
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [QuoteRequestModel quoteRequest:PDCR_SCType_Url Parameter:dict Obj:^(id obj) {
        [weakSelf aryAndDict:obj];
    }];
  
}

-(void)aryAndDict:(id)obj{
    [_titlesAry setArray:obj[@"PAGE_LIST"]];
}

-(void)requestRMB{
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSMutableDictionary * dBZ = [[NSMutableDictionary alloc] init];
    [dBZ setObject:model.USER_ID forKey:@"USER_ID"];
    [dBZ setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [dBZ setObject:RATE_LLLX forKey:@"RATE_LLLX"];
    WEAKSELF
    [QuoteRequestModel quoteRequest:PDCR_SCBZType_Url Parameter:dBZ Obj:^(id obj) {
        [weakSelf aryAndBZDict:obj];
    }];
}

-(void)aryAndBZDict:(id)obj{
    
    _titlesRMBCAry = obj;
}

#pragma  mark -**  页面视图分段显示 **-

-(PDCSSegmentedButtonView *)segmenterBut{
    if (dataTypeModel==nil) {
        dataTypeModel = [[QuoteDataModel alloc] init];
    }
    WEAKSELF
    self.segmentedTitles = [NSArray arrayWithObjects:@"人民币存",@"全部分类",@"人民币",nil];
    if (_segmenterBut == nil) {
        _segmenterBut = [[PDCSSegmentedButtonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SegmentedH) titles:self.segmentedTitles];
        _segmenterBut.clickBlock = ^(NSInteger bTag) {
            if (bTag == 2) {
//                [weakSelf requestRMB];
            }
            [weakSelf clickBlockIndex:bTag];
        };
    }
    return _segmenterBut;
}


-(void)clickBlockIndex:(NSInteger )cIndex{
    
    ctype = 0;
    id data = nil;
    switch (cIndex) {
        case 0:
        {
            ctype = selectSCRENBCtype;
            data = _titlesAry;

        }
            break;
        case 1:
        {
            ctype = selectSCQBFLtype;
            data = _titlesAry[cSelectIndex][@"LIST"];
        }
            break;
        case 2:
        {
            ctype = selectSCRMBtype;
            data = _titlesAry[cSelectIndex][@"BZ_LIST"];
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
            if (ctype == selectSCRENBCtype) {
                cSelectIndex = selectIndex;
                RATE_LLLX = _titlesAry[cSelectIndex][@"RATE_LLLX"];
//                [weakSelf requestRMB];
            }
            [weakSelf.webView requestJSString:[weakSelf appJSString:type value:number]];
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

-(NSString *)appJSString:(currentType)type value:(NSString*)value{
    if (type == selectSCRENBCtype){
        self.daleiString = value;
        self.lilvString = @"";
        self.qianString = @"";
        self.timeString = [NSString todayString];
    }else if (type == selectSCQBFLtype){
        self.lilvString = value;
        self.qianString = @"";
        self.timeString = [NSString todayString];
    }else if (type == selectSCRMBtype){
        self.qianString = value;
        self.timeString = [NSString todayString];
    }
    
   NSString * jsString = [NSString stringWithFormat:@"APPPriceCurveList('%@','%@','%@','%@')",self.daleiString,self.qianString,self.lilvString,self.timeString];
    return jsString;
}


-(void)tableListCancael{
    if ( self.tableListView ) {
        self.tableListView  = nil;
    }
}


#pragma  mark -**  WKWebview **-
-(void)initView{
    
    CGSize vSize = self.view.size;
    if (_webView == nil) {
        _webView = [[DLQuoteWebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height - SegmentedH) configuration:nil VC:self];
        [self.view addSubview:_webView];
         NSString * today  = [NSString todayString];
        self.qianString = @"CNY";
        self.timeString = today;
        self.lilvString = @"";
        self.daleiString = @"01";
        NSString * jsString = [NSString stringWithFormat:@"APPPriceCurveList('%@','%@','%@','%@')",self.daleiString,self.qianString,self.lilvString,self.timeString];
        [_webView requestURL:[NSString stringWithFormat:@"%@index_shichang.html",RDefaultUrl] JSString:jsString];
    }
}

-(void)dealloc{

    [self.webView removeFromSuperview];
    self.webView = nil;
}


@end
