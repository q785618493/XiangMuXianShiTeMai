//
//  WYTheThirdParty.h
//  项目_限时购
//
//  Created by ma c on 16/6/21.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocial.h>

/** 成功后回调数据的 block */
typedef void(^ThreeLoginSuccessBlock)(NSDictionary *dict);

/** 失败后回调通知的block  */
typedef void(^ThreeLoginErrorBlock)();

@interface WYTheThirdParty : NSObject 

/** 友盟 QQ登录 */
+ (void)QQLoginCurrentVC:(UIViewController *)currentVC
            successLogin:(ThreeLoginSuccessBlock)successLogin
              errorLogin:(ThreeLoginErrorBlock)errorLogin;

/** 友盟 新浪微博 分享 */
+ (void)sinaWeiBoCurrentVC:(UIViewController *)currentVC;

@end
