//
//  WYLoginViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYLoginViewController.h"

#import "WYTextFieldView.h"
#import "WYThirdPartyView.h"

@interface WYLoginViewController ()

/** WYTextFieldView登录视图 */
@property (strong, nonatomic) WYTextFieldView *textFieldView;

/** WYThirdPartyView第三方视图 */
@property (strong, nonatomic) WYThirdPartyView *threeLoginView;

@end

@implementation WYLoginViewController

/** 重写 get方法懒加载控件 */
- (WYTextFieldView *)textFieldView {
    if (!_textFieldView) {
        _textFieldView = [[WYTextFieldView alloc] init];
        _textFieldView.dataDic = [NSDictionary dictionaryWithObjectsAndKeys:@"免费注册",@"btnTitle",RGB(0, 147, 190),@"btnColor",@"登录界面登录按钮",@"image", nil];
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
    
    [self.view setBackgroundColor:RGB(240, 240, 240)];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    [self.view addSubview:self.textFieldView];
    [self.view addSubview:self.threeLoginView];
    
    
    WS(weakSelf);
    [_textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(80);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(width, 176));
    }];
    
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
