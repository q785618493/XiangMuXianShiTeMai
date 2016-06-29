//
//  WYLoginViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYLoginViewController.h"
#import "WYRegisterViewController.h"

#import "WYTextFieldView.h"
#import "WYThirdPartyView.h"

#import "WYMeModel.h"

@interface WYLoginViewController () <UMSocialUIDelegate>

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

    CGFloat width = self.view.frame.size.width;
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
    
    weakSelf.textFieldView.loginBlock = ^(NSString *userPhone, NSString *codePhone) {
        
        if ([userPhone isEmptyString]) {
            
            [MBProgressHUD showError:[NSString stringWithFormat:@"账号不能为空"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        else if ([codePhone isEmptyString]) {
            
            [MBProgressHUD showError:[NSString stringWithFormat:@"密码不能为空"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        else if ([userPhone checkTel] && codePhone.length > 5 && userPhone.length == 11) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userPhone,@"LoginName",codePhone,@"Lpassword", nil];
            [weakSelf loginHttpPostRequestDic:dic];
            
        }
        else {
            [MBProgressHUD showError:[NSString stringWithFormat:@"账号或密码错误"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
    };
    
    weakSelf.textFieldView.registerBlock = ^() {
        WYRegisterViewController *registerVC = [[WYRegisterViewController alloc] init];
        registerVC.title = [NSString stringWithFormat:@"注 册"];
        [weakSelf.navigationController pushViewController:registerVC animated:YES];
    };
    
    weakSelf.threeLoginView.thirdPartyBlock = ^(NSInteger btnTag) {
        
        switch (btnTag) {
            case 0: {
                [WYTheThirdParty QQLoginCurrentVC:self successLogin:^(NSDictionary *dict) {
                
                    NSLog(@" QQUserInfo === %@",dict);
                    
                } errorLogin:^{
                    
                    [MBProgressHUD showError:[NSString stringWithFormat:@"登录失败"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                    });
                }];
            }
                break;
            case 1: {
                
            }
                break;
            case 2: {
                
                [WYTheThirdParty sinaWeiBoCurrentVC:self];
            }
                
            default:
                break;
        }
    };
    
}

/** 登录的网络请求 */
- (void)loginHttpPostRequestDic:(NSDictionary *)requestDic {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appMember/appLogin.do"] progressDic:requestDic success:^(id JSON) {
        
        NSDictionary *userDic = (NSDictionary *)JSON;
        
        if ([userDic[@"ErrorMessage"] isEqualToString:[NSString stringWithFormat:@"登陆成功"]]) {
            
            [XSG_USER_DEFAULTS setObject:userDic forKey:LOGIN_USER];
            
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"登录成功ing..."]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                
                NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:userDic[@"MemberName"],@"name",userDic[@"MemberLvl"],@"member",userDic[@"MemberId"],@"userID",userDic[@"result"],@"goodsQuantity", nil];
                [weakSelf loginSuccessCallbackDataDic:dataDic];
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
        else {
            
            [MBProgressHUD showError:[NSString stringWithFormat:@"登录失败,检查账号密码是否正确"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"%@",error.localizedDescription);
      
    }];
}

/** 登录成功后回调的方法 */
- (void)loginSuccessCallbackDataDic:(NSDictionary *)dataDic {
    
    WYMeModel *couponModel = [[WYMeModel alloc] init];
    couponModel.title = [NSString stringWithFormat:@"我的优惠券"];
    couponModel.image = [NSString stringWithFormat:@"我的界面我的优惠券图标"];
    
    WYMeModel *moneyModel = [[WYMeModel alloc] init];
    moneyModel.title = [NSString stringWithFormat:@"邀请好友,立刻赚钱"];
    moneyModel.image = [NSString stringWithFormat:@"我的界面邀请好友图标"];
    
    WYMeModel *meAddressModel = [[WYMeModel alloc] init];
    meAddressModel.title = [NSString stringWithFormat:@"我的收货地址"];
    meAddressModel.image = [NSString stringWithFormat:@"位置"];
    
    NSArray *meTableArray = [NSArray arrayWithObjects:couponModel,moneyModel,meAddressModel, nil];
    
    if (_passBackMe) {
        _passBackMe(meTableArray, dataDic, YES);
    }
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
