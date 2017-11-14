//
//  NetTool.m
//  PDCS
//
//  Created by iMac on 2017/9/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "NetTool.h"
#import "NetApiClient.h"
#import "NetSucc.h"

#define KCoMNetReqOutTime       10.0f
#define KFileNetReqOutTime      30.0f

#define KNetSuccCode            200
#define KNetScdSCode            1
#define KNetTrdSCode            203

@implementation NetTool




+ (void)get:(NSString *)url params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{

    [NetTool httpMethod:@"Get" withUrlPath:url params:params success:success failure:failure];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    [NetTool httpMethod:@"Post" withUrlPath:url params:params success:success failure:failure];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params dataSource:(FormData *)dataSource success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    AFSecurityPolicy * policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    NetApiClient * mgr = [NetApiClient sharedClient];
    mgr.requestSerializer.timeoutInterval = KFileNetReqOutTime * formDataArray.count;
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (FormData * fData in formDataArray) {
            UIImage * img = [UIImage imageWithContentsOfFile:fData.filePath];
            if (img) {
                NSData * imgData = UIImageJPEGRepresentation(img, 0.9);
                [formData appendPartWithFileData:imgData name:fData.name fileName:fData.filename mimeType:fData.mimeType];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetTool dealHttpNetData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetTool dealHttpError:error failure:failure];
    }];
    
}


+ (void)post:(NSString *)url params:(NSDictionary *)params fileModel:(FormData *)formModel success:(void (^)(id json))success failure:(void (^)(NetError *error))failure{
    AFSecurityPolicy * policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    NetApiClient * mgr = [NetApiClient sharedClient];
    mgr.requestSerializer.timeoutInterval = 100;
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * imgData = [NSData dataWithContentsOfFile:formModel.filePath];
            if (imgData) {
                [formData appendPartWithFileData:imgData name:formModel.name fileName:formModel.filename mimeType:formModel.mimeType];
            }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetTool dealHttpNetData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetTool dealHttpError:error failure:failure];
    }];
}


+ (CGSize)imgSizeWith:(NSString*)url success:(imageSizeSuccBlock)success failure:(imageSizeFailBlock)failure{
    
    NetApiClient * mgr = [[NetApiClient alloc] initWithBaseURL:[NSURL URLWithString:KBaseUrl]];

    mgr.requestSerializer.timeoutInterval = KFileNetReqOutTime;
    
    
    [mgr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIImage * image = [UIImage imageWithData:responseObject];
        CGSize size = [image size];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    return CGSizeMake(100, 100);
}


+ (void)httpMethod:(NSString*)method withUrlPath:(NSString*)urlPath params:(NSDictionary*)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *getStr= [jsonData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * parameter = [NSDictionary dictionaryWithObjectsAndKeys:getStr,@"reqJson",nil];
    
    
    
    //.1.获得请求管理者
    NetApiClient * mgr = [[NetApiClient alloc] initWithBaseURL:[NSURL URLWithString:KBaseUrl]];

    if (isRequesrTypr) {
        AFHTTPRequestSerializer * serializer = [AFHTTPRequestSerializer serializer];
        [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
        
        AFHTTPResponseSerializer * responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"text/html",nil]];
        
        mgr.requestSerializer =  serializer;
        mgr.responseSerializer = responseSerializer;
    }else{
        AFJSONRequestSerializer * serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
        
        AFJSONResponseSerializer* responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",nil]];
        
        mgr.requestSerializer =  serializer;
        mgr.responseSerializer = responseSerializer;
    }

    mgr.requestSerializer.timeoutInterval = KCoMNetReqOutTime;
    
    
    if ([method isEqualToString:@"Post"]) {
        [mgr POST:urlPath parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {            
            [NetTool dealHttpNetData:responseObject success:success failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [NetTool dealHttpError:error failure:failure];
        }];
        
    }else{
        [mgr GET:urlPath parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [NetTool dealHttpNetData:responseObject success:success failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [NetTool dealHttpError:error failure:failure];
        }];
    }
}

+ (void)registDevInfo{
    
}

+ (NSString*)fullUrlPathWith:(NSString*)urlPath
{
    NSMutableString* urlStr = [NSMutableString stringWithString:urlPath];

    NSString* uuid = [PDUtils uidStringForDevice];
    [urlStr appendFormat:@"&device_token=%@", uuid];
    [urlStr appendString:@"&mobile_type=ios"];
//    [urlStr appendFormat:@"&mobile_model=%@",[PDUtils getCurrentDeviceModel]];
    return urlStr;
}

+ (void)dealHttpNetData:(id)responseObj success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    NetSucc* netData = [[NetSucc alloc]initWithData:responseObj];
    NSLog(@"netData = %ld  netDataInfo = %@", (long)netData.code,netData.netMsg);
    if (netData.code != 0) {
        if (success) {
            success(responseObj);
        }
    }else{
        NetError* nError = [[NetError alloc]init];
        nError.code    = netData.code;
        nError.errStr  = netData.netMsg;
        if (failure) {
            failure(nError);
        }
    }
//    if (netData.code == KNetSuccCode || netData.code == KNetScdSCode || netData.code == KNetTrdSCode) {
//        if (success) {
//            success(responseObj);
//        }
//    }else{
//        NetError* nError = [[NetError alloc]init];
//        nError.code    = netData.code;
//        nError.errStr  = netData.netMsg;
//        if (failure) {
//            failure(nError);
//        }
//    }
}

+ (void)dealHttpError:(NSError*)error failure:(HttpFailureBlock)failure
{
    NetError* nError = [[NetError alloc]initWithError:error];
    NSLog(@"netData = %ld", (long)nError.code);
    failure(nError);
}
@end


@implementation FormData

@end
