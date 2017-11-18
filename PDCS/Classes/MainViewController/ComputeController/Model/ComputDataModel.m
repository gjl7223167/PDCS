//
//  ComputDataModel.m
//  PDCS
//
//  Created by Long on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputDataModel.h"

@implementation ComputDataModel



+(NSMutableDictionary *)initWithDictModel{
     NSMutableDictionary * mutableDict = [[NSMutableDictionary alloc] init];
    
        NSMutableDictionary * dictaa = [[NSMutableDictionary alloc] init];
        [dictaa setObject:@"业务模块" forKey:@"name"];
        [dictaa setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictab = [[NSMutableDictionary alloc] init];
        [dictab setObject:@"业务类型" forKey:@"name"];
        [dictab setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictac = [[NSMutableDictionary alloc] init];
        [dictac setObject:@"业务线条" forKey:@"name"];
        [dictac setObject:@"" forKey:@"value"];
        NSMutableArray * ary1 = [[NSMutableArray alloc] initWithObjects:dictaa,dictab,dictac, nil];
        
        NSMutableDictionary * dictba = [[NSMutableDictionary alloc] init];
        [dictba setObject:@"产品名称" forKey:@"name"];
        [dictba setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictbb = [[NSMutableDictionary alloc] init];
        [dictbb setObject:@"合同期限" forKey:@"name"];
        [dictbb setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictbc = [[NSMutableDictionary alloc] init];
        [dictbc setObject:@"币种" forKey:@"name"];
        [dictbc setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictbd = [[NSMutableDictionary alloc] init];
        [dictbd setObject:@"客户类别" forKey:@"name"];
        [dictbd setObject:@"" forKey:@"value"];
        NSMutableArray * ary2 = [[NSMutableArray alloc] initWithObjects:dictba,dictbb,dictbc,dictbd, nil];
        
        NSMutableDictionary * dictca = [[NSMutableDictionary alloc] init];
        [dictca setObject:@"所属分行" forKey:@"name"];
        [dictca setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictcb = [[NSMutableDictionary alloc] init];
        [dictcb setObject:@"所属支行" forKey:@"name"];
        [dictcb setObject:@"" forKey:@"value"];
        NSMutableDictionary * dictcc = [[NSMutableDictionary alloc] init];
        [dictcc setObject:@"所属网点" forKey:@"name"];
        [dictcc setObject:@"" forKey:@"value"];
        NSMutableArray * ary3= [[NSMutableArray alloc] initWithObjects:dictca,dictcb,dictcc, nil];
        
        NSDictionary * dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"业务信息",@"name",ary1,@"value", nil];
        NSDictionary * dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"产品信息",@"name",ary2,@"value", nil];
        NSDictionary * dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"机构信息",@"name",ary3,@"value", nil];

        [mutableDict setObject:dict1 forKey:@"ywxx"];
        [mutableDict setObject:dict2 forKey:@"cpxx"];
        [mutableDict setObject:dict3 forKey:@"jgxx"];
    
    return mutableDict;
}

/*
 value 请求元数据
 name  返回对应字段描述数组
 */
+(void)requestComputModel:(NSIndexPath *)indexPath ParamDic:(NSDictionary *)info blok:(void(^)(NSDictionary * dcit))dictAndary{
    
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:model.USER_ID forKey:@"USER_ID"];
    [dict setObject:model.ROLE_ID forKey:@"ROLE_ID"];
    
    if (section == 0) {
        switch (row) {
            case 0:
                {
                    [dict setObject:@"1" forKey:@"DEP_TXJB"];
                    [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                    [dict setObject:@"" forKey:@"DEP_SJTXBM"];
                    [ComputDataModel YWMKRequest:PDCR_CPSSXXCXType_Url Parameter:dict Obj:^(id obj) {
                        NSArray * ary1 = obj[@"LIST"];
                        NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                        [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [titleAry addObject:obj[@"DEP_TXMC"]];
                        }];
                        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                        dictAndary(dict);
                        
                    }];

                }
                break;
            case 1:
            {
                [dict setObject:@"2" forKey:@"DEP_TXJB"];
                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"ywmk"] forKey:@"DEP_SJTXBM"];
                [ComputDataModel YWMKRequest:PDCR_CPSSXXCXType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"DEP_TXMC"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];

            }
                break;
            case 2:
            {
                [dict setObject:@"4" forKey:@"DEP_TXJB"];
                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"ywlx"] forKey:@"DEP_SJTXBM"];
                [ComputDataModel YWMKRequest:PDCR_CPSSXXCXType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"DEP_TXMC"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }else if (section == 1){
        switch (row) {
            case 0:
            {
                [dict setObject:@"7" forKey:@"DEP_TXJB"];
                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"ywxt"] forKey:@"DEP_SJTXBM"];
                [ComputDataModel YWMKRequest:PDCR_CPSSXXCXType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"DEP_TXMC"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
            }
                break;
            case 1:
            {

                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"cpmc"] forKey:@"PRD_CPDM"];
                [ComputDataModel YWMKRequest:PDCR_CPSSXXHTType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"TERM_QXMC"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
            }
                break;
            case 2:
            {


                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"cpmc"] forKey:@"PRD_CPDM"];
                [dict setValue:info[@"TERM_QXBM"] forKey:@"TERM_QXBM"];//限期编码
                [dict setValue:info[@"TERM_TS"] forKey:@"TERM_TS"];//限期天数
                
                [ComputDataModel YWMKRequest:PDCR_CPSSXXBZType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"CURR_ZWM"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
                
            }
                break;
            case 3:
            {



                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"cpmc"] forKey:@"PRD_CPDM"];
                [dict setValue:info[@"bz"] forKey:@"PRD_BZ"];
                [dict setValue:info[@"TERM_QXBM"] forKey:@"TERM_QXBM"];//限期编码
                [dict setValue:info[@"TERM_TS"] forKey:@"TERM_TS"];//限期天数
                
                
                [ComputDataModel YWMKRequest:PDCR_CPSSXXKHLEType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"CUST_LVL_NAME"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
                
                
            }
                break;
                
                
            default:
                break;
        }
    }else if (section == 2){
        switch (row) {
            case 0:
            {
                [dict setObject:model.ORG_ID forKey:@"ORG_ID"];
                [dict setValue:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"cpmc"] forKey:@"PRD_CPDM"];
                [dict setObject:info[@"bz"] forKey:@"PRD_BZ"];
                [dict setValue:info[@"TERM_QXBM"] forKey:@"TERM_QXBM"];//限期编码
                [dict setValue:info[@"TERM_TS"] forKey:@"TERM_TS"];//限期天数
                [dict setObject:@"3" forKey:@"ORG_LVL"];
                [dict setValue:info[@"khlb"] forKey:@"CUST_LVL"];
                
                [ComputDataModel YWMKRequest:PDCR_CPSSXXJGXXType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"ORG_NAME"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
                
            }
                break;
            case 1:
            {
               
                [dict setObject:model.ORG_ID forKey:@"ORG_ID"];
                [dict setObject:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setValue:info[@"cpmc"] forKey:@"PRD_CPDM"];
                [dict setValue:info[@"bz"] forKey:@"PRD_BZ"];
                [dict setValue:info[@"TERM_QXBM"] forKey:@"TERM_QXBM"];//限期编码
                [dict setValue:info[@"TERM_TS"] forKey:@"TERM_TS"];//限期天数
                 [dict setObject:@"5" forKey:@"ORG_LVL"];
                [dict setValue:info[@"khlb"] forKey:@"CUST_LVL"];

                [dict setValue:info[@"scfh"] forKey:@"ORG_PAR_ID"];

                
                [ComputDataModel YWMKRequest:PDCR_CPSSXXJGXXType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"ORG_NAME"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
            }
                break;
            case 2:
            {
                [dict setObject:model.ORG_ID forKey:@"ORG_ID"];
                [dict setObject:info[@"PRD_CAL_TYPE"] forKey:@"PRD_CAL_TYPE"];
                [dict setObject:info[@"cpmc"] forKey:@"PRD_CPDM"];
                [dict setObject:info[@"bz"] forKey:@"PRD_BZ"];
                [dict setObject:info[@"TERM_QXBM"] forKey:@"TERM_QXBM"];//限期编码
                [dict setObject:info[@"TERM_TS"] forKey:@"TERM_TS"];//限期天数
                [dict setObject:@"7" forKey:@"ORG_LVL"];
                [dict setObject:info[@"khlb"] forKey:@"CUST_LVL"];
                
                [dict setObject:info[@"sczh"] forKey:@"ORG_PAR_ID"];
                
                [ComputDataModel YWMKRequest:PDCR_CPSSXXJGXXType_Url Parameter:dict Obj:^(id obj) {
                    NSArray * ary1 = obj[@"LIST"];
                    NSMutableArray * titleAry = [[NSMutableArray alloc] init];
                    [ary1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [titleAry addObject:obj[@"ORG_NAME"]];
                    }];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"value" ,titleAry,@"name",nil];
                    dictAndary(dict);
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }
}

/*业务模块*/
+(id)YWMKRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obJ{
    [ComputRequestModel computRequest:url Parameter:Parame Obj:^(id obj) {
        if (obJ) {
            obJ(obj);
        };
    }];
    return @"";
}

/*业务类型*/
+(id)YWLXRequest:(NSString *)url Parameter:(NSDictionary *)Parame Obj:(returnObjct)obJ{
    [ComputRequestModel computRequest:url Parameter:Parame Obj:^(id obj) {
        if (obJ) {
            obJ(obj);
        };
    }];
    return @"";
}


@end


