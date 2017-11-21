//
//  NSString+CheckNull.h
//  PDCS
//
//  Created by gyc on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckNull)

+(BOOL)isStringEmpty:(NSString*)string;

+(NSString*)todayString;
+(NSString*)monthString;
@end
