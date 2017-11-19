//
//  PDJYZKModel.m
//  PDCS
//
//  Created by Long on 2017/11/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDJYZKModel.h"

@implementation PDJYZKModel
+(void)computRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obj{
    [NetTool post:url params:Parame success:^(id JSON) {
        if (obj) {
            obj(JSON);
        }
    } failure:^(NetError *error) {
        [PDJYZKModel showProgressHUD:error.errStr];
    }];
}

+(void)showProgressHUD:(NSString *)error{
    [SVProgressHUD showImage:nil status:error ];
}


@end
