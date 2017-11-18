//
//  NSString+CheckNull.m
//  PDCS
//
//  Created by gyc on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "NSString+CheckNull.h"

@implementation NSString (CheckNull)
+(BOOL)isStringEmpty:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
