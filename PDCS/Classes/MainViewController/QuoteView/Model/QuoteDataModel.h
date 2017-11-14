//
//  QuoteDataModel.h
//  PDCS
//
//  Created by iMac on 2017/10/25.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteDataModel : NSObject
//支行  资产  同业  人民币
@property(nonatomic,strong)NSString * bankType,* ZCType,* TYType,* RMBType;
@end
