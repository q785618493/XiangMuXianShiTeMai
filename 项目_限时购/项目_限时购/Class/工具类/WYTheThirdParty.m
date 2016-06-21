//
//  WYTheThirdParty.m
//  项目_限时购
//
//  Created by ma c on 16/6/21.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYTheThirdParty.h"

@implementation WYTheThirdParty

/** 友盟 QQ登录 */
+ (void)QQLoginCurrentVC:(UIViewController *)currentVC
            successLogin:(ThreeLoginSuccessBlock)successLogin
              errorLogin:(ThreeLoginErrorBlock)errorLogin {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(currentVC,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            
            if (successLogin) {
                successLogin(dict);
            }
            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
        }
        else {
            if (errorLogin) {
                errorLogin();
            }
        }
    });
}

/** 友盟 新浪微博 分享 */
+ (void)sinaWeiBoCurrentVC:(UIViewController *)currentVC {
    
    [UMSocialData defaultData].extConfig.title = @"来自特卖商城，限时特卖韩国化妆品";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:currentVC
                                         appKey:@"57678e2367e58e3f85001389"
                                      shareText:@"输入现在分享的心情"
                                     shareImage:[UIImage imageNamed:@"限时特卖"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToTencent,UMShareToQzone,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToWechatFavorite,UMShareToAlipaySession,UMShareToYXSession,UMShareToYXTimeline,UMShareToLWSession,UMShareToLWTimeline,UMShareToInstagram,UMShareToWhatsapp,UMShareToLine,UMShareToTumblr,UMShareToPinterest,UMShareToKakaoTalk,UMShareToFlickr,]
                                       delegate:currentVC];
}


@end
