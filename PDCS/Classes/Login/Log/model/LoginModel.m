//
//  LoginModel.m
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(NSString *)logWithInfoName:(NSString *)name PassWord:(NSString *)password{
    
    if (![PDUtils isAvailableStr:name]) {
        return @"请输入用户名";
    }else if (![PDUtils isAvailableStr:password]){
        return @"请输入密码";
    }
    return nil;
}

@end
