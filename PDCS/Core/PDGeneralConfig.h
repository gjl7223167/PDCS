//
//  PDGeneralConfig.h
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#ifndef PDGeneralConfig_h
#define PDGeneralConfig_h

#define ISIOS7AndAbove  ([[UIDevice currentDevice].systemVersion integerValue] >= 7.0f)

#define SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)


//比例函数
#define kScreenWidthRatio           (SCREEN_WIDTH / 375.00000000f)
#define kScreenHeightRatio          (SCREEN_HEIGHT / 667.00000000f)
#define AdaW(x)                     (x * kScreenWidthRatio)
#define AdaH(x)                     (x * kScreenHeightRatio)

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define ISIOS7ORLATER (IOS_VERSION >= 7.0)


#define SCREEN_BOUNDS [UIScreen mainScreen].bounds


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_8X (IS_IPHONE && ((SCREEN_MAX_LENGTH > 736 && SCREEN_MAX_LENGTH<=812) || (IS_IPHONE && SCREEN_MAX_LENGTH > 812 && SCREEN_MAX_LENGTH<=896)))
// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define kUserDefault [NSUserDefaults standardUserDefaults]





#define WEAKSELF typeof(self) __weak weakSelf = self;

#define v(x) (MIN(SCREEN_HEIGHT, SCREEN_WIDTH) / 320 * x)

#define kTabbarH                  (IS_IPHONE_8X?83:49)
#define iphoneXBottomAreaHeight   (IS_IPHONE_8X?34:0)
#define iOSNavHeight              (IS_IPHONE_8X?88:64)


#define SegmentedH AdaH(34)



#endif /* PDGeneralConfig_h */
