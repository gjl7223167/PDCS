//
//  LoginModel.m
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(NSString *)logWithInfoName:(NSString *)name PassWord:(NSString *)password Validation:(NSString *)validat{
    
    if (![PDUtils isAvailableStr:name]) {
        return @"请输入用户名";
    }else if (![PDUtils isAvailableStr:password]){
        return @"请输入密码";
    }else if (![PDUtils isAvailableStr:validat]){
        return @"请输入验证码";
    }
    return nil;
}
@end
