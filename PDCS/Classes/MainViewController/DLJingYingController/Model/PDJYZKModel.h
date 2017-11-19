//
//  PDJYZKModel.h
//  PDCS
//
//  Created by Long on 2017/11/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^returnObjct)(id obj);

@interface PDJYZKModel : NSObject

+(void)requestComputModel:(NSInteger )index ParamDic:(NSDictionary *)info blok:(void(^)(NSDictionary * dict))dictAndary;

+(void)computRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obj;
@end
