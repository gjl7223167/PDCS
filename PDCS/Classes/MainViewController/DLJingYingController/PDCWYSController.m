//
//  PDCWYSController.m
//  PDCS
//
//  Created by Long on 2017/11/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDCWYSController.h"
#import "ZJLPageControl.h"
#define     kPageCtrlH       45.0f

@interface PDCWYSController ()<ZJLPageControlDelegate>
@property (nonatomic, strong)ZJLPageControl * pageCtrl;
@property(nonatomic,strong)NSMutableArray * titleAry;
@end

@implementation PDCWYSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    
    
}

-(void)requestKWView{
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end