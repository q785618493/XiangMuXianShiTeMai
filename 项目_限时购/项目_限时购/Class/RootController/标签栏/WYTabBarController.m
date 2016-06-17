//
//  WYTabBarController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYNavigationController.h"

@interface WYTabBarController ()

@property (strong, nonatomic) NSArray *vcArray;

@end

@implementation WYTabBarController


- (NSArray *)vcArray {
    
    if (!_vcArray) {
        _vcArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ViewControllerS.plist" ofType:nil]];
    }
    return _vcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:self.vcArray.count];
    
    [self.vcArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Class vcClass = NSClassFromString(dict[@"ViewController"]);
        
        UIViewController *controller = [[vcClass alloc] init];
        
        controller.title = dict[@"title"];
        
//        [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(167, 167, 167)} forState:(UIControlStateNormal)];
//        
//        [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(2, 184, 240)} forState:(UIControlStateSelected)];
        
        [controller.tabBarItem setImage:[[UIImage imageNamed:dict[@"image"]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        
        [controller.tabBarItem setSelectedImage:[[UIImage imageNamed:dict[@"seleImage"]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        
        [controller setAutomaticallyAdjustsScrollViewInsets:NO];
        
        WYNavigationController *navigVC = [[WYNavigationController alloc] initWithRootViewController:controller];
        
        [muArray addObject:navigVC];
        
    }];
    
    self.viewControllers = muArray;
    self.selectedIndex = muArray.count - 1;
    
    /** 在对象方法中设置 TabBar 的 文字颜色 和 大小 */
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:(UIControlStateNormal)];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(2, 184, 240),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:(UIControlStateSelected)];
    
}

+ (void)initialize {
    
    /** 在类方法中设置 TabBar 的 文字颜色 和 大小 */
    [[UITabBarItem appearanceWhenContainedIn:self, nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:(UIControlStateNormal)];
    
    
    [[UITabBarItem appearanceWhenContainedIn:self, nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(2, 184, 240),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:(UIControlStateSelected)];
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
