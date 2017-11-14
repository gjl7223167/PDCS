//
//  NetApiClient.h
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "AFHTTPSessionManager.h"




@interface NetApiClient : AFHTTPSessionManager

+(instancetype)sharedClient;
+(instancetype)sharedFileClient;

@end
