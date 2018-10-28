//
//  PDFSViewController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDFSViewController.h"

@interface PDFSViewController ()

@end

@implementation PDFSViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = !self.showNavigationBar;
    
    // Do any additional setup after loading the view.
    if (ISIOS7AndAbove) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    CGSize size = self.view.frame.size;
    CGRect cFrame = CGRectMake(0, 0, SCREEN_WIDTH, size.height);
    self.contentView = [[UIView alloc]initWithFrame:cFrame];
    [self.contentView setBackgroundColor:kViewBgColor];
    [self.view addSubview:self.contentView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.toolbarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBarHidden = !self.showNavigationBar;
    CGSize size = self.view.frame.size;
    self.contentView.size = CGSizeMake(SCREEN_WIDTH, size.height);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
}


- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning
{
    //    [[SDImageCache sharedImageCache] clearMemory];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
