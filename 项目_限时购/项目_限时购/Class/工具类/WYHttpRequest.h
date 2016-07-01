//
//  WYHttpRequest.h
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 成功回调数据的 Block */
typedef void(^RequestSuccessBlock)(id JSON);

/** 失败回调失败原因的 Block */
typedef void(^RequestErrorBlock)(NSError *error);

@interface WYHttpRequest : NSObject

/** 封装AFNetworking GET 网络请求
 
 * pathUrl       URL地址
 
 * bodyDic       请求参数 (NSDictionary)
 
 * successBlock  请求成功返回数据（NSArray or NSDictionary）
 
 * errorBlock    请求失败返回原因 (NSError)
 */
+ (void)GETHttpRequestPathUrl:(NSString *)pathUrl
                  bodyDic:(NSDictionary *)bodyDic
             successBlock:(RequestSuccessBlock)successBlock
               errorBlock:(RequestErrorBlock)errorBlock;


/** 封装AFNetworking POST 网络请求
 
 * pathUrl       URL地址
 
 * bodyDic       请求参数 (NSDictionary)
 
 * successBlock  请求成功返回数据（NSArray or NSDictionary）
 
 * errorBlock    请求失败返回原因 (NSError)
 */
+ (void)POSTHttpRequestPatUrl:(NSString *)pathUrl
                  bodyDic:(NSDictionary *)bodyDic
             successBlock:(RequestSuccessBlock)successBlock
               errorBlock:(RequestErrorBlock)errorBlock;


@end
