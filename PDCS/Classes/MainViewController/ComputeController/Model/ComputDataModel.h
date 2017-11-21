//
//  ComputDataModel.h
//  PDCS
//
//  Created by Long on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComputRequestModel.h"

typedef void (^returnObjct)(id obj);
@interface ComputDataModel : NSObject


+(NSMutableDictionary *)initWithDictModel;


+(void)requestComputModel:(NSIndexPath *)indexPath ParamDic:(NSDictionary *)info blok:(void(^)(NSDictionary * dict))dictAndary;
    


/*业务模块*/
+(id)YWMKRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obJ;

/*业务类型*/
+(id)YWLXRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obJ;
@end
