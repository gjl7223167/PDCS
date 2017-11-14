//
//  NetError.h
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetError : NSObject
@property (nonatomic, assign)NSInteger      code;
@property (nonatomic, copy)NSString*        errStr;

- (instancetype)initWithError:(NSError*)error;
- (void)dataWithError:(NSError*)error;
@end
