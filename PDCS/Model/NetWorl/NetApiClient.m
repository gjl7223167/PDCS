//
//  NetApiClient.m
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "NetApiClient.h"

@implementation NetApiClient
+(instancetype)sharedClient{
    static NetApiClient * _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetApiClient alloc] initWithBaseURL:[NSURL URLWithString:KBaseUrl]];
    });
    
    return _sharedClient;
}

+(instancetype)sharedFileClient{
    static NetApiClient * _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetApiClient alloc] initWithBaseURL:[NSURL URLWithString:KBaseFileUrl]];
    });
    return _sharedClient;
}

@end
