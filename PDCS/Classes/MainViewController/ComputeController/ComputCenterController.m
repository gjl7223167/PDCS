//
//  ComputCenterController.m
//  PDCS
//
//  Created by iMac on 2017/10/28.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputCenterController.h"
#import "ZJLPageControl.h"
#import "ComputRequestModel.h"
#import "DLQuoteWebView.h"
#define     kPageCtrlH       45.0f

@interface ComputCenterController ()<ZJLPageControlDelegate>
@property (nonatomic, strong)ZJLPageControl * pageCtrl;

@property(nonatomic,strong)NSMutableArray * titleAry;
@property(nonatomic,strong)NSMutableArray * requestAry;

@property (nonatomic,strong) DLQuoteWebView * webView;

@property (nonatomic,copy) NSString * timeString;
@property (nonatomic,copy) NSString * pageString;
@property (nonatomic,copy) NSString * typeString;

@end

@implementation ComputCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestWithMethod];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)requestWithMethod{
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    
    WEAKSELF
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [dict setObject:@"1" forKey:@"PRD_TYPE"];
    
    
    [ComputRequestModel computRequest:PDCR_CPZJYWType_Url Parameter:dict Obj:^(id obj) {
        
        [weakSelf aryAndDict:obj];
    }];

}


-(void)aryAndDict:(id)obj{
    if (_titleAry == nil) {
        _titleAry = [NSMutableArray arrayWithCapacity:5];
        _requestAry = [NSMutableArray arrayWithCapacity:5];
    }else{
        [_titleAry removeAllObjects];
        [_requestAry removeAllObjects];
    }
    
    NSArray * ary = obj[@"LIST"];
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [_titleAry addObject:obj[@"PRD_TYPE_NAME"]];
        [_requestAry addObject:obj];
    }];
    
    [self PageControView];
    [self initView];
}

-(void)PageControView{
    CGRect pRect = CGRectMake(0, 0, SCREEN_WIDTH, kPageCtrlH);
    _pageCtrl = [[ZJLPageControl alloc]initWithFrame:pRect titles:_titleAry defaultP:0 isWidthChange:YES];
    _pageCtrl.pageDelegate = self;
    _pageCtrl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageCtrl];
}

-(void) pageIndexChanged:(NSInteger) pageIndex{
    [self showTableListAndData:pageIndex];
}
-(void)showTableListAndData:(NSInteger )dTag{
    if (_requestAry.count > dTag){
        
         NSDictionary  * dic = _requestAry[dTag];
        if (dic[@"PRD_TYPE"]){
            NSString * typeString = [NSString stringWithFormat:@"%@",dic[@"PRD_TYPE"]];
            self.timeString = [NSString todayString];
            self.typeString = typeString;
            self.pageString = @"1";
              [self.webView requestJSString:[NSString stringWithFormat:@"APPLoadData('%@', '%@', '%@')",self.pageString,self.timeString,self.typeString]];
        }
    }
}


-(void)initView{
    CGSize vSize = self.view.size;
    if (_webView == nil) {
    
        
        _webView = [[DLQuoteWebView alloc] initWithFrame:CGRectMake(0, SegmentedH, vSize.width, vSize.height - SegmentedH) configuration:nil VC:self];
        [self.view addSubview:_webView];
        
        NSString * today  = [NSString todayString];
        self.timeString = today;
        self.typeString = @"01";
        self.pageString = @"2";
        [_webView requestURL:@"http://lanshaoqi.cn/business_table.html" JSString:[NSString stringWithFormat:@"APPLoadData('%@', '%@', '%@')",self.pageString,self.timeString,self.typeString]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
