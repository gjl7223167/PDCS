//
//  NetTool.h
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NetError.h"


typedef void(^imageSizeSuccBlock)(CGSize iSize);
typedef void(^imageSizeFailBlock)(void);
typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(NetError * error);

@class FormData;


/**
 *  网络工具
 */
@interface NetTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url                  请求路径
 *  @param params               请求参数
 *  @param success              请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure              请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
/**
 *  发送一个POST请求
 *
 *  @param url                  请求路径
 *  @param params               请求参数
 *  @param success              请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure              请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
/**
 *  单个文件的上传
 *
 *  @param url                  请求路径
 *  @param params               请求参数
 *  @param dataSource           文件参数
 *  @param success              请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure              请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params dataSource:(FormData *)dataSource success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

/**
 *  多文件上传
 *
 *  @param url                  请求路径
 *  @param params               请求参数
 *  @param formDataArray        多文件数组
 *  @param success              请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure              请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;


+ (void)post:(NSString *)url params:(NSDictionary *)params fileModel:(FormData *)formModel success:(void (^)(id json))success failure:(void (^)(NetError *error))failure;

+ (CGSize)imgSizeWith:(NSString*)url success:(imageSizeSuccBlock)success failure:(imageSizeFailBlock)failure;

+ (void)registDevInfo;


@end










/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject
/**
 *  文件路径
 */
@property(nonatomic,copy)NSString* filePath;
/**
 *  参数名
 */
@property(nonatomic,copy)NSString* name;
/**
 *  文件名
 */
@property(nonatomic,copy)NSString* filename;
/**
 *  文件类型
 */
@property(nonatomic,copy)NSString* mimeType;


@end



