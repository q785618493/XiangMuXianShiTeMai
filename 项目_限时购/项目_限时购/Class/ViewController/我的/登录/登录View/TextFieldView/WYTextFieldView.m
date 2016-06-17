//
//  WYTextFieldView.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYTextFieldView.h"

#define LENGTH_TEXT  22

@interface WYTextFieldView () <UITextFieldDelegate>

/** 文本框底层视图 */
@property (strong, nonatomic) UIView *backgroundView;

/** 输入手机号的文本框 */
@property (strong, nonatomic) UITextField *userField;

/** 输入密码的文本框 */
@property (strong, nonatomic) UITextField *codeField;

/** 中间的分隔线 */
@property (strong, nonatomic) UILabel *lineLabel;

/** 登录按钮 */
@property (strong, nonatomic) UIButton *loginBtn;

/** 注册按钮 */
@property (strong, nonatomic) UIButton *registerBtn;

@end

@implementation WYTextFieldView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setBackgroundColor:RGB(240, 240, 240)];
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.userField];
        [self.backgroundView addSubview:self.lineLabel];
        [self.backgroundView addSubview:self.codeField];
        [self addSubview:self.loginBtn];
        [self addSubview:self.registerBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self controlAddMasonry];
    [self.userField becomeFirstResponder];
}



/** 添加控件和约束 */
- (void)controlAddMasonry {
    
    CGFloat width = self.frame.size.width;
    
    WS(weakSelf);
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 87, 0));
    }];
    
    [_userField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backgroundView.mas_top);
        make.left.mas_equalTo(weakSelf.backgroundView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(width - 30, 44));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.userField.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(width - 30, 1));
    }];
    
    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.lineLabel.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(width - 30, 44));
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backgroundView.mas_bottom).offset(16);
        make.left.mas_equalTo(weakSelf.mas_left).offset(16);
        make.size.mas_equalTo(CGSizeMake(width - 32, 35));
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
}


/** 重写 get方法懒加载控件 */
- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_registerBtn setTitle:[NSString stringWithFormat:@"免费注册"] forState:(UIControlStateNormal)];
        [_registerBtn setTitleColor:RGB(0, 147, 190) forState:(UIControlStateNormal)];
        [_registerBtn addTarget:self action:@selector(btnTouchActionRegister) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _registerBtn;
}

- (void)btnTouchActionRegister {
    
    if (_registerBlock) {
        _registerBlock();
    }
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"登录界面登录按钮"]] forState:(UIControlStateNormal)];
        [_loginBtn addTarget:self action:@selector(btnTouchActionLogin) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBtn;
}

- (void)btnTouchActionLogin {
    
    if (_loginBlock) {
        _loginBlock();
    }
}

- (UITextField *)codeField {
    if (!_codeField) {
        _codeField = [[UITextField alloc] init];
        [_codeField setDelegate:self];
        [_codeField setBorderStyle:(UITextBorderStyleNone)];
        [_codeField setPlaceholder:[NSString stringWithFormat:@"请输入密码"]];
        [_codeField setClearButtonMode:(UITextFieldViewModeWhileEditing)];
        [_codeField setSecureTextEntry:YES];

    }
    return _codeField;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        [_lineLabel setBackgroundColor:RGB(200, 200, 200)];
    }
    return _lineLabel;
}

- (UITextField *)userField {
    if (!_userField) {
        _userField = [[UITextField alloc] init];
        [_userField setDelegate:self];
        [_userField setBorderStyle:(UITextBorderStyleNone)];
        [_userField setKeyboardType:(UIKeyboardTypeNumberPad)];
        [_userField setPlaceholder:[NSString stringWithFormat:@"请输入手机号"]];
        [_userField setClearButtonMode:(UITextFieldViewModeWhileEditing)];
    }
    return _userField;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    }
    return _backgroundView;
}

#pragma make-
#pragma make- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length > LENGTH_TEXT) {
        textField.text = [textField.text substringToIndex:LENGTH_TEXT - 1];
        return NO;
    }
    
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
