//
//  UserModel.m
//  PDCS
//
//  Created by iMac on 2017/10/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import  "UserModel.h"

@implementation UserModel

-(id)initWithDataModel:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        if (dict){
            self.userDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
        }
        self.COMM                   =  dict[@"COMM"];
        self.HEAD_IMG_INFO          =  dict[@"HEAD_IMG_INFO"];
        self.NAME_CN                =  dict[@"NAME_CN"];
        self.ORG_FEH_ID             =  dict[@"ORG_FEH_ID"];
        self.ORG_FEH_NAME           =  dict[@"ORG_FEH_NAME"];
        
        self.ORG_ID                 =  dict[@"ORG_ID"];
        self.ORG_NAME               =  dict[@"ORG_NAME"];
        self.ORG_WD_ID              =  dict[@"ORG_WD_ID"];
        self.ORG_WD_NAME            =  dict[@"ORG_WD_NAME"];
        self.ORG_ZHH_ID             =  dict[@"ORG_ZHH_ID"];
        
        self.ORG_ZHH_NAME           =  dict[@"ORG_ZHH_NAME"];
        self.ORG_ZOH_ID             =  dict[@"ORG_ZOH_ID"];
        self.ORG_ZOH_NAME           =  dict[@"ORG_ZOH_NAME"];
        self.ROLE_ID                =  dict[@"ROLE_ID"];
        self.USER_ADDR              =  dict[@"USER_ADDR"];
        
        self.USER_EMAIL             =  dict[@"USER_EMAIL"];
        self.USER_ID                =  dict[@"USER_ID"];
        self.USER_PRIVILEGE         =  dict[@"USER_PRIVILEGE"];
        self.USER_PRIVILEGE_NAME    =  dict[@"USER_PRIVILEGE_NAME"];
        self.USER_SEX               =  dict[@"USER_SEX"];
        
        self.USER_TEL               =  dict[@"USER_TEL"];
        self.USER_TYP               =  dict[@"USER_TYP"];
        self.USER_TYP_NAME          =  dict[@"USER_TYP_NAME"];
        self.ec                     =  dict[@"ec"];
        self.em                     =  dict[@"em"];
    }
    return self;

}



-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_COMM                      forKey:@"COMM"];
    [aCoder encodeObject:_HEAD_IMG_INFO             forKey:@"HEAD_IMG_INFO"];
    [aCoder encodeObject:_NAME_CN                   forKey:@"NAME_CN"];
    [aCoder encodeObject:_ORG_FEH_ID                forKey:@"ORG_FEH_ID"];
    [aCoder encodeObject:_ORG_FEH_NAME              forKey:@"ORG_FEH_NAME"];
    
    [aCoder encodeObject:_ORG_ID                    forKey:@"ORG_ID"];
    [aCoder encodeObject:_ORG_NAME                  forKey:@"ORG_NAME"];
    [aCoder encodeObject:_ORG_WD_ID                 forKey:@"ORG_WD_ID"];
    [aCoder encodeObject:_ORG_WD_NAME               forKey:@"ORG_WD_NAME "];
    [aCoder encodeObject:_ORG_ZHH_ID                forKey:@"ORG_ZHH_ID"];
    
    [aCoder encodeObject:_ORG_ZHH_NAME              forKey:@"ORG_ZHH_NAME"];
    [aCoder encodeObject:_ORG_ZOH_ID                forKey:@"ORG_ZOH_ID"];
    [aCoder encodeObject:_ORG_ZOH_NAME              forKey:@"ORG_ZOH_NAME"];
    [aCoder encodeObject:_ROLE_ID                   forKey:@"ROLE_ID"];
    [aCoder encodeObject:_USER_ADDR                 forKey:@"USER_ADDR"];
    
    [aCoder encodeObject:_USER_EMAIL                forKey:@"USER_EMAIL"];
    [aCoder encodeObject:_USER_ID                   forKey:@"USER_ID"];
    [aCoder encodeObject:_USER_PRIVILEGE            forKey:@"USER_PRIVILEGE"];
    [aCoder encodeObject:_USER_PRIVILEGE_NAME       forKey:@"USER_PRIVILEGE_NAME"];
    [aCoder encodeObject:_USER_SEX                  forKey:@"USER_SEX"];
    
    [aCoder encodeObject:_USER_TEL                  forKey:@"USER_TEL"];
    [aCoder encodeObject:_USER_TYP                  forKey:@"USER_TYP"];
    [aCoder encodeObject:_USER_TYP_NAME             forKey:@"USER_TYP_NAME"];
    [aCoder encodeObject:_ec                        forKey:@"ec"];
    [aCoder encodeObject:_em                        forKey:@"em"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        if (!self.userDictionary)
            self.userDictionary = [NSMutableDictionary dictionary];
        
        self.COMM                   =  [aDecoder decodeObjectForKey:@"COMM"];
        [self.userDictionary setValue:self.COMM forKey:@"COMM"];
        
        self.HEAD_IMG_INFO          =  [aDecoder decodeObjectForKey:@"HEAD_IMG_INFO"];
//        [self.userDictionary setValue:self.HEAD_IMG_INFO forKey:@"HEAD_IMG_INFO"];
        
        self.NAME_CN                =  [aDecoder decodeObjectForKey:@"NAME_CN"];
        [self.userDictionary setValue:self.NAME_CN forKey:@"NAME_CN"];
        
        self.ORG_FEH_ID             =  [aDecoder decodeObjectForKey:@"ORG_FEH_ID"];
        [self.userDictionary setValue:self.ORG_FEH_ID forKey:@"ORG_FEH_ID"];
        
        self.ORG_FEH_NAME           =  [aDecoder decodeObjectForKey:@"ORG_FEH_NAME"];
        [self.userDictionary setValue:self.ORG_FEH_NAME forKey:@"ORG_FEH_NAME"];
        
        self.ORG_ID                 =  [aDecoder decodeObjectForKey:@"ORG_ID"];
        [self.userDictionary setValue:self.ORG_ID forKey:@"ORG_ID"];
        
        self.ORG_NAME               =  [aDecoder decodeObjectForKey:@"ORG_NAME"];
        [self.userDictionary setValue:self.ORG_NAME forKey:@"ORG_NAME"];
        
        self.ORG_WD_ID              =  [aDecoder decodeObjectForKey:@"ORG_WD_ID"];
        [self.userDictionary setValue:self.ORG_WD_ID forKey:@"ORG_WD_ID"];
        
        self.ORG_WD_NAME            =  [aDecoder decodeObjectForKey:@"ORG_WD_NAME"];
        [self.userDictionary setValue:self.ORG_WD_NAME forKey:@"ORG_WD_NAME"];
        
        self.ORG_ZHH_ID             =  [aDecoder decodeObjectForKey:@"ORG_ZHH_ID"];
        [self.userDictionary setValue:self.ORG_ZHH_ID forKey:@"ORG_ZHH_ID"];
        
        self.ORG_ZHH_NAME           =  [aDecoder decodeObjectForKey:@"ORG_ZHH_NAME"];
        [self.userDictionary setValue:self.ORG_ZHH_NAME forKey:@"ORG_ZHH_NAME"];
        
        self.ORG_ZOH_ID             =  [aDecoder decodeObjectForKey:@"ORG_ZOH_ID"];
        [self.userDictionary setValue:self.ORG_ZOH_ID forKey:@"ORG_ZOH_ID"];
        
        self.ORG_ZOH_NAME           =  [aDecoder decodeObjectForKey:@"ORG_ZOH_NAME"];
        [self.userDictionary setValue:self.ORG_ZOH_NAME forKey:@"ORG_ZOH_NAME"];
        
        self.ROLE_ID                =  [aDecoder decodeObjectForKey:@"ROLE_ID"];
        [self.userDictionary setValue:self.ROLE_ID forKey:@"ROLE_ID"];
        
        self.USER_ADDR              =  [aDecoder decodeObjectForKey:@"USER_ADDR"];
        [self.userDictionary setValue:self.USER_ADDR forKey:@"USER_ADDR"];
        
        self.USER_EMAIL             =  [aDecoder decodeObjectForKey:@"USER_EMAIL"];
        [self.userDictionary setValue:self.USER_EMAIL forKey:@"USER_EMAIL"];
        
        self.USER_ID                =  [aDecoder decodeObjectForKey:@"USER_ID"];
        [self.userDictionary setValue:self.USER_ID forKey:@"USER_ID"];
        
        self.USER_PRIVILEGE         =  [aDecoder decodeObjectForKey:@"USER_PRIVILEGE"];
        [self.userDictionary setValue:self.USER_PRIVILEGE forKey:@"USER_PRIVILEGE"];
        
        self.USER_PRIVILEGE_NAME    =  [aDecoder decodeObjectForKey:@"USER_PRIVILEGE_NAME"];
        [self.userDictionary setValue:self.USER_PRIVILEGE_NAME forKey:@"USER_PRIVILEGE_NAME"];
        
        self.USER_SEX               =  [aDecoder decodeObjectForKey:@"USER_SEX"];
        [self.userDictionary setValue:self.USER_SEX forKey:@"USER_SEX"];
        
        self.USER_TEL               =  [aDecoder decodeObjectForKey:@"USER_TEL"];
        [self.userDictionary setValue:self.USER_TEL forKey:@"USER_TEL"];
        
        self.USER_TYP               =  [aDecoder decodeObjectForKey:@"USER_TYP"];
        [self.userDictionary setValue:self.USER_TYP forKey:@"USER_TYP"];
        
        self.USER_TYP_NAME          =  [aDecoder decodeObjectForKey:@"USER_TYP_NAME"];
        [self.userDictionary setValue:self.USER_TYP_NAME forKey:@"USER_TYP_NAME"];
        
        self.ec                     =  [aDecoder decodeObjectForKey:@"ec"];
        [self.userDictionary setValue:self.ec forKey:@"ec"];
        
        self.em                     =  [aDecoder decodeObjectForKey:@"em"];
        [self.userDictionary setValue:self.em forKey:@"em"];
    }else{
        return nil;
    }
    return self;
}


@end
