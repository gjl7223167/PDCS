//
//  PDUtils.m
//  PDCS
//
//  Created by iMac on 2017/9/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDUtils.h"
#include <sys/sysctl.h>


@implementation PDUtils


+ (CGFloat)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (UIFont*)appFontWithSize:(CGFloat)fontSize
{

    UIFont* aFont = [UIFont systemFontOfSize:fontSize];//[UIFont fontWithName:@"FZLanTingHei-EL-GBK" size:fontSize];
    return aFont;
}

+ (CGFloat)textLengthWith:(NSString*)labText withFontSize:(CGFloat)fontSize
{
    if ([PDUtils getIOSVersion] < 7.0) {
        UIFont* font = [PDUtils appFontWithSize:fontSize];
        CGSize titleSize = [([PDUtils isAvailableStr:labText] ? labText : @"") sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        return titleSize.width;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([PDUtils isAvailableStr:labText] ? labText : @"") attributes:@{NSFontAttributeName : [PDUtils appFontWithSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize.width;
    }
}


+ (BOOL)isAvailableStr:(id)obj
{
    if (obj && ![obj isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

+ (UIColor*)colorWithInt:(NSInteger)colorValue{
    unsigned r = (colorValue&0x00ff0000)>>16;
    unsigned g = (colorValue&0x0000ff00)>>8;
    unsigned b = colorValue&0x000000ff;
    UIColor* color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    return color;
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+ (NSString*)uidStringForDevice
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor*)colorWithInt:(NSInteger)colorValue alpha:(CGFloat) a{
    unsigned r = (colorValue&0x00ff0000)>>16;
    unsigned g = (colorValue&0x0000ff00)>>8;
    unsigned b = colorValue&0x000000ff;
    UIColor* color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha: a];
    return color;
}


+ (UILabel*)createNormalLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect Fontwith:(int)fontsize{
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    [label1 setText:label];
    [label1 setFont:[PDUtils appFontWithSize:fontsize]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    label1.numberOfLines = 0;
    return label1;
}


+ (UILabel*) createLabel:(CGRect)rect with: (UIColor*)color with: (CGFloat) radius
{
    UILabel* lable = [[UILabel alloc]initWithFrame:rect];
    
    [lable setBackgroundColor:color];
    lable.layer.cornerRadius = radius;
    
    return lable;
}

//创建单行label，宽度根据字符串和字体大小自动适应
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize{
    UIFont* font = [PDUtils appFontWithSize:fontsize];
    //    CGSize titleSize = [label sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGSize titleSize = [PDUtils textSizeWithString:label withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [label1 setText:label];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    //    [label1 autorelease];
    return label1;
}

+ (CGSize)textSizeWithString:(NSString*)strText withFontSize:(CGFloat)fontSize
{
    if ([PDUtils getIOSVersion] < 7.0) {
        UIFont* font = [PDUtils appFontWithSize:fontSize];
        CGSize titleSize = [([PDUtils isAvailableStr:strText] ? strText : @"") sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        return titleSize;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([PDUtils isAvailableStr:strText] ? strText : @"") attributes:@{NSFontAttributeName : [PDUtils appFontWithSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize;
    }
}

+ (UILabel*)createNormalLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize{
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    [label1 setText:label];
    [label1 setFont:[PDUtils appFontWithSize:fontsize]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];

    return label1;
}

+(NSData *)baseWithData:(NSData *)data{
    NSString * tempStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData * tempData = [[NSData alloc] initWithBase64EncodedString:tempStr options:0];
    NSString * text = [[NSString alloc] initWithData:tempStr encoding:NSUTF8StringEncoding];
    
    return tempData;
}


+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize{
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    [label1 setText:label];
    [label1 setFont:[PDUtils appFontWithSize:fontsize]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    label1.numberOfLines = 1;
    //    [label1 autorelease];
    return label1;
}

@end
