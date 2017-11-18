//
//  QuoteSubGPController.m
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "QuoteSubGPController.h"
#import "QuoteHeader.h"
#import "DLQuoteWebView.h"

@interface QuoteSubGPController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
{
    QuoteDataModel * dataTypeModel;
    NSInteger cSelectIndex;
    currentType ctype;
}
@property(nonatomic,strong)DLQuoteWebView * webView;

@property(nonatomic,strong)NSMutableArray * titlesAry;//资金 同业
@property(nonatomic,strong)NSMutableArray * titlesZHAry;//某支行
@property(nonatomic,strong)NSMutableArray * titlesBZAry;//币种


@property(nonatomic,strong)PDCSSegmentedButtonView * segmenterBut;
@property(nonatomic,strong)TwoTableView * tableListView;

@property(nonatomic,copy)NSString * disStr;

@property(nonatomic,strong)NSArray * segmentedTitles;

@property (nonatomic,copy) NSString * jigouString;
@property (nonatomic,copy) NSString * zichanString;
@property (nonatomic,copy) NSString * tongyeString;
@property (nonatomic,copy) NSString * qianString;
@property (nonatomic,copy) NSString * timeString;

@end

@implementation QuoteSubGPController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.contentView addSubview:self.segmenterBut];
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
        self.titlesZHAry = [NSMutableArray arrayWithCapacity:5];
        self.titlesBZAry = [NSMutableArray arrayWithCapacity:5];
    }
}

#pragma  mark -**  数据请求 **-
-(void)requestWithMethod{

    [_titlesAry   removeAllObjects];
    [_titlesZHAry removeAllObjects];
    [_titlesBZAry removeAllObjects];
    
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSString  * rUrl;
    WEAKSELF
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    if (self.loadType == QupoteLoadGuaType) {
        rUrl = PDCR_GPType_Url;
    }else if (self.loadType == QupoteLoadShiType){
        rUrl = PDCR_SCType_Url;
    }else if (self.loadType == QupoteLoadFtpType){
        rUrl = PDCR_FTPType_Url;
    }
    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [QuoteRequestModel quoteRequest:rUrl Parameter:dict Obj:^(id obj) {
        [weakSelf aryAndDict:obj];
    }];
    
    
    NSMutableDictionary * dFH = [[NSMutableDictionary alloc] init];
    [dFH setObject:model.USER_ID forKey:@"USER_ID"];
    [dFH setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [dFH setObject:model.ORG_ID forKey:@"ORG_ID"];
    [dFH setObject:@"1" forKey:@"LBDM"];
    
    [QuoteRequestModel quoteRequest:PDCR_CPJGype_Url Parameter:dFH Obj:^(id obj) {
        [weakSelf aryAndJGDict:obj];
    }];
    
    
    NSMutableDictionary * dBZ = [[NSMutableDictionary alloc] init];
    [dBZ setObject:model.USER_ID forKey:@"USER_ID"];
    [dBZ setObject:model.ROLE_ID forKey:@"ROLE_ID"];

    [QuoteRequestModel quoteRequest:PDCR_GPBZType_Url Parameter:dBZ Obj:^(id obj) {
        [weakSelf aryAndBZDict:obj];
    }];
    
    
    
}

-(void)aryAndDict:(id)obj{
    _titlesAry = obj[@"PAGE_LIST"];
    NSMutableArray * tempAry = [NSMutableArray arrayWithCapacity:3];
    for (NSDictionary *dict in _titlesAry) {
        if (self.loadType == QupoteLoadGuaType) {
            [tempAry addObject:dict[@"PRD_CPLB_MC"]];
        }else if (self.loadType == QupoteLoadShiType){
           
        }else if (self.loadType == QupoteLoadFtpType){
            
        }
    }
}
-(void)aryAndJGDict:(id)obj{
    
    _titlesZHAry = obj;
}

-(void)aryAndBZDict:(id)obj{
    
    _titlesBZAry = obj;
}

#pragma  mark -**  页面视图分段显示 **-

-(PDCSSegmentedButtonView *)segmenterBut{
    if (dataTypeModel==nil) {
        dataTypeModel = [[QuoteDataModel alloc] init];
    }
    WEAKSELF
    self.segmentedTitles = [NSArray arrayWithObjects:@"某支行",@"资产",@"同业",@"人民币",nil];
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
            ctype = selectGPZHtype;
            data = _titlesZHAry;
        }
            break;
        case 1:
        {
            ctype = selectGPZCtype;
            data = _titlesAry;
        }
            break;
        case 2:
        {
             ctype = selectGPTYtype;
            data = _titlesAry[cSelectIndex];
        }
            break;
        case 3:
        {
            ctype = selectGPRMBtype;
            data = _titlesBZAry;
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
            if (ctype == selectGPZCtype) {
                cSelectIndex = selectIndex;
            }
            
            [weakSelf.webView requestJSString:[weakSelf appJSString:type value:number]];
            
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

-(NSString *)appJSString:(currentType)type value:(NSString*)value{
    if (type == selectGPZHtype){
        self.jigouString = value;
        self.zichanString = @"";
        self.tongyeString = @"";
        self.qianString = @"";
        self.timeString = [self todayString];
    }else if (type == selectGPZCtype){
        self.zichanString = value;
        self.tongyeString = @"";
        self.qianString = @"";
        self.timeString = [self todayString];
    }else if (type == selectGPTYtype){
        self.tongyeString = value;
        self.qianString = @"";
        self.timeString = [self todayString];
    }else if (type == selectGPRMBtype){
        self.qianString = value;
        self.timeString = [self todayString];
    }

    NSString * string = [NSString stringWithFormat:@"APPPriceCurveList('%@', '%@', '%@','%@','%@')",self.jigouString,self.timeString,self.qianString,self.zichanString,self.tongyeString];
    return string;
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
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        [configuration.userContentController addScriptMessageHandler:self name:@"aPPIOS.sponsorSelectTime"];
        
        _webView = [[DLQuoteWebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height - SegmentedH) configuration:configuration VC:self];
        [self.contentView addSubview:_webView];
        
        NSString * today  = [self todayString];
        self.jigouString = @"0042";
        self.timeString = today;
        self.qianString = @"CNY";
        self.zichanString = @"2";
        self.tongyeString = @"01001";
        [_webView requestURL:RDefaultUrl JSString:@"APPPriceCurveList('0042', '2017-11-18', 'CNY','2','01001')"];
    }
}

-(NSString*)todayString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

-(void)dealloc{
    [self.webView removeFromSuperview];
    self.webView = nil;
}

@end
