//
//  PDRequestUrl.h
//  PDCS
//
//  Created by iMac on 2017/9/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

#ifndef PDRequestUrl_h
#define PDRequestUrl_h


#define isRequesrTypr 1

/*
 设备编号 客户端类型1:android,2:ios
 */
#define DEV_TYPE @"2"

/*
 web 加载
 */
//#define text @"http://lanshaoqi.cn/index.html"
#define webUrl @"http://yinghang.lanshaoqi.cn/"
#define RDefaultUrl webUrl
/*
 服务器跟地址
 */
//#define KBaseUrl @"http://118.190.85.152:8080/"
#define KBaseUrl @"http://60.205.113.66:8080/"
/*
 文件缓冲地址
 */
#define KBaseFileUrl @"文件地址"


#pragma mark ---- 接口地址--------


/*
  **登录接口**
 USER_ID    用户编号
 DEV_TYPE    设备类型
 USER_PSW    用户密码
 DEVICE_ID    设备编号
 */
#define PDLoginUrl @"/mssia/user/login"

/*
 **验证码接口**
 USER_TEL    用户电话
 USER_ID    用户编号
 */
#define PDCaptchaUrl @"mssia/user/snedSMS"

//NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
//[param setObject:@"heyi001" forKey:@"USER_ID"];
//[param setObject:@"13522151806" forKey:@"USER_TEL"];


/*
 **短信效验
 TOKEN    短信标志
 CODE_MSG    短信验证码
 */
#define PDCValidateUrl @"mssia/user/validateSMS"

/*
 **设备绑定**
 USER_ID    用户编号
 USER_TEL    用户电话
 DEV_TYPE    设备类型
 DEVICE_ID    设备编号
 */
#define PDCbBindDeviceUrl @"mssia/user/bindDevice"



/*
**个人信息**
 USER_ID    用户编号
 HEAD_IMG    用户头像
 USER_SEX    用户性别
 USER_EMAIL    用户邮箱
 USER_ADDR    用户地址信息
 COMM    用户备注
 */
#define PDCEditUserInfoUrl @"mssia/user/editUserInfo"



/*
 **密码重置**
 USER_ID    用户编号
 USER_PSW    用户密码
 */
#define PDCResetPassUrl @"mssia/user/resetPass"


/*
 **修改密码**
 USER_ID        用户编号
 USER_PSW        旧密码
 USER_PSW_NEW        新密码
 */
#define PDCEditPassUrl @"mssia/user/editPass"




/*
 **公告查询**
 ROLE_ID        用户角色编号
 USER_ID        用户编号
 PAGE_NO        当前页面
 */
#define PDCFindNotice @"mssia/user/findNotice"

/*
 **公告阅读**
 USER_ID        用户编号
 NOTICE_ID        编号
 */
#define PDCReadyNoticeUrl @"mssia/user/readyNotice"


#pragma mark ---  挂牌利率查询
/*
 **  挂牌利率-产品类别查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 */
#define PDCR_GPType_Url @"mssia/lilv/queryGuaPaiLilvProduct"

/*
 **  挂牌利率-币种查询**
 USER_ID        用户编号
 ROLE_ID        用户角色编号
 */
#define PDCR_GPBZType_Url @"mssia/lilv/queryGuaPaiLilvHuobi"






#pragma mark ---  市场利率查询
/*
 **  市场利率-大类别查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 */
#define PDCR_SCType_Url @"mssia/lilv/queryMarketLilvBigType"


/*
 **  市场利率-币种查询**
 USER_ID        用户编号
 ROLE_ID        用户角色编号
 RATE_LLLX        利率类型
 */
#define PDCR_SCBZType_Url @"mssia/lilv/queryMarketLilvHuobi"







#pragma mark --- FTP利率查询
/*
 **  FTP利率-大类别查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 */
#define PDCR_FTPType_Url @"mssia/lilv/queryFtpLilvBigType"



#pragma mark --- 产品试算
/*
 **  产品试算 计算器类别信息查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 */
#define PDCR_CPSSType_Url @"mssia/product/queryProductCalculatorType"


/*
 **  产品试算-产品信息查询**
 USER_ID        用户编号
 ROLE_ID        用户角色编号
 DEP_TXJB        条线级别               注:"1:业务板块  2:业务列别  4:业务条线  7:产品名称"
 PRD_CAL_TYPE        类别代码
 DEP_SJTXBM        上级条线编码          注:条线级别为1时不必输，其他必输
 */
#define PDCR_CPSSXXCXType_Url @"mssia/product/queryProductInfo"

/*
 **  产品试算-合同期限**
 USER_ID    用户编号    String    20    Y
 ROLE_ID    用户角色编号    String    20    Y
 PRD_CAL_TYPE    类别代码    String    3    Y
 PRD_CPDM    产品代码
 */
#define PDCR_CPSSXXHTType_Url @"mssia/product/queryProductContract"

/*
  **  产品试算-币种查询**
 USER_ID    用户编号    String    20    Y
 ROLE_ID    用户角色编号    String    20    Y
 PRD_CPDM    产品代码    String    24    Y
 TERM_QXBM    期限编码    String    3    N
 TERM_TS    期限天数    INTEGER    5    Y
 PRD_CAL_TYPE    类别代码    String    3    Y
 */
#define PDCR_CPSSXXBZType_Url @"mssia/product/queryProductHuobi"


/*
   **  产品试算-客户类别**
 USER_ID    用户编号    String    20    Y
 ROLE_ID    用户角色编号    String    20    Y
 PRD_CPDM    产品代码    String    24    Y
 TERM_QXBM    期限编码    String    3    N
 TERM_TS    期限天数    INTEGER    5    Y
 PRD_CAL_TYPE    类别代码    String    3    Y
 PRD_BZ    币种代码    Strin
 */
#define PDCR_CPSSXXKHLEType_Url @"mssia/product/queryProductCusType"



/*
 ****产品试算-所属机构信息查询**
 USER_ID    用户编号    String    20    Y
 ROLE_ID    用户角色编号    String    20    Y
 PRD_CPDM    产品代码    String    24    Y
 TERM_QXBM    期限编码    String    3    N
 TERM_TS    期限天数    INTEGER    5    Y
 PRD_BZ    币种代码    String    3    Y
 CUST_LVL    客户类别代码    String    10    Y
 ORG_LVL    机构级别    String    10    Y    3:分行
 5:支行
 7:网点
 ORG_ID    用户所属机构    String    10    Y
 PRD_CAL_TYPE    类别代码    String    3    Y
 ORG_PAR_ID    上级机构代码    String    10    N    机构级别为3时不必输，其他必输
 */
#define PDCR_CPSSXXJGXXType_Url @"mssia/product/queryProductOrg"

#pragma mark --- 中间业务
/*
 **  中间业务-类别数据查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 */
#define PDCR_CPZJYWType_Url @"mssia/other/queryBusType"


/*
 **  中间业务-信息数据查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 */
#define PDCR_CPZJYWXXSJType_Url @"mssia/other/queryBusInfo"




#pragma mark ---机构信息查询
/*
 **  机构信息查询**
 USER_ID                用户编号
 ROLE_ID                用户角色编号
 ORG_ID                 用户所属机构
 */
#define PDCR_CPJGype_Url @"mssia/other/queryOrgConditionInfo"


#pragma mark ---用户信息查询
#define PDCR_QueryUserInfo_URL @"mssia/user/queryUserInfo"

#define PDC
#endif /* PDRequestUrl_h */
