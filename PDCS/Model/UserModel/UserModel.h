//
//  UserModel.h
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>


@property(nonatomic,copy)NSString * COMM;
@property(nonatomic,copy)NSString * HEAD_IMG_INFO,* NAME_CN;
@property(nonatomic,copy)NSString * ORG_FEH_ID,* ORG_FEH_NAME,* ORG_ID,* ORG_NAME, *ORG_WD_ID, * ORG_WD_NAME,*ORG_ZHH_ID ,* ORG_ZHH_NAME,*ORG_ZOH_ID,*ORG_ZOH_NAME;
@property(nonatomic,copy)NSString * ROLE_ID;
@property(nonatomic,copy)NSString * USER_ADDR,*USER_EMAIL,*USER_ID,*USER_PRIVILEGE,*USER_PRIVILEGE_NAME,*USER_SEX,*USER_TEL,*USER_TYP,*USER_TYP_NAME;
@property(nonatomic,copy)NSString * ec,*em;
/*
 存档
 */
@property(nonatomic,copy)NSString * aStatus;

@property (nonatomic,strong) NSMutableDictionary * userDictionary;
-(id)initWithDataModel:(NSDictionary *)dict;
/*
 
 JSON    __NSDictionaryI *    25 key/value pairs    0x0000000145ef5180
 [0]    (null)    @"USER_SEX" : @"1"
 [1]    (null)    @"ec" : @"3"
 [2]    (null)    @"ORG_WD_NAME" : @"PDCS银行网点8902"
 [3]    (null)    @"ORG_FEH_NAME" : @"PDCS银行分行10002"
 [4]    (null)    @"USER_TYP_NAME" : @"移动和后台用户"
 [5]    (null)    @"ORG_ZHH_NAME" : @"PDCS银行支行8901"
 [6]    (null)    @"NAME_CN" : @"何义"
 [7]    (null)    @"ORG_NAME" : @"PDCS银行网点8902"
 [8]    (null)    @"USER_PRIVILEGE" : @"1"
 [9]    (null)    @"ORG_WD_ID" : @"8902"
 [10]    (null)    @"ROLE_ID" : @"1,80"
 [11]    (null)    @"USER_TEL" : @"18605511921"
 [12]    (null)    @"USER_TYP" : @"0"
 [13]    (null)    @"ORG_ZOH_NAME" : @"PDCS银行"
 [14]    (null)    @"em" : @"当前登陆设备未绑定"
 [15]    (null)    @"ORG_FEH_ID" : @"10002"
 [16]    (null)    @"ORG_ZHH_ID" : @"8901"
 [17]    (null)    @"ORG_ZOH_ID" : @"10000"
 [18]    (null)    @"HEAD_IMG_INFO" : @"testtest"
 [19]    (null)    @"COMM" : @"何义备注"
 [20]    (null)    @"USER_EMAIL" : @"heyi2088@163.com"
 [21]    (null)    @"USER_ADDR" : @"红庙北里67"
 [22]    (null)    @"USER_ID" : @"heyi001"
 [23]    (null)    @"ORG_ID" : @"8902"
 [24]    (null)    @"USER_PRIVILEGE_NAME" : @"分行行长"
 
 */

@end
