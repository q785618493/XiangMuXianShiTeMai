//
//  WYRegisterViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYRegisterViewController.h"
#import "WYTestPhoneViewController.h"
#import "WYTextFieldView.h"
#import "WYThirdPartyView.h"

@interface WYRegisterViewController ()

/** WYTextFieldView注册视图 */
@property (strong, nonatomic) WYTextFieldView *textFieldView;

/** WYThirdPartyView第三方视图 */
@property (strong, nonatomic) WYThirdPartyView *threeLoginView;

@end

@implementation WYRegisterViewController

/** 重写 get方法懒加载控件 */
- (WYTextFieldView *)textFieldView {
    if (!_textFieldView) {
        _textFieldView = [[WYTextFieldView alloc] init];
        _textFieldView.dataDic = [NSDictionary dictionaryWithObjectsAndKeys:@"立即登录",@"btnTitle",RGB(0, 147, 225),@"btnColor",@"注册界面下一步按钮",@"image", nil];
    }
    return _textFieldView;
}

- (WYThirdPartyView *)threeLoginView {
    if (!_threeLoginView) {
        _threeLoginView = [[WYThirdPartyView alloc] init];
    }
    return _threeLoginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self controlAddMasonry];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {

    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UILabel *promptLabel = [[UILabel alloc] init];
    [promptLabel setText:[NSString stringWithFormat:@"请输入手机号码注册新用户"]];
    [promptLabel setFont:[UIFont systemFontOfSize:14]];
    [promptLabel setTextColor:RGB(85, 85, 85)];
    
    [self.view addSubview:promptLabel];
    [self.view addSubview:self.textFieldView];
    [self.view addSubview:self.threeLoginView];
    
    
    WS(weakSelf);
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.top).offset(74);
        make.left.mas_equalTo(weakSelf.view.left).offset(15);
        make.right.mas_equalTo(weakSelf.view.right).offset(-15);
        make.height.mas_equalTo(15);
    }];
    
    [_textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(99);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(width, 176));
    }];
    
    weakSelf.textFieldView.loginBlock = ^(NSString *userPhone, NSString *codePhone) {
        WYTestPhoneViewController *testVC = [[WYTestPhoneViewController alloc] init];
        testVC.userPhone = userPhone;
        testVC.codePhone = codePhone;
        [testVC setHidesBottomBarWhenPushed:YES];
        [weakSelf.navigationController pushViewController:testVC animated:YES];
    };
    
    weakSelf.textFieldView.registerBlock = ^() {
        
    };
    
    [_threeLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.textFieldView.mas_bottom).offset(16);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(width, 83));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
