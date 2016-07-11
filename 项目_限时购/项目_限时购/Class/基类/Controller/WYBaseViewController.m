//
//  WYBaseViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

#import "SVProgressHUD.h"

#import "AppDelegate.h"

/** 判断当前网络状态的枚举选项 */
typedef NS_ENUM(NSInteger, CurrentNetworkStatus) {
    
    /** 无网络 */
    CurrentNetworkStatusUnknown      = -1,
    
    /** 网络异常 */
    CurrentNetworkStatusNotReachable = 0 ,
    
    /** WIFI网络 */
    CurrentNetworkStatusReachableViaWiFi ,
    
    /** 移动网络 */
    CurrentNetworkStatusReachableViaWWAN ,
    
    /** 判断有误 */
    CurrentNetworkStatusTypeError
};

@interface WYBaseViewController () 

/** 判断当前网络状态的属性 */
@property (assign, nonatomic) CurrentNetworkStatus networkStasus;

@end

@implementation WYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(245, 245, 245)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
}

/** 导航添加左上角的返回其它App的按钮 */
- (void)leftNavigationTabBarItem {
    
    UIButton *returnAppBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [returnAppBtn setTitle:[NSString stringWithFormat:@"返回"] forState:(UIControlStateNormal)];
    [returnAppBtn setTitleColor:RGB(53, 56, 239) forState:(UIControlStateNormal)];
    [returnAppBtn setTitleColor:RGB(239, 56, 53) forState:(UIControlStateHighlighted)];
    [returnAppBtn sizeToFit];
    [returnAppBtn addTarget:self action:@selector(btnTouchActionReturnApp) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:returnAppBtn];
    
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

/** 返回App的点击事件 */
- (void)btnTouchActionReturnApp {
    
    AppDelegate *appWindow = [UIApplication sharedApplication].delegate;
    
    /** 用 ? 号截取字符串 */
    NSString *schemeString = [[appWindow.threeString componentsSeparatedByString:@"?"] lastObject];
    
    /** 拼接 :// */
    NSString *urlString = [schemeString stringByAppendingString:@"://"];
    
    NSURL *urlApp = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] openURL:urlApp]) {
        [[UIApplication sharedApplication] openURL:urlApp];
    }
    else {
        ZDY_LOG(@"    返回App失败");
    }
}

/** 实现 GET */
- (void)GETHttpUrlString:(NSString *)urlString
             progressDic:(NSDictionary *)progressDic
                 success:(SuccessBlock)success
                 failure:(ErrorBlock)failure {
    WS(weakSelf);
    
    [SVProgressHUD show];
    [WYHttpRequest GETHttpRequestPathUrl:urlString bodyDic:progressDic successBlock:^(id JSON) {
        if (success) {
            success(JSON);
        }
        [SVProgressHUD dismiss];
        
    } errorBlock:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        [SVProgressHUD dismiss];
        [weakSelf showTostView:[NSString stringWithFormat:@"请检查网络连接状态"]];
    }];
}

/** 实现 POST */
- (void)POSTHttpUrlString:(NSString *)urlString
              progressDic:(NSDictionary *)progressDic
                  success:(SuccessBlock)success
                  failure:(ErrorBlock)failure {
    WS(weakSelf);
    [SVProgressHUD show];
    
    [WYHttpRequest POSTHttpRequestPatUrl:urlString bodyDic:progressDic successBlock:^(id JSON) {
        if (success) {
            success(JSON);
            
        }
        [SVProgressHUD dismiss];
    } errorBlock:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        [SVProgressHUD dismiss];
        [weakSelf showTostView:[NSString stringWithFormat:@"请检查网络连接状态"]];
    }];
    
}

- (void)showTostView:(NSString *)tostString {
    [self.view makeToast:tostString duration:2 position:[NSString stringWithFormat:@"center"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
