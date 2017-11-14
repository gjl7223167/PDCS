//
//  UserModelTool.h
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@class UserModel;
@interface UserModelTool : NSObject
singleton_interface(UserModelTool)

-(void)storgaeObject:(UserModel * _Nonnull)messageObject;
-(UserModel * _Nullable)readMessageObject;
@end
