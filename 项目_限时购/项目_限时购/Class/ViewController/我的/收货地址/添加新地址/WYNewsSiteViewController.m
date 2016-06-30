//
//  WYNewsSiteViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYNewsSiteViewController.h"
#import "WYContactsSiteModel.h"
#import "WYNewsSiteView.h"

@interface WYNewsSiteViewController ()

@property (strong, nonatomic) WYNewsSiteView *newsView;

@end

@implementation WYNewsSiteViewController

/** 懒加载 */
- (WYNewsSiteView *)newsView {
    if (!_newsView) {
        _newsView = [[WYNewsSiteView alloc] init];
        WS(weakSelf);
        _newsView.blockUserSite = ^(WYContactsSiteModel *model) {
            if (_blockBack) {
                _blockBack(model);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _newsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"添加收货地址"];
    
    [self controlAddMasonry];
}


/** 添加控件和约束 */
- (void)controlAddMasonry {
    WS(weakSelf);
    [self.view addSubview:self.newsView];
    
    [_newsView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.left);
        make.right.equalTo(weakSelf.view.right);
        make.top.equalTo(weakSelf.view.top).offset(64);
        make.height.equalTo(168);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
