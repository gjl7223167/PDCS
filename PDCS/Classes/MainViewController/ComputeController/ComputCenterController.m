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

#define     kPageCtrlH       45.0f

@interface ComputCenterController ()<ZJLPageControlDelegate>
@property (nonatomic, strong)ZJLPageControl * pageCtrl;

@property(nonatomic,strong)NSMutableArray * titleAry;
@property(nonatomic,strong)NSMutableArray * requestAry;

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
    
}

-(void)PageControView{
    CGRect pRect = CGRectMake(0, 0, SCREEN_WIDTH, kPageCtrlH);
    _pageCtrl = [[ZJLPageControl alloc]initWithFrame:pRect titles:_titleAry defaultP:0 isWidthChange:NO];
    _pageCtrl.pageDelegate = self;
    _pageCtrl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_pageCtrl];
}

-(void) pageIndexChanged:(NSInteger) pageIndex{
    [self showTableListAndData:pageIndex];
}
-(void)showTableListAndData:(NSInteger )dTag{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
