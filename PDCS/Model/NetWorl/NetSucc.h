//
//  NetSucc.h
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetSucc : NSObject
@property (nonatomic, assign)NSInteger          code;
@property (nonatomic, copy)  NSString*          netMsg;
@property (nonatomic, strong)NSDictionary*      dataInfo;

- (instancetype)initWithData:(NSDictionary*)data;
- (void)dataWith:(NSDictionary*)data;
@end
