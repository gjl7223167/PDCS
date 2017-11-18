//
//  MyTabbar.m
//  MyTabbarDemo
//
//  Created by Visitor on 15/3/15.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import "MyTabbar.h"

#import "MyController.h"
#import "QuoteController.h"
#import "ComputController.h"
#import "DLJingYingViewController.h"
#import "PDNavigationController.h"

#define BUTTON_HEIGHT 1
#define LABEL_HEIGHT 0.2

@implementation MyTabbar
{
    // *_tabbarController;
    UIButton *_selectedBtn;
    UILabel *_selectedLabel;
    UIView  *_selectedView;
}
static MyTabbar *_sharedMyTabbar;
+ (MyTabbar *)sharedMyTabbar
{
    if(!_sharedMyTabbar)
    {
        _sharedMyTabbar = [[MyTabbar alloc] init];
    }
    return _sharedMyTabbar;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - mainFunc

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTabbarController];
        [self addNtfication];
    }
    return self;
}

- (void)addNtfication
{
//    [kNotificactionCenter addObserver:self selector:@selector(notifcationDeal) name:AppNumCountChangeNtfCation object:nil];
}

// 创建系统tabbar
- (void)createTabbarController
{
    QuoteController * mvc = [[QuoteController alloc] init];
//    mvc.title = @"主页1";
    PDNavigationController *navi1=[[PDNavigationController alloc]initWithRootViewController:mvc];
    
    ComputController *store=[[ComputController alloc]init];
    PDNavigationController *storNavi=[[PDNavigationController alloc]initWithRootViewController:store];
//    store.title=@"产品试算";
    
    DLJingYingViewController *jy=[[DLJingYingViewController alloc]init];
    PDNavigationController *jyn=[[PDNavigationController alloc]initWithRootViewController:jy];
    

    MyController *person=[[MyController alloc]init];
//    person.title=@"我的";
    PDNavigationController *naviPro=[[PDNavigationController alloc]initWithRootViewController:person];
    _tabbarController = [[UITabBarController alloc] init];

    NSMutableArray *nsvc=[[NSMutableArray alloc]initWithObjects:navi1,storNavi,jyn,naviPro, nil];
    _tabbarController.viewControllers = nsvc;
    [self createMyTabbar];
    
}

// 创建自定义tabbar
- (void)createMyTabbar
{
    // plist文件读取成字典
    NSDictionary *plistDict = [self loadTabbarPlist];
    // 创建背景图
    [self createBgImageWithImageName:[plistDict objectForKey:@"bgImageName"]];
    // 创建item
    for(NSInteger i=0;i<((NSArray *)[plistDict objectForKey:@"Items"]).count;i++)
    {
        [self createItemWithItemDict:[((NSArray *)[plistDict objectForKey:@"Items"]) objectAtIndex:i] andItemIndex:i andItemCount:((NSArray *)[plistDict objectForKey:@"Items"]).count];
    }
    
    
}

#pragma mark - subFunc
- (NSDictionary *)loadTabbarPlist
{
    NSString *path = [NSString stringWithFormat:@"%@/Tabbar.plist",[[NSBundle mainBundle] resourcePath]];
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    return plistDict;
}

- (void)createBgImageWithImageName:(NSString *)bgImageName;
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImageName]];
    imageView.frame = _tabbarController.tabBar.bounds;
    [_tabbarController.tabBar addSubview:imageView];
    
//    [_tabbarController.tabBar setClipsToBounds:YES];
    
//    如果我们的高度是高于49的话，可以使用
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6)
    {
        [[UITabBar appearance] setShadowImage:[PDUtils imageWithColor:[PDUtils colorWithInt:0x0 alpha:.3] size:CGSizeMake(SCREEN_WIDTH, 0.3)]];
    }
    

    
}

- (void)createItemWithItemDict:(NSDictionary *)itemDict andItemIndex:(NSInteger)itemIndex andItemCount:(NSInteger)itemCount;
{
    CGRect rect = _tabbarController.tabBar.bounds;
    _tabbarController.tabBar.layer.borderWidth = 0.60;
    _tabbarController.tabBar.layer.borderColor = kBtmBarBgColor.CGColor;
    
    UIView *itemView = [[UIView alloc] init];
    itemView.backgroundColor = kBtmBarBgColor;
    itemView.frame = CGRectMake(itemIndex*rect.size.width/itemCount, 0, rect.size.width/itemCount, rect.size.height);
    [_tabbarController.tabBar addSubview:itemView];
    
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, itemView.frame.size.width, itemView.frame.size.height*BUTTON_HEIGHT - 5);
    [btn setImage:[UIImage imageNamed:[itemDict objectForKey:@"imageName"]]  forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[itemDict objectForKey:@"imageName"]]  forState:UIControlStateHighlighted];
    [btn setImage: [UIImage imageNamed:[itemDict objectForKey:@"selectImageName"]] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
     btn.imageEdgeInsets = UIEdgeInsetsMake(5,20,13,20);
    
    btn.tag = 10000 +itemIndex;
    [itemView addSubview:btn];
    itemView.tag = 10000 + itemIndex;
    
    // 标签
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, btn.frame.size.height-10, btn.frame.size.width, itemView.frame.size.height*LABEL_HEIGHT);
    label.text = [itemDict objectForKey:@"title"];
    label.textColor = [PDUtils colorWithInt:0x949494];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [PDUtils appFontWithSize:10];
    [itemView addSubview:label];
    
    UIView* redD = [[UIView alloc]initWithFrame:CGRectMake(itemView.width / 2.0 + KDfltGap* 1.1, KDfltGap - 4, 8, 8)];
    redD.tag                   = 10011;
    redD.backgroundColor       = UIColorFromRGB(0xf91a24);
    redD.layer.cornerRadius    = 4.0f;
    redD.layer.masksToBounds   = YES;
    [itemView addSubview:redD];
    redD.hidden = YES;
    // 设置index为0的默认选中
    if(itemIndex == 0)
    {
        btn.selected = YES;
        _selectedBtn = btn;
        label.textColor = kBarBgColor;
        _selectedLabel = label;
        itemView.backgroundColor = UIColorFromRGB(0xfaf9f9);
        _selectedView = itemView;
    }

}

- (void)selectAtIndex:(NSInteger)slctItem
{
    if (_selectedBtn.tag == slctItem + 10000) {
        return;
    }else{
        NSArray* vArray = [_tabbarController.tabBar subviews];
        for (UIView* view in vArray) {
            if (view.tag == 10000 + slctItem) {
                NSArray* sArray = [view subviews];
                for (UIView* sView in sArray) {
                    if ([sView isKindOfClass:[UIButton class]]) {
                        UIButton* btn = (UIButton*)sView;
                        [self btnClick:btn];
                    }
                }
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn
{
    if ([_selectedBtn isEqual:btn]) {
        return;
    }
    // 按钮变色
    _selectedBtn.selected = NO;
    _selectedView.backgroundColor = kBtmBarBgColor;
    _selectedLabel.textColor = [PDUtils colorWithInt:0x949494];
    btn.selected = YES;
    _selectedBtn = btn;
    // label变色
    ((UILabel *)[btn.superview.subviews objectAtIndex:1]).textColor = kBarBgColor;
    _selectedLabel = ((UILabel *)[btn.superview.subviews objectAtIndex:1]);
    _selectedView = (UIView*)btn.superview;
    _selectedView.backgroundColor = UIColorFromRGB(0xfaf9f9);
    _tabbarController.selectedIndex = btn.tag -10000;
    
}

//- (void)notifcationDeal
//{
//    HBGlobalModel* gModel = [HBGlobalModel sharedHBGlobalModel];
//    if (gModel.isLogin) {
//        HBNumModel* nModel = [HBNumModel sharedHBNumModel];
//        if (nModel.allCt > 0) {
//            [self showRedDFor:2];
//        }else{
//            [self hiddenRedDFor:2];
//        }
//    }else{
//        [self hiddenRedDFor:2];
//    }
//}

- (void)showRedDFor:(NSInteger)itemIndex
{
    UIView * itemView = [_tabbarController.tabBar viewWithTag:10000 + itemIndex];
    UIView* redD = [itemView viewWithTag:10011];
    redD.hidden = NO;
}

- (void)hiddenRedDFor:(NSInteger)itemIndex
{
    UIView * itemView = [_tabbarController.tabBar viewWithTag:10000 + itemIndex];
    UIView* redD = [itemView viewWithTag:10011];
    redD.hidden = YES;
}

@end
