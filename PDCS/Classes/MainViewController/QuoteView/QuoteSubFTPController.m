//
//  QuoteSubFTPController.m
//  PDCS
//
//  Created by iMac on 2017/10/27.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "QuoteSubFTPController.h"
#import "QuoteHeader.h"
#import "DLQuoteWebView.h"
#import "ALQoteUIwebView.h"
@interface QuoteSubFTPController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    QuoteDataModel * dataTypeModel;
    NSInteger cSelectIndex;
    currentType ctype;
}
//@property(nonatomic,strong)DLQuoteWebView * webView;
@property(nonatomic,strong)ALQoteUIwebView * webView;

@property(nonatomic,strong)NSMutableArray * titlesAry;


@property(nonatomic,strong)PDCSSegmentedButtonView * segmenterBut;
@property(nonatomic,strong)TwoTableView * tableListView;

@property(nonatomic,copy)NSString * disStr;

@property(nonatomic,strong)NSArray * segmentedTitles;
@property (nonatomic,copy)NSString * bizhongString;
@property (nonatomic,copy)NSString * quxianString;
@property (nonatomic,copy)NSString * timeString;
@end

@implementation QuoteSubFTPController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segmenterBut];
    cSelectIndex = 0;
    
    [self initData];
    [self initView];
    [self requestWithMethod];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initData{
    if (self.titlesAry == nil) {
        self.titlesAry = [NSMutableArray arrayWithCapacity:5];
    }
}

#pragma  mark -**  数据请求 **-
-(void)requestWithMethod{
    
    [_titlesAry   removeAllObjects];
    
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    WEAKSELF
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [QuoteRequestModel quoteRequest:PDCR_FTPType_Url Parameter:dict Obj:^(id obj) {
        [weakSelf aryAndDict:obj];
    }];
    
}

-(void)aryAndDict:(id)obj{
    _titlesAry = obj[@"PAGE_LIST"];
}


#pragma  mark -**  页面视图分段显示 **-

-(PDCSSegmentedButtonView *)segmenterBut{
    if (dataTypeModel==nil) {
        dataTypeModel = [[QuoteDataModel alloc] init];
    }
    WEAKSELF
    self.segmentedTitles = [NSArray arrayWithObjects:@"全部分类",@"人民币",nil];
    if (_segmenterBut == nil) {
        _segmenterBut = [[PDCSSegmentedButtonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SegmentedH) titles:self.segmentedTitles];
        _segmenterBut.clickBlock = ^(NSInteger bTag) {

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
            ctype = selectFTPQUFLtype;
            data = _titlesAry;
            
        }
            break;
        case 1:
        {
            ctype = selectFTPRMBtype;
            data = _titlesAry[cSelectIndex][@"LIST"];
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
        WEAKSELF
        self.tableListView = [[TwoTableView alloc] initWithFrame:CGRectMake(0, SegmentedH, SCREEN_WIDTH, SCREEN_HEIGHT) InfoData:info CuurentType:type];
        
        self.tableListView.endBlack = ^(NSString *number, NSString *dicStr, NSInteger selectIndex) {
            if (ctype == selectFTPQUFLtype) {
                cSelectIndex = selectIndex;
            }
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


#pragma  mark -**  WKWebview **-
-(void)initView{
    
    CGSize vSize = self.view.size;
    if (_webView == nil) {
        _webView = [[ALQoteUIwebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height-(iOSNavHeight+SegmentedH)- kTabbarH)];
        [self.view addSubview:_webView];
        NSString * today  = [NSString todayString];
        
        self.timeString = today;
        self.bizhongString = @"CNY";
        self.quxianString = @"1101";
        NSString * jsString = [NSString stringWithFormat:@"APPPriceCurveList('%@','%@','%@')",self.bizhongString,self.quxianString,self.timeString];
        [_webView requestURL:[NSString stringWithFormat:@"%@index_ftp.html",RDefaultUrl] JSString:jsString];
        
    }
}





-(void)dealloc{
    [self.webView removeFromSuperview];
    self.webView = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
