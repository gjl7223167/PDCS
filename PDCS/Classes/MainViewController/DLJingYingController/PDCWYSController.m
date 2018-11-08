//
//  PDCWYSController.m
//  PDCS
//
//  Created by Long on 2017/11/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDCWYSController.h"
#import "ZJLPageControl.h"
#import "DLQuoteWebView.h"
#define     kPageCtrlH       45.0f

@interface PDCWYSController ()<ZJLPageControlDelegate>
@property (nonatomic, strong)ZJLPageControl * pageCtrl;
@property(nonatomic,strong)NSMutableArray * titleAry;

@property (nonatomic,strong) DLQuoteWebView * webView;
@end

@implementation PDCWYSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self PageControView];
    
}



-(void)PageControView{
    if (_titleAry == nil) {
        _titleAry = [[NSMutableArray alloc] initWithObjects:@"负载结构",@"财务指示债标",@"资产负载表",@"利润表",nil];
    }
    
    CGRect pRect = CGRectMake(0, 0, SCREEN_WIDTH, kPageCtrlH);
    _pageCtrl = [[ZJLPageControl alloc]initWithFrame:pRect titles:_titleAry defaultP:1 isWidthChange:NO];
    _pageCtrl.pageDelegate = self;
    _pageCtrl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageCtrl];
}

-(void) pageIndexChanged:(NSInteger) pageIndex{
    [self showTableListAndData:pageIndex];
}

-(void)showTableListAndData:(NSInteger )dTag{
    NSString * url = nil;
    if (dTag == 0){
        url = [NSString stringWithFormat:@"%@state_chart_611.html",RDefaultUrl];
    }else if (dTag == 1){
        url =  [NSString stringWithFormat:@"%@state_chart_621.html",RDefaultUrl];
    }else if (dTag == 2){
        url = [NSString stringWithFormat:@"%@state_table_631.html",RDefaultUrl];
    }else if (dTag == 3){
        url = [NSString stringWithFormat:@"%@state_table_632.html",RDefaultUrl];
    }
    if (![NSString isStringEmpty:url]){
        [_webView requestURL:url JSString:@""];
    }
}

-(void)requestKWView{
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
}


#pragma  mark -**  WKWebview **-
-(void)initView{
    CGSize vSize = self.view.size;
    if (_webView == nil) {
        _webView = [[DLQuoteWebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height - SegmentedH) configuration:nil VC:self];
        [self.view addSubview:_webView];
        
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
