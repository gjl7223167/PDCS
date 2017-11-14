//
//  NetSucc.m
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "NetSucc.h"

@implementation NetSucc
- (instancetype)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        [self dataWith:data];
    }
    return self;
}

- (void)dataWith:(NSDictionary*)data
{
    
    self.code       = [data[@"ec"] integerValue];
    self.netMsg     = data[@"em"];
//    self.code       = [data[@"status"] integerValue];
//    self.netMsg     = data[@"info"];
//    self.dataInfo   = data;
}
@end
