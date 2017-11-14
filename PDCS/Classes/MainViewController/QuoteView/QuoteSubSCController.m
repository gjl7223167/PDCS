//
//  QuoteSubSCController.m
//  PDCS
//
//  Created by iMac on 2017/10/27.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "QuoteSubSCController.h"
#import "QuoteHeader.h"
@interface QuoteSubSCController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    QuoteDataModel * dataTypeModel;
    NSInteger cSelectIndex;
    currentType ctype;
    NSString * RATE_LLLX;
}
@property(nonatomic,strong)WKWebView * webView;

@property(nonatomic,strong)NSMutableArray * titlesAry;
@property(nonatomic,strong)NSMutableArray * titlesRMBAry;
@property(nonatomic,strong)NSMutableArray * titlesRMBCAry;


@property(nonatomic,strong)PDCSSegmentedButtonView * segmenterBut;
@property(nonatomic,strong)TwoTableView * tableListView;

@property(nonatomic,copy)NSString * disStr;

@property(nonatomic,strong)NSArray * segmentedTitles;
@end

@implementation QuoteSubSCController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.contentView addSubview:self.segmenterBut];
    cSelectIndex = 0;
    RATE_LLLX = @"0";
    
    [self initData];
    [self initView];
    [self requestUrl];
    [self requestWithMethod];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.webView.scrollView.delegate = nil;
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
    
    [_titlesAry   removeAllObjects];
    [_titlesRMBAry removeAllObjects];
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
    _titlesAry = obj[@"PAGE_LIST"];
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
                [weakSelf requestRMB];
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
            if (ctype == selectSCRENBCtype) {
                cSelectIndex = selectIndex;
                RATE_LLLX = _titlesAry[cSelectIndex][@"RATE_LLLX"];
                [weakSelf requestRMB];
            }
            NSLog(@"%@  -- %@  ---- %ld",number,dicStr,selectIndex);
        };
        
        self.tableListView.cancelBlock = ^(){
            [weakSelf tableListCancael];
        };
        
        [self.contentView addSubview:_tableListView];
        
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
    
    CGSize vSize = self.contentView.size;
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height - SegmentedH)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.delegate = self;
        [self.contentView addSubview:_webView];
    }
    
}

-(void)requestUrl{
    
    NSURL * urlStr= [NSURL URLWithString:RDefaultUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlStr];
    [_webView loadRequest:request];
}




/*WKNavigationDelegate 代理方法*/

/* 1.在发送请求之前，决定是否跳转  */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/* 2.页面开始加载 */
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
}

/* 3.在收到服务器的响应头，根据response相关信息，决定是否跳转。 */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"在收到服务器的响应头，根据response相关信息，决定是否跳转");
}
/* 4.开始获取到网页内容时返回，需要注入JS，在这里添加 */
-(void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"开始获取到网页内容时返回，需要注入JS，在这里添加");
}

/* 5.页面加载完成之后调用 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"页面加载完成之后调用");
}

/* error - 页面加载失败时调用 */
-(void)webView:(WKWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
    NSLog(@"失败");
}

/* 其他 - 处理服务器重定向Redirect */
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

/*WKUIDelegate 代理方法*/

/* 输入框，页面中有调用JS的 prompt 方法就会调用该方法 */ - (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *result))completionHandler{
    
}

/* 确认框，页面中有调用JS的 confirm 方法就会调用该方法 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
}

/* 警告框，页面中有调用JS的 alert 方法就会调用该方法 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}

-(void)dealloc{
    self.webView.navigationDelegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
    self.webView.scrollView.delegate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
