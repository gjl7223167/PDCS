//
//  ComputSubController.m
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputSubController.h"
#import "ComputRequestModel.h"

#import "ZJLPageControl.h"
#import "ComputTableView.h"


#define     kPageCtrlH       45.0f

@interface ComputSubController ()<ZJLPageControlDelegate>
@property(nonatomic,strong)NSArray * titlesAry;
@property(nonatomic,assign)NSInteger        toIndex;
@property (nonatomic, strong)ZJLPageControl * pageCtrl;
@property(nonatomic,strong)ComputTableView *tableView;


@property(nonatomic,strong)NSMutableArray * titleAry;
@end

@implementation ComputSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     [self initView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWithMethod];
   
}

-(void)requestWithMethod{
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    
    WEAKSELF
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    [ComputRequestModel computRequest:PDCR_CPSSType_Url Parameter:dict Obj:^(id obj) {
        [weakSelf aryAndDict:obj];
    }];
}


-(void)aryAndDict:(id)obj{
    if (_titleAry == nil) {
        _titleAry = [NSMutableArray arrayWithCapacity:5];
    }
    NSArray * ary = obj[@"LIST"];
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_titleAry addObject:obj[@"NAME"]];
    }];
    [self PageControView];
}


-(void)initView{

}

-(void)PageControView{
    CGRect pRect = CGRectMake(0, 0, SCREEN_WIDTH, kPageCtrlH);
    _pageCtrl = [[ZJLPageControl alloc]initWithFrame:pRect titles:_titleAry defaultP:_toIndex isWidthChange:NO];
    _pageCtrl.pageDelegate = self;
    _pageCtrl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_pageCtrl];
}

-(void) pageIndexChanged:(NSInteger) pageIndex{
    [self showTableListAndData:nil];
}


-(void)showTableListAndData:(id)info{
    
    if (self.tableView == nil) {
        WEAKSELF
        self.tableView = [[ComputTableView alloc] initWithFrame:CGRectMake(0, kPageCtrlH, SCREEN_WIDTH, self.contentView.height - kPageCtrlH - 49
                                                                           ) InfoData:nil];

//        self.tableListView.endBlack = ^(NSString *number, NSString *dicStr, NSInteger selectIndex) {
//            if (ctype == selectGPZCtype) {
//                cSelectIndex = selectIndex;
//            }
//
//            NSLog(@"%@  -- %@  ---- %ld",number,dicStr,selectIndex);
//        };
//
//        self.tableListView.cancelBlock = ^(){
//            [weakSelf tableListCancael];
//        };
        
        [self.contentView addSubview:self.tableView];
        
    }else{
//        [self.tableListView updata:info AndType:type];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
