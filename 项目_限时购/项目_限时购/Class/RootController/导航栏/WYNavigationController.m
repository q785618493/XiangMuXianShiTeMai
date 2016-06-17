//
//  WYNavigationController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYNavigationController.h"

@interface WYNavigationController ()

@end

@implementation WYNavigationController

+ (void)initialize {
    
    /** [UINavigationBar appearanceWhenContainedIn:self, nil] 只能在类方法中使用 */
    UINavigationBar *tabBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
