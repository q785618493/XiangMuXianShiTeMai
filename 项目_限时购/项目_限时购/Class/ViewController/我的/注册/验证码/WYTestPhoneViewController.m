//
//  WYTestPhoneViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYTestPhoneViewController.h"
#import "GCDCountdownTime.h"

@interface WYTestPhoneViewController () <UITextFieldDelegate>

/** 输入验证码的文本框 */
@property (strong, nonatomic) UITextField *verifyTextField;

/** 注册按钮 */
@property (strong, nonatomic) UIButton *logonBtn;

/** 倒计时按钮 */
@property (strong, nonatomic) WYCustomButton *testBtn;

/** 重获验证码按钮 */
@property (strong, nonatomic) UIButton *againBtn;

@end

@implementation WYTestPhoneViewController

/** 重写 get方法懒加载控件 */
- (UITextField *)verifyTextField {
    if (!_verifyTextField) {
        _verifyTextField = [[UITextField alloc] init];
        [_verifyTextField setBackgroundColor:[UIColor whiteColor]];
        [_verifyTextField setBorderStyle:(UITextBorderStyleNone)];
        [_verifyTextField setDelegate:self];
        [_verifyTextField setPlaceholder:[NSString stringWithFormat:@"请输入验证码"]];
        [_verifyTextField setKeyboardType:(UIKeyboardTypeNumbersAndPunctuation)];
        [_verifyTextField setClearButtonMode:(UITextFieldViewModeWhileEditing)];
    }
    return _verifyTextField;
}

- (UIButton *)logonBtn {
    if (!_logonBtn) {
        _logonBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_logonBtn setTitle:[NSString stringWithFormat:@"注 册"] forState:(UIControlStateNormal)];
        [_logonBtn setTitleColor:RGB(151, 151, 151) forState:(UIControlStateNormal)];
        [_logonBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_logonBtn setBackgroundColor:RGB(230, 230, 230)];
        [_logonBtn addTarget:self action:@selector(btnTouchActionLogin) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _logonBtn;
}
/** 注册按钮点击事件 */
- (void)btnTouchActionLogin {
    
    if (![self.verifyTextField.text isEmptyString] && self.verifyTextField.text.length == 6) {
        
        [self registerHttpPostRequest];
        [self.view endEditing:YES];
    }
    else if ([self.verifyTextField.text isEmptyString]) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"验证码不能为空"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            
        });
    }
    else {
        [MBProgressHUD showError:[NSString stringWithFormat:@"验证码输入错误"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }
}

- (WYCustomButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [WYCustomButton buttonWithType:(UIButtonTypeCustom)];
        [_testBtn setBtnTitleType:(TestBtnTitleTypeNothing)];
        [_testBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _testBtn;
}

- (UIButton *)againBtn {
    if (!_againBtn) {
        _againBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_againBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_againBtn setTitle:[NSString stringWithFormat:@"重新发送验证码"] forState:(UIControlStateNormal)];
        [_againBtn setTitleColor:RGB(180, 180, 180) forState:(UIControlStateNormal)];
        [_againBtn setTitleColor:RGB(0, 187, 239) forState:(UIControlStateHighlighted)];
        [_againBtn setEnabled:NO];
        [_againBtn addTarget:self action:@selector(btnTouchActionAgain:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _againBtn;
}
/** 重新发送验证码按钮点击事件 */
- (void)btnTouchActionAgain:(UIButton *)againBtn {
    againBtn.enabled = !againBtn.enabled;
    
    [GCDCountdownTime GCDTimeMethod:self.testBtn];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加控件和约束 */
    [self controlAddMasonry];
    
    /** 获取验证码的网络请求 */
    [self testCodeHttpPostRequest];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.verifyTextField becomeFirstResponder];
    
    /** KVO 监听倒计时按钮title的变化    */
    [self.testBtn addObserver:self forKeyPath:[NSString stringWithFormat:@"btnTitleType"] options:(NSKeyValueObservingOptionNew) context:nil];
}

/** 实现KVO监听方法 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (self.testBtn.btnTitleType == TestBtnTitleTypeSpecial) {
        [self.againBtn setEnabled:YES];
    }
}

/** 移除KVO */
- (void)dealloc {
    [self.testBtn removeObserver:self forKeyPath:[NSString stringWithFormat:@"btnTitleType"]];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    WS(weakSelf);
    UILabel *promptLabel = [[UILabel alloc] init];
    [promptLabel setAttributedText:[self returnPromptLabelText]];
    [self.view addSubview:promptLabel];
    
    UIView *backgView = [[UIView alloc] init];
    [backgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backgView];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    [lineLabel setBackgroundColor:RGB(230, 230, 230)];
    [backgView addSubview:lineLabel];
    
    [backgView addSubview:self.verifyTextField];
    [backgView addSubview:self.testBtn];
    [self.view addSubview:self.logonBtn];
    [self.view addSubview:self.againBtn];
    
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.top).offset(74);
        make.left.mas_equalTo(weakSelf.view.left).offset(15);
        make.right.mas_equalTo(weakSelf.view.right).offset(-15);
        make.height.mas_equalTo(15);
    }];

    [backgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel.bottom).offset(10);
        make.left.equalTo(weakSelf.view.left);
        make.right.equalTo(weakSelf.view.right);
        make.height.equalTo(43);
    }];
    
    [_verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backgView).with.insets(UIEdgeInsetsMake(0, 15, 0, 103));
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(1);
        make.top.equalTo(backgView.top).offset(3);
        make.bottom.equalTo(backgView.bottom).offset(-3);
        make.left.equalTo(weakSelf.verifyTextField.right);
    }];
    
    [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgView.top);
        make.bottom.equalTo(backgView.bottom);
        make.right.equalTo(backgView.right);
        make.left.equalTo(lineLabel.right);
    }];
    
    [_logonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgView.bottom).offset(16);
        make.left.equalTo(weakSelf.view.left).offset(15);
        make.right.equalTo(weakSelf.view.right).offset(-15);
        make.height.equalTo(35);
    }];
    
    [_againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logonBtn.bottom).offset(22);
        make.height.equalTo(22);
        make.left.equalTo(weakSelf.view.left).offset(90);
        make.right.equalTo(weakSelf.view.right).offset(-90);
    }];
}

/** 富文本描述 promptLabel的信息 */
- (NSAttributedString *)returnPromptLabelText {
    
    NSAttributedString *textAttr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"验证码已经发送到"] attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,RGB(165, 165, 165),NSForegroundColorAttributeName, nil]];
    NSAttributedString *phoneAttr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"+86 %@",_userPhone] attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,RGB(0, 187, 239),NSForegroundColorAttributeName, nil]];
    
    NSMutableAttributedString *muAttr = [[NSMutableAttributedString alloc] init];
    [muAttr insertAttributedString:textAttr atIndex:0];
    [muAttr insertAttributedString:phoneAttr atIndex:textAttr.length];
    return muAttr;
}

/** 获取验证码的网络请求 */
- (void)testCodeHttpPostRequest {
    
    WS(weakSelf);
    NSDictionary *requestDic = [NSDictionary dictionaryWithObjectsAndKeys:_userPhone,@"MemberId", nil];
    
    [self POSTHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appMember/createCode.do"] progressDic:requestDic success:^(id JSON) {
        
        NSDictionary *dataDic = (NSDictionary *)JSON;
        
        if ([dataDic[@"result"] isEqual:[NSString stringWithFormat:@"success"]]) {
            [GCDCountdownTime GCDTimeMethod:weakSelf.testBtn];
            
        } else {
            
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"无法获得验证码,请检查您的网络"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"%@",error);
        [MBProgressHUD showError:[NSString stringWithFormat:@"请检查您的网络"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];
}

/** 注册的网络请求 */
- (void)registerHttpPostRequest {
    
    NSDictionary *requestDic = [NSDictionary dictionaryWithObjectsAndKeys:_userPhone,@"LoginName",_codePhone,@"Lpassword",_verifyTextField.text,@"Code",_userPhone,@"Telephone", nil];
    
    [self POSTHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appMember/appRegistration.do"] progressDic:requestDic success:^(id JSON) {
        
        NSDictionary *dataDic = (NSDictionary *)JSON;
        
        if ([[NSString stringWithFormat:@"success"] isEqual:dataDic[@"result"]]) {
            
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"注册成功,快去登录"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        else {
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"验证码错误"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"%@",error);
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"验证码输入有误"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma make-
#pragma make- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length >= 7 ) {
        textField.text = [textField.text substringToIndex:6];
        return NO;
    }
    return YES;
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
