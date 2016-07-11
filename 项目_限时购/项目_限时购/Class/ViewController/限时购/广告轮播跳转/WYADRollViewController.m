//
//  WYADRollViewController.m
//  项目_限时购
//
//  Created by ma c on 16/7/11.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYADRollViewController.h"

#import "UIDevice--Hardware.h"

@interface WYADRollViewController ()

@end

@implementation WYADRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"广告赞助"];
    
    ZDY_LOG(@"   %ld   ",_dataID);
    
    /** 获取手机硬件信息 */
    // 1.手机型号
    ZDY_LOG(@"手机型号:%@",[[UIDevice currentDevice] platformString])
    
    // 2.存储空间
    ZDY_LOG(@"存储空间:%@ / %@", [[UIDevice currentDevice] freeDiskSpace], [[UIDevice currentDevice] totalDiskSpace]);
    
    [self controlAddMasonry];
}


- (void)controlAddMasonry {
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 100, VIEW_WIDTH, 30))];
    [phoneLabel setText:[NSString stringWithFormat:@"手机型号:%@",[[UIDevice currentDevice] platformString]]];
    [phoneLabel setTextAlignment:(NSTextAlignmentCenter)];
    [phoneLabel setBackgroundColor:RGB(245, 245, 245)];
    [self.view addSubview:phoneLabel];
    
    UILabel *spaceLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 200, VIEW_WIDTH, 30))];
    
    NSNumber *one = [[UIDevice currentDevice] freeDiskSpace];
    NSNumber *two = [[UIDevice currentDevice] totalDiskSpace];
    
    CGFloat currentStore = one.floatValue / 1024.0 / 1024.0 /1024.0;
    CGFloat mainStore = two.floatValue / 1024.0 / 1024.0 /1024.0;
    [spaceLabel setBackgroundColor:RGB(245, 245, 245)];
    [spaceLabel setTextAlignment:(NSTextAlignmentCenter)];
    [spaceLabel setText:[NSString stringWithFormat:@"存储空间:%.2fGB / %.2fGB", currentStore,mainStore]];
    [self.view addSubview:spaceLabel];
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
