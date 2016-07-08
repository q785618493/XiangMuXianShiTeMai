//
//  AppDelegate.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "AppDelegate.h"

#import "UIView+Toast.h"
#import "WYTabBarController.h"

#import <AlipaySDK/AlipaySDK.h>
#import <UMSocial.h>
#import <UMSocialSinaSSOHandler.h>
#import <UMSocialQQHandler.h>
#import <AFNetworking.h>

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /** 设置友盟分享的开发 key*/
    [UMSocialData setAppKey:@"57678e2367e58e3f85001389"];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1685404038"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    WYTabBarController *tabBarVC = [[WYTabBarController alloc] init];
    
    tabBarVC.delegate = self;
    
    [self.window setRootViewController:tabBarVC];
    
    [self.window makeKeyAndVisible];
    [self currentNetworkStatus];
    
    return YES;
}

/** 当前网络状态 */
- (void)currentNetworkStatus {
    
    /** 获取当前网络状态 */
    AFNetworkReachabilityManager *judgeNetWork = [AFNetworkReachabilityManager sharedManager];
    [judgeNetWork setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /**  判断当前网络状态*/
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                [self.window makeToast:[NSString stringWithFormat:@"当前网络异常,请您检查网络"] duration:3 position:[NSString stringWithFormat:@"center"]];
            }
                
                break;
            case AFNetworkReachabilityStatusUnknown: {
                [self.window makeToast:[NSString stringWithFormat:@"当前无网络连接,请去设置网络"] duration:3 position:[NSString stringWithFormat:@"center"]];
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                [self.window makeToast:[NSString stringWithFormat:@"当前使用的是WiFi网络"] duration:3 position:[NSString stringWithFormat:@"center"]];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                [self.window makeToast:[NSString stringWithFormat:@"当前使用的是移动网络"] duration:3 position:[NSString stringWithFormat:@"center"]];
            }
                
            default:
                break;
        }
        
    }];
    /** 开启检查 */
    [judgeNetWork startMonitoring];
}

/** 自定义友盟分享的回调*/
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
    
//    return result;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString*, id> *)options
{
    /** 将URL转换成字符串 */
    NSString *urlString = url.absoluteString;
    
    self.threeString = urlString;
    
    /** 获取根视图控制器 */
    WYTabBarController *rootVC = (WYTabBarController *)self.window.rootViewController;
    
    if ([urlString containsString:@"111"]) {
        rootVC.selectedIndex = 1;
    }
    else if ([urlString containsString:@"333"]) {
        rootVC.selectedIndex = 3;
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

/** 被弃用了的 (其它软件跳转到这里的监听方法)  */
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return YES;
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma make-
#pragma make- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    viewController.tabBarItem.badgeValue = nil;
}

@end
