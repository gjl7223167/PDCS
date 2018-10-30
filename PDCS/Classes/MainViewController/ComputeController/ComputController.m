//
//  ComputController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputController.h"
#import "PDCSSegmentedView.h"

#import "ComputSubController.h"
#import "ComputCenterController.h"

@interface ComputController ()<PDCSSegmentedViewDelegate>


@property(nonatomic,strong)PDCSSegmentedView * segmentedView;


@property(nonatomic,strong)NSMutableArray * crtAray;
@property(nonatomic,strong)UIViewController * currentVC;
@end

@implementation ComputController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cusTitleView];
    [self initCtrlers];
    [self addCVC];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/*
 初始化navView
 */
-(void )cusTitleView{
    UIView * cusTitle = [PDUtility cusTitleView:self.navigationItem];
    PDCSSegmentedView * segmentedView = [[PDCSSegmentedView alloc] initWithFrame:CGRectMake(67, 5.5, 240, 33)];
    [segmentedView setTitles:@[@"产品试算",@"中间业务"]];
    segmentedView.delegate = self;
    
    segmentedView.centerX = cusTitle.width / 2.0;
    [cusTitle addSubview:segmentedView];
    self.navigationItem.titleView = cusTitle;
}

#pragma  mark ----- subController
/*
 初始化子视图
 */
-(void)initCtrlers{
    
    if (self.crtAray == nil) {
        self.crtAray = [[NSMutableArray alloc] init];
    }
    
    ComputSubController * guaVC = [[ComputSubController alloc] init];
    ComputCenterController * centerVC = [[ComputCenterController alloc] init];
    [self.crtAray addObject:guaVC];
    [self.crtAray addObject:centerVC];
    
}

-(void)addCVC{
    for (int i = 0; i < _crtAray.count; i++) {
        UIViewController * VC;
        if (i == 0) {
            VC = (ComputSubController *)_crtAray[i];
        }else{
            VC = (ComputCenterController *)_crtAray[i];
        }
        VC.view.frame = self.view.bounds;
        [self addChildViewController:VC];
    }
    ComputSubController *Vc = _crtAray[0];
    [self.view addSubview:Vc.view];
    _currentVC = Vc;
    
}




/*
 nav分段显示方法
 */
- (void)xsSegmentedView:(PDCSSegmentedView *)XSSegmentedView selectTitleInteger:(NSInteger)integer {
    
    NSLog(@"select:%ld",(long)integer);
    UIViewController * Vc;
    if (integer ==0) {
        Vc = (ComputSubController*)_crtAray[0];
    }else if (integer == 1){
        Vc = (ComputCenterController*)_crtAray[1];
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
