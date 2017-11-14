//
//  AppDelegate.h
//  PDCS
//
//  Created by iMac on 2017/9/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabbar.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate*)getAppDelegate;
@end

