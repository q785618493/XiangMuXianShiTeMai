//
//  WYProductViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/20.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYProductViewController.h"

#import <UMSocial.h>

@interface WYProductViewController () <UMSocialUIDelegate>

@end

@implementation WYProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /** 添加导航条上的三个按钮 */
    [self navigationAddThreeBarBtnItem];
}

/** 添加导航条上的三个按钮 */
- (void)navigationAddThreeBarBtnItem {
    
    /**     左边返回按钮     */
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:@"详情界面返回按钮"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barItemLeft)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    
    /**     右边两个按钮     */
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:@"详情界面收藏按钮"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barItemCollect)];
    
    UIBarButtonItem *_rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:@"详情界面转发按钮"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barItemRelay)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:rightItem,_rightItem, nil];
    
    [self.navigationItem setRightBarButtonItems:itemsArray];
}

/** 左边返回按钮点击事件 */
- (void)barItemLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

/** 右边收藏按钮点击事件 */
- (void)barItemCollect {
    
}

/** 右边转发按钮点击事件 */
- (void)barItemRelay {
    
    [UMSocialData defaultData].extConfig.title = @"来自特卖商城，限时特卖韩国化妆品";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57678e2367e58e3f85001389"
                                      shareText:@"问一下搞机大队的，各位基佬们会给女朋友买这种化妆品吗?"
                                     shareImage:[UIImage imageNamed:@"商品详情2"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToTencent,UMShareToQzone,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToWechatFavorite,UMShareToAlipaySession,UMShareToYXSession,UMShareToYXTimeline,UMShareToLWSession,UMShareToLWTimeline,UMShareToInstagram,UMShareToWhatsapp,UMShareToLine,UMShareToTumblr,UMShareToPinterest,UMShareToKakaoTalk,UMShareToFlickr,]
                                       delegate:self];
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
