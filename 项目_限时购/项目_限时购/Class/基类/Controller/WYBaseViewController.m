//
//  WYBaseViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

#import "SVProgressHUD.h"

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
    
//    self.networkStasus = [WYHttpRequest returnCurrentNetworkStasus];

}

/** 当前网络状态 */
- (void)currentNetworkStatus {
    
    /** 获取当前网络状态 */
    AFNetworkReachabilityManager *judgeNetWork = [AFNetworkReachabilityManager sharedManager];
    [judgeNetWork setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /**  判断当前网络状态*/
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                self.networkStasus = CurrentNetworkStatusNotReachable;
            }
                
                break;
            case AFNetworkReachabilityStatusUnknown: {
                self.networkStasus = CurrentNetworkStatusUnknown;
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                self.networkStasus = CurrentNetworkStatusReachableViaWiFi;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                self.networkStasus = CurrentNetworkStatusReachableViaWWAN;
            }
                
            default:
                break;
        }
        
    }];
    /** 开启检查 */
    [judgeNetWork startMonitoring];
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
    
//    /** 判断当前网络状态:如果没网就提示用户,有网请求数据 */
//    if (self.networkStasus == CurrentNetworkStatusNotReachable) {
//        
//        [MBProgressHUD showError:[NSString stringWithFormat:@"连接网络异常,请检查您的网络"]];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//            return;
//        });
//    }
//    else if (self.networkStasus == CurrentNetworkStatusUnknown) {
//        
//        [MBProgressHUD showError:[NSString stringWithFormat:@"没有网络,请去设置"]];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//            return ;
//        });
//    }
//    else if (self.networkStasus == CurrentNetworkStatusTypeError) {
//        [MBProgressHUD showError:[NSString stringWithFormat:@"判断失误"]];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
//            return ;
//        });
//        
//    }
//    else {
//        [WYHttpRequest GETHttpRequestPathUrl:urlString bodyDic:progressDic successBlock:^(id JSON) {
//            if (success) {
//                success(JSON);
//            }
//            
//        } errorBlock:^(NSError *error) {
//            
//            if (failure) {
//                failure(error);
//            }
//        }];
//    }
    
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
    [self.view makeToast:tostString duration:1.5 position:[NSString stringWithFormat:@"center"]];
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
