//
//  WYModifySiteViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYModifySiteViewController.h"
#import "WYContactsSiteModel.h"
#import "WYNewsSiteView.h"

@interface WYModifySiteViewController ()

@property (strong, nonatomic) WYNewsSiteView *modifySiteView;

@end

@implementation WYModifySiteViewController

/** 懒加载 */
- (WYNewsSiteView *)modifySiteView {
    if (!_modifySiteView) {
        _modifySiteView = [[WYNewsSiteView alloc] init];
        WS(weakSelf);
        _modifySiteView.blockUserSite = ^(WYContactsSiteModel *model) {
            if (_blockModify) {
                _blockModify(model, _cellRow);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _modifySiteView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"修改收货地址"];
    
    [self controlAddMasonry];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    WS(weakSelf);
    [self.view addSubview:self.modifySiteView];
    
    [_modifySiteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.left);
        make.right.equalTo(weakSelf.view.right);
        make.top.equalTo(weakSelf.view.top).offset(64);
        make.height.equalTo(168);
    }];
}

- (void)setModel:(WYContactsSiteModel *)model {
    _model = model;
    self.modifySiteView.model = model;
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
