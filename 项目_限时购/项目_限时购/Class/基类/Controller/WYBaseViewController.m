//
//  WYBaseViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYBaseViewController ()

@end

@implementation WYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view setBackgroundColor:RGB(245, 245, 245)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
}

/** 实现 GET */
- (void)GETHttpUrlString:(NSString *)urlString
             progressDic:(NSDictionary *)progressDic
                 success:(SuccessBlock)success
                 failure:(ErrorBlock)failure {
    
    [WYHttpRequest GETHttpRequestPathUrl:urlString bodyDic:progressDic successBlock:^(id JSON) {
        
        if (success) {
            success(JSON);
        }
        
    } errorBlock:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

/** 实现 POST */
- (void)POSTHttpUrlString:(NSString *)urlString
              progressDic:(NSDictionary *)progressDic
                  success:(SuccessBlock)success
                  failure:(ErrorBlock)failure {
    
    [WYHttpRequest POSTHttpRequestPatUrl:urlString bodyDic:progressDic successBlock:^(id JSON) {
        
        if (success) {
            success(JSON);
        }
        
    } errorBlock:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
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
