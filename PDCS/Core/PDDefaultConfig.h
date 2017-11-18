//
//  PDDefaultConfig.h
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#ifndef PDDefaultConfig_h
#define PDDefaultConfig_h


#define     KDfltGap        10.0f
#define     KDfltGap        10.0f
#define     KEdgeGap        15.0f
#define    KSecHeight    10.f
#define    kLineHeight 0.6

typedef enum CuttentType{
    selectGPZHtype = 0,//挂牌利率 某支行
    selectGPZCtype,//挂牌利率 资产
    selectGPTYtype,//挂牌利率 同业
    selectGPRMBtype,//挂牌利率 人民币
    selectSCRENBCtype,//市场人民币存
    selectSCQBFLtype,//市场全部分类
    selectSCRMBtype,//市场人民币
    selectFTPQUFLtype,//FTP全部分类
    selectFTPRMBtype,//FTP人民币
    selectTimetype//日期时间
}currentType;

typedef enum CurrentSelectStatus{
    tableViewManyList = 0,
    tableViewAlist
}currentStatus;




typedef enum QupoteLoadType{
    QupoteLoadGuaType = 0,
    QupoteLoadShiType,
    QupoteLoadFtpType
}qupoteLoadType;

#endif /* PDDefaultConfig_h */
