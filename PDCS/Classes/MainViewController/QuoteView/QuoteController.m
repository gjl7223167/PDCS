//
//  QuoteController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "QuoteController.h"
#import "PDCSSegmentedView.h"
#import "QuoteSubGPController.h"
#import "QuoteSubSCController.h"
#import "QuoteSubFTPController.h"


@interface QuoteController ()<PDCSSegmentedViewDelegate>

@property(nonatomic,strong)PDCSSegmentedView * segmentedView;
@property(nonatomic,strong)NSMutableArray * crtAray;
@property(nonatomic,strong)UIViewController * currentVC;
@end

@implementation QuoteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.segmentedView;
    [self initCtrlers];
    [self addCVC];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self showRightBtn];
    [self rightBtnTitleWith:@"刷新"];
}

-(PDCSSegmentedView *)segmentedView{
    PDCSSegmentedView * segmentedView = [[PDCSSegmentedView alloc] initWithFrame:CGRectMake(67, 5.5, 240, 33)];
        [segmentedView setTitles:@[@"挂牌利率",@"市场利率",@"FTP利率"]];
    segmentedView.delegate = self;
    return segmentedView;
}

-(void)requestData{
    
}


-(void)initCtrlers{
    if (self.crtAray == nil) {
        self.crtAray = [NSMutableArray arrayWithCapacity:3];
    }
    QuoteSubGPController * quoteGuaVC = [[QuoteSubGPController alloc] init];
    quoteGuaVC.loadType = QupoteLoadGuaType;
    QuoteSubSCController * quoteShiVC = [[QuoteSubSCController alloc] init];
    quoteShiVC.loadType = QupoteLoadShiType;
    QuoteSubFTPController * quoteFtpVC = [[QuoteSubFTPController alloc] init];
    quoteFtpVC.loadType = QupoteLoadFtpType;
    
    [_crtAray addObject:quoteGuaVC];
    [_crtAray addObject:quoteShiVC];
    [_crtAray addObject:quoteFtpVC];
}


-(void)addCVC{
    for (int i = 0; i < _crtAray.count; i++) {
        UIViewController * Vc;
        if (i ==0) {
          Vc = (QuoteSubGPController*)_crtAray[i];
        }else if (i == 1){
            Vc = (QuoteSubSCController*)_crtAray[i];
        }else if (i == 2){
            Vc = (QuoteSubFTPController*)_crtAray[i];
        }
        
        Vc.view.frame = self.contentView.bounds;
        [self addChildViewController:Vc];
       
    }
    QuoteSubGPController *Vc = _crtAray[0];
     [self.view addSubview:Vc.view];
    _currentVC = Vc;
}




-(void)rightBtnClicked:(id)sender{
//    NSURL * urlStr= [NSURL URLWithString:RDefaultUrl];
//    NSURLRequest * request = [NSURLRequest requestWithURL:urlStr];
//    if (_webView) {
//        [_webView loadRequest:request];
//    }
    
}

/*
 nav分段显示方法
 */
- (void)xsSegmentedView:(PDCSSegmentedView *)XSSegmentedView selectTitleInteger:(NSInteger)integer {
    
    NSLog(@"select:%ld",(long)integer);
    UIViewController * Vc;
    if (integer ==0) {
        Vc = (QuoteSubGPController*)_crtAray[0];
    }else if (integer == 1){
        Vc = (QuoteSubSCController*)_crtAray[1];
    }else if (integer == 2){
        Vc = (QuoteSubFTPController*)_crtAray[2];
    }
    [self changeControllerFromOldController:_currentVC toNewController:Vc];
    
}

- (BOOL)xsSegmentedView:(PDCSSegmentedView *)XSSegmentedView didSelectTitleInteger:(NSInteger)integer {
    
    NSLog(@"didSelect:%ld",(long)integer);
    
    return YES;
}



- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{

    [self addChildViewController:newController];
    /**
     *  切换ViewController
     */
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        
        
    } completion:^(BOOL finished) {
        
        if (finished) {

            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
            [newController didMoveToParentViewController:self];
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
            _currentVC = newController;

        }else
        {
            _currentVC = oldController;
        }
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
