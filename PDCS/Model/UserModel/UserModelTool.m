//
//  UserModelTool.m
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "UserModelTool.h"
#define AddressInfosPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Achiver"]

@implementation UserModelTool
singleton_implementation(UserModelTool)
-(instancetype)init{
    self = [super init];
    if (self) {
        [self createFolder];
    }
    return self;
}
- (void)createFolder
{
    NSString * path = AddressInfosPath;
    BOOL isDirectory;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory])
    {
        return;
    }else
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    }
}

-(void)storgaeObject:(UserModel * _Nonnull)messageObject
{
    NSString * path = [AddressInfosPath stringByAppendingPathComponent:@"messageObject.achiver"];
    [NSKeyedArchiver archiveRootObject:messageObject toFile:path];
}


-(UserModel * _Nullable)readMessageObject
{
    //拼接路径
    NSString * path = [AddressInfosPath stringByAppendingPathComponent:@"messageObject.achiver"];
    
    //开始解码获取
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}





@end
