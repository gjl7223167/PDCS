//
//  PDUtility.h
//  PDCS
//
//  Created by Long on 2018/10/29.
//  Copyright © 2018 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDUtility : NSObject
#pragma mark - Window
+ (void)addWindowSubview:(UIView *)view;
+ (void)removeWindowSubview;
+ (BOOL)isViewOnMainWindow:(UIView *)view;
+ (UIView *)isViewOfClassOnMainView:(__unsafe_unretained Class)className;
+ (UIWindow *)windowsWithTopVC;
+(UIView *)cusTitleView:(UINavigationItem *)item;
@end

NS_ASSUME_NONNULL_END
