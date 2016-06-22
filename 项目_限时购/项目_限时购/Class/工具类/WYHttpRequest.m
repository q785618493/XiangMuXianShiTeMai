//
//  WYHttpRequest.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYHttpRequest.h"

#import <AFNetworking.h>

#import "MBProgressHUD+XMG.h"

@implementation WYHttpRequest

/** 实现 GET */
+ (void)GETHttpRequestPathUrl:(NSString *)pathUrl
                      bodyDic:(NSDictionary *)bodyDic
                 successBlock:(RequestSuccessBlock)successBlock
                   errorBlock:(RequestErrorBlock)errorBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /** 设置解析为 JSON */
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    /** 设置 ContentTypes(添加需要的参数) */
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plian", nil];
    
    [manager GET:pathUrl parameters:bodyDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

/** 实现 POST */
+ (void)POSTHttpRequestPatUrl:(NSString *)pathUrl
                      bodyDic:(NSDictionary *)bodyDic
                 successBlock:(RequestSuccessBlock)successBlock
                   errorBlock:(RequestErrorBlock)errorBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:pathUrl parameters:bodyDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+ (NSInteger)returnCurrentNetworkStasus {
    
    __block NSInteger index = 3;
    
    /** 获取当前网络状态 */
    AFNetworkReachabilityManager *judgeNetWork = [AFNetworkReachabilityManager sharedManager];
    [judgeNetWork setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        /**  判断当前网络状态*/
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                index = AFNetworkReachabilityStatusNotReachable;
            }
                break;
            case AFNetworkReachabilityStatusUnknown: {
                index = AFNetworkReachabilityStatusUnknown;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                index = AFNetworkReachabilityStatusReachableViaWiFi;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                index = AFNetworkReachabilityStatusReachableViaWWAN;
            }
                
            default:
                break;
        }
        
    }];
    /** 开启检查 */
    [judgeNetWork startMonitoring];
    
    if (3 == index) {
        return index;
    }
    return index;
}


@end
