//
//  PDNavigationController.h
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define IOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later !(IOSVersion < 7.0)

@interface PDNavigationController : UINavigationController


- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition;
- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;
@end
