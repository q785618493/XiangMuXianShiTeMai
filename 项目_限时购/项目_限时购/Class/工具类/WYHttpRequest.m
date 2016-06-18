//
//  WYHttpRequest.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYHttpRequest.h"

#import <AFNetworking.h>

@implementation WYHttpRequest

/** 实现 GET */
+ (void)GETHttpRequestPathUrl:(NSString *)pathUrl
                      bodyDic:(NSDictionary *)bodyDic
                 successBlock:(RequestSuccessBlock)successBlock
                   errorBlock:(RequestErrorBlock)errorBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
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


@end
