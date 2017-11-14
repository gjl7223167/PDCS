//
//  QuoteRequestModel.m
//  PDCS
//
//  Created by iMac on 2017/10/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "QuoteRequestModel.h"

@implementation QuoteRequestModel

+(void)quoteRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obj{
    [NetTool post:url params:Parame success:^(id JSON) {
        if (obj) {
            obj(JSON);
        }
    } failure:^(NetError *error) {
        [QuoteRequestModel showProgressHUD:error.errStr];
    }];
}


+(void)showProgressHUD:(NSString *)error{
    [SVProgressHUD showImage:nil status:error ];
}



@end
