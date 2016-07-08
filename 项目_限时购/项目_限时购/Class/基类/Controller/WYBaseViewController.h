//
//  WYBaseViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking.h>
#import <Masonry.h>
#import <UMSocial.h>
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageSetting.h"
#import "UIView+Toast.h"

#import "UIImageView+WY_SDWedImage.h"
#import "NSString+Helper.h"
#import "WYHttpRequest.h"
#import "WYCustomButton.h"
#import "MBProgressHUD+XMG.h"
#import "WYTheThirdParty.h"

/** 返回请求数据 */
typedef void(^SuccessBlock)(id JSON);

/** 返回失败原因 */
typedef void(^ErrorBlock)(NSError *error);

/** 回调网络状态的 Block */
typedef void(^NetworkStatusBlock)();

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

/**
 *  在中心位置弹出提示信息
 *
 *  @param tostString 提示用户的信息
 */
- (void)showTostView:(NSString *)tostString;

/** 导航添加左上角的返回其它App的按钮 */
- (void)leftNavigationTabBarItem;


@end
