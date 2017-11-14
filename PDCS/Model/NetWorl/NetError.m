//
//  NetError.m
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "NetError.h"

@implementation NetError

- (instancetype)initWithError:(NSError*)error{
    self = [super init];
    if (self) {
        [self dataWithError:error];
    }
    return self;
}

- (void)dataWithError:(NSError*)error{
    self.code = error.code;
    self.code = error.code;
    NSString* str = @"网络异常,请稍后再试!";
    switch (error.code) {
        case -1001:
            str = @"网络连接超时,请稍后再试!";
            break;
        case -1009:
            str = @"本地网络出错,请检查本地网络!";
            break;
        case 202:
            str = @"设备失效,或者设备未注册";
            break;
        default:
            break;
    }
    self.errStr = str;
    
}

- (void)setCode:(NSInteger)code
{
    _code = code;
    if (code == 202) {

    }
}


@end
