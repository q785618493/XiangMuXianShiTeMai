//
//  WYBaseViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageSetting.h"

#import "UIImageView+WY_SDWedImage.h"
#import "NSString+Helper.h"
#import "WYHttpRequest.h"
#import "WYCustomButton.h"
#import "MBProgressHUD+XMG.h"

/** 返回请求数据 */
typedef void(^SuccessBlock)(id JSON);

/** 返回失败原因 */
typedef void(^ErrorBlock)(NSError *error);

@interface WYBaseViewController : UIViewController

/** GET 网络请求
 
 * UrlString       URL地址
 
 * progressDic       请求参数 (NSDictionary)
 
 * success  请求成功返回数据（NSArray or NSDictionary）
 
 * failure    请求失败返回原因 (NSError)
 */
- (void)GETHttpUrlString:(NSString *)urlString
             progressDic:(NSDictionary *)progressDic
                 success:(SuccessBlock)success
                 failure:(ErrorBlock)failure;


/** POST 网络请求
 
 * UrlString       URL地址
 
 * progressDic       请求参数 (NSDictionary)
 
 * success  请求成功返回数据（NSArray or NSDictionary）
 
 * failure    请求失败返回原因 (NSError)
 */
- (void)POSTHttpUrlString:(NSString *)urlString
             progressDic:(NSDictionary *)progressDic
                 success:(SuccessBlock)success
                 failure:(ErrorBlock)failure;







@end
