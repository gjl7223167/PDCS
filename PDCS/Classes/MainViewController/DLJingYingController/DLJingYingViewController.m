//
//  DLJingYingViewController.m
//  PDCS
//
//  Created by gyc on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "DLJingYingViewController.h"
#import "PDJYYSController.h"
#import "PDCWYSController.h"
#import "PDCSSegmentedView.h"

@interface DLJingYingViewController ()<PDCSSegmentedViewDelegate>
@property(nonatomic,strong)PDCSSegmentedView * segmentedView;
@property(nonatomic,strong)NSMutableArray * crtAray;
@property(nonatomic,strong)UIViewController * currentVC;
@end

@implementation DLJingYingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.segmentedView;
    [self initCtrlers];
    [self addCVC];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initCtrlers{
    if (self.crtAray == nil) {
        self.crtAray = [NSMutableArray arrayWithCapacity:3];
    }
    PDJYYSController * jVC = [[PDJYYSController alloc] init];
//    quoteGuaVC.loadType = QupoteLoadGuaType;
    PDCWYSController * cVC = [[PDCWYSController alloc] init];
//    quoteShiVC.loadType = QupoteLoadShiType;

    
    [_crtAray addObject:jVC];
    [_crtAray addObject:cVC];
}


-(void)addCVC{
    for (int i = 0; i < _crtAray.count; i++) {
        UIViewController * Vc;
        if (i ==0) {
            Vc = (PDJYYSController*)_crtAray[i];
        }else if (i == 1){
            Vc = (PDCWYSController*)_crtAray[i];
        }
        
        Vc.view.frame = self.contentView.bounds;
        [self addChildViewController:Vc];
        
    }
    PDJYYSController *Vc = _crtAray[0];
    [self.view addSubview:Vc.view];
    _currentVC = Vc;
}


-(PDCSSegmentedView *)segmentedView{
    PDCSSegmentedView * segmentedView = [[PDCSSegmentedView alloc] initWithFrame:CGRectMake(67, 5.5, 240, 33)];
    [segmentedView setTitles:@[@"经营试算",@"财务试算"]];
    segmentedView.centerX = SCREEN_WIDTH / 2.0;
    segmentedView.delegate = self;
    return segmentedView;
}




/*
 nav分段显示方法
 */
- (void)xsSegmentedView:(PDCSSegmentedView *)XSSegmentedView selectTitleInteger:(NSInteger)integer {
    
    NSLog(@"select:%ld",(long)integer);
    UIViewController * Vc;
    if (integer ==0) {
        Vc = (PDJYYSController*)_crtAray[0];
    }else if (integer == 1){
        Vc = (PDCWYSController*)_crtAray[1];
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
        }else{
            _currentVC = oldController;
        }
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
