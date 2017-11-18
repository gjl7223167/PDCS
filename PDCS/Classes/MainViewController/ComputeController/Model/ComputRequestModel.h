//
//  ComputRequestModel.h
//  PDCS
//
//  Created by iMac on 2017/10/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^returnObjct)(id obj);
@interface ComputRequestModel : NSObject

+(void)computRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obj;


@end
