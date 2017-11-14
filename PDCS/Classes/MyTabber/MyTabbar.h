//
//  MyTabbar.h
//  MyTabbarDemo
//
//  Created by Visitor on 15/3/15.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabbar : UIView
+ (MyTabbar *)sharedMyTabbar;
@property(nonatomic,strong)UITabBarController *tabbarController;

- (void)selectAtIndex:(NSInteger)slctItem;

- (void)createTabbarController;

- (void)showRedDFor:(NSInteger)itemIndex;
- (void)hiddenRedDFor:(NSInteger)itemIndex;


@end




 






