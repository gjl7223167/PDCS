//
//  PDBlockConfig.h
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#ifndef PDBlockConfig_h
#define PDBlockConfig_h
/**
 *  按钮点击block
 *
 *  @param bTag 按钮的tag
 */
typedef void(^btnClickBlock)(NSInteger bTag);

/**
 *  返回操作
 *
 *  @param 空
 */
typedef void (^CancelBackBlock)(void);

#endif /* PDBlockConfig_h */
