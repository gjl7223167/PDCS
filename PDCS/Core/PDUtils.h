//
//  PDUtils.h
//  PDCS
//
//  Created by iMac on 2017/9/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
@interface PDUtils : NSObject

/*
获取系统版本
 */
+ (CGFloat)getIOSVersion;

/*
 是否为空
 */
+ (BOOL)isAvailableStr:(id)obj;
/*
 获取设备信息
 */
+ (NSString *)getCurrentDeviceModel;
+ (NSString*)uidStringForDevice;

/*
 字体UIFont
*/
+ (UIFont*)appFontWithSize:(CGFloat)fontSize;

/*
 字体宽度
 */
+ (CGFloat)textLengthWith:(NSString*)labText withFontSize:(CGFloat)fontSize;
/*
 R G B
 */
+ (UIColor*)colorWithInt:(NSInteger)colorValue;

/*
 图片背景
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIColor*)colorWithInt:(NSInteger)colorValue alpha:(CGFloat) a;

/*
 字体适配
 */
+ (UILabel*)createNormalLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect Fontwith:(int)fontsize;
+ (UILabel*) createLabel:(CGRect)rect with: (UIColor*)color with: (CGFloat) radius;
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize;
//创建单行 自适应
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize;
+ (CGSize)textSizeWithString:(NSString*)strText withFontSize:(CGFloat)fontSize;
+ (UILabel*)createNormalLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize;
//解析data
+(NSData *)baseWithData:(NSData *)data;
@end
