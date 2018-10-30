//
//  PDUtility.m
//  PDCS
//
//  Created by Long on 2018/10/29.
//  Copyright © 2018 iMac. All rights reserved.
//

#import "PDUtility.h"
#import "AppDelegate.h"
#define ALTagWindowSubview                  1<<15


@implementation PDUtility

#pragma mark Remove window subview
+ (void)removeWindowSubview{
    for (UIView *view in [UIApplication sharedApplication].delegate.window.subviews) {
        if (view.tag==ALTagWindowSubview) {
            [view removeFromSuperview];
        }
    }
}
+ (void)addWindowSubview:(UIView *)view{
    view.tag = ALTagWindowSubview;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:view];
}

+ (BOOL)isViewOnMainWindow:(UIView *)view{
    for (UIView *subview in [UIApplication sharedApplication].delegate.window.subviews) {
        if ([subview isEqual:view]) {
            return YES;
        }
    }
    return NO;
}

+ (UIView *)isViewOfClassOnMainView:(__unsafe_unretained Class)className{
    for (UIView *subview in [UIApplication sharedApplication].delegate.window.subviews) {
        if ([subview isKindOfClass:className]) {
            return subview;
        }
    }
    return nil;
}

+(UIWindow *)windowsWithTopVC{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate.window;
}

+(UIView *)cusTitleView:(UINavigationItem *)item{
    CGFloat titleViewHeight = 44;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleViewHeight)];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
    titleView.autoresizesSubviews = YES;
    titleView.backgroundColor = [UIColor clearColor];
    CGRect leftViewbounds = item.leftBarButtonItem.customView.bounds;
    CGRect rightViewbounds = item.rightBarButtonItem.customView.bounds;
    CGRect frame;
    CGFloat maxWidth = leftViewbounds.size.width > rightViewbounds.size.width ? leftViewbounds.size.width : rightViewbounds.size.width;
    maxWidth += 20;//leftview 左右都有间隙
    frame = titleView.frame;
    frame.size.width = SCREEN_WIDTH - maxWidth * 2;
    titleView.frame = frame;
    return titleView;
}
@end
