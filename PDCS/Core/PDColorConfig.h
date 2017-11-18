//
//  PDColorConfig.h
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#ifndef PDColorConfig_h
#define PDColorConfig_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kViewBgColor    UIColorFromRGB(0xf5f5f5)     //默认页面背景颜色

#define     KDfltBdColor    UIColorFromRGB(0xf1f1f1).CGColor
#define     KTSubmTClr       UIColorFromRGB(0x909090)


#define KNaviTitleClr   UIColorFromRGB(0x202020)     //导航栏有文字颜色
#define kBtmBarBgColor  UIColorFromRGB(0xffffff)     //底部导航背景颜色
#define kBarBgColor    UIColorFromRGB(0x3D8BFF)     //蓝色页面背景颜色
#define     KCurrColor      UIColorFromRGB(0xfc7822)

#define kLineColor      UIColorFromRGB(0xf1f1f1)     //分割线颜色


#define     KTMainTClr       UIColorFromRGB(0x3d3d3d)
#define     KMainTClr        UIColorFromRGB(0x202020)
#define     KTContTClr       UIColorFromRGB(0x999999)
#endif /* PDColorConfig_h */
