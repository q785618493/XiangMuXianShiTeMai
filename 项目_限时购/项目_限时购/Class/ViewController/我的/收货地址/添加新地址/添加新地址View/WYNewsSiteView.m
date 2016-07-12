//
//  WYNewsSiteView.m
//  项目_限时购
//
//  Created by ma c on 16/6/30.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYNewsSiteView.h"
#import "WYContactsSiteModel.h"
#import "UIView+Toast.h"
#import "NSString+Helper.h"

@interface WYNewsSiteView () <UITextFieldDelegate,UITextViewDelegate>

/** 收货人 */
@property (strong, nonatomic) UILabel *nameLabel;

/** 收货人输入框 */
@property (strong, nonatomic) UITextField *userText;

/** 联系电话 */
@property (strong, nonatomic) UILabel *phoneLabel;

/** 联系电话输入框 */
@property (strong, nonatomic) UITextField *numberPhoneText;

/** 详细地址 */
@property (strong, nonatomic) UILabel *siteLabel;

/** 详细地址文本域 */
@property (strong, nonatomic) UITextView *addressTextView;

/** 文本域的提示信息 */
@property (strong, nonatomic) UILabel *alertLabel;

/** 底部视图 */
@property (strong, nonatomic) UIView *bottomView;

/** 保存地址信息按钮 */
@property (strong, nonatomic) UIButton *saveBtn;

@end

@implementation WYNewsSiteView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.userText];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.numberPhoneText];
        [self addSubview:self.siteLabel];
        [self addSubview:self.addressTextView];
        [self.addressTextView addSubview:self.alertLabel];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.saveBtn];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf);
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top);
        make.left.equalTo(weakSelf.left);
        make.size.equalTo(CGSizeMake(73, 40));
    }];
    
    [_userText makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top);
        make.left.equalTo(weakSelf.nameLabel.right);
        make.right.equalTo(weakSelf.right);
        make.height.equalTo(40);
    }];
    
    [_phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.bottom).offset(1);
        make.left.equalTo(weakSelf.left);
        make.size.equalTo(CGSizeMake(73, 40));
    }];
    
    [_numberPhoneText makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneLabel.centerY);
        make.height.equalTo(40);
        make.left.equalTo(weakSelf.phoneLabel.right);
        make.right.equalTo(weakSelf.right);
    }];
    
    [_siteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneLabel.bottom).offset(1);
        make.centerX.equalTo(weakSelf.phoneLabel.centerX);
        make.size.equalTo(CGSizeMake(73, 40));
    }];
    
    [_addressTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numberPhoneText.bottom).offset(1);
        make.height.equalTo(40);
        make.left.equalTo(weakSelf.siteLabel.right);
        make.right.equalTo(weakSelf.right);
    }];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottom);
        make.height.equalTo(45);
        make.left.equalTo(weakSelf.left);
        make.right.equalTo(weakSelf.right);
    }];
    
    [_saveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.bottomView).with.insets(UIEdgeInsetsMake(5, 50, 5, 50));
    }];
    
    [self.userText becomeFirstResponder];
}

- (void)setModel:(WYContactsSiteModel *)model {
    _model = model;
    [_userText setText:model.userName];
    [_numberPhoneText setText:model.phoneNumber];
    [_addressTextView setText:model.siteInfo];
    [self.alertLabel removeFromSuperview];
}

/** 懒加载 */
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setBackgroundColor:[UIColor whiteColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
        [_nameLabel setText:[NSString stringWithFormat:@"收货人名:"]];
        [_nameLabel setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _nameLabel;
}

- (UITextField *)userText {
    if (!_userText) {
        _userText = [[UITextField alloc] init];
        [_userText setBackgroundColor:[UIColor whiteColor]];
        [_userText setDelegate:self];
        [_userText setBorderStyle:(UITextBorderStyleNone)];
        [_userText setPlaceholder:[NSString stringWithFormat:@"   请输入收货人姓名"]];
        [_userText setClearButtonMode:(UITextFieldViewModeWhileEditing)];
        [_userText setFont:[UIFont systemFontOfSize:14]];
    }
    return _userText;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        [_phoneLabel setBackgroundColor:[UIColor whiteColor]];
        [_phoneLabel setFont:[UIFont systemFontOfSize:14]];
        [_phoneLabel setText:[NSString stringWithFormat:@"联系方式:"]];
        [_phoneLabel setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _phoneLabel;
}

- (UITextField *)numberPhoneText {
    if (!_numberPhoneText) {
        _numberPhoneText = [[UITextField alloc] init];
        [_numberPhoneText setBackgroundColor:[UIColor whiteColor]];
        [_numberPhoneText setDelegate:self];
        [_numberPhoneText setBorderStyle:(UITextBorderStyleNone)];
        [_numberPhoneText setKeyboardType:(UIKeyboardTypePhonePad)];
        [_numberPhoneText setPlaceholder:[NSString stringWithFormat:@"   输入联系方式电话"]];
        [_numberPhoneText setClearButtonMode:(UITextFieldViewModeWhileEditing)];
        [_numberPhoneText setFont:[UIFont systemFontOfSize:14]];
    }
    return _numberPhoneText;
}

- (UILabel *)siteLabel {
    if (!_siteLabel) {
        _siteLabel = [[UILabel alloc] init];
        [_siteLabel setBackgroundColor:[UIColor whiteColor]];
        [_siteLabel setFont:[UIFont systemFontOfSize:14]];
        [_siteLabel setText:[NSString stringWithFormat:@"收货地址:"]];
        [_siteLabel setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _siteLabel;
}

- (UITextView *)addressTextView {
    if (!_addressTextView) {
        _addressTextView = [[UITextView alloc] init];
        [_addressTextView setBackgroundColor:[UIColor whiteColor]];
        [_addressTextView setDelegate:self];
        [_addressTextView setScrollEnabled:YES];
        [_addressTextView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight)];
        [_addressTextView setFont:[UIFont systemFontOfSize:14]];
        
    }
    return _addressTextView;
}

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 144, 20))];
        [_alertLabel setBackgroundColor:[UIColor whiteColor]];
        [_alertLabel setTextColor:RGB(200, 200, 206)];
        [_alertLabel setFont:[UIFont systemFontOfSize:14]];
        [_alertLabel setText:[NSString stringWithFormat:@"请输入收货的详细地址"]];
    }
    return _alertLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bottomView;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_saveBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_saveBtn.layer setMasksToBounds:YES];
        [_saveBtn.layer setCornerRadius:5];
        [_saveBtn setBackgroundColor:RGB(55, 183, 236)];
        [_saveBtn setTitle:[NSString stringWithFormat:@"保 存"] forState:(UIControlStateNormal)];
        [_saveBtn addTarget:self action:@selector(btnTouchActionSave) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _saveBtn;
}

- (void)btnTouchActionSave {
    
    if ([self.userText.text isEmptyString]) {
        [self makeToast:[NSString stringWithFormat:@"收货人不能为空"] duration:2 position:[NSString stringWithFormat:@"center"]];
        
    }
    else if ([self.numberPhoneText.text isEmptyString]) {
        [self makeToast:[NSString stringWithFormat:@"联系电话不能为空"] duration:2 position:[NSString stringWithFormat:@"center"]];
        
    }
    else if ([self.addressTextView.text isEmptyString]) {
        [self makeToast:[NSString stringWithFormat:@"收货地址不能为空"] duration:2 position:[NSString stringWithFormat:@"center"]];
        
    }
    else if (self.numberPhoneText.text.length < 6) {
        [self makeToast:[NSString stringWithFormat:@"联系方式错误"] duration:2 position:[NSString stringWithFormat:@"center"]];
    }
    else {
        WYContactsSiteModel *model = [[WYContactsSiteModel alloc] init];
        model.userName = self.userText.text;
        model.phoneNumber = self.numberPhoneText.text;
        model.siteInfo = self.addressTextView.text;
        [self endEditing:YES];
        if (_blockUserSite) {
            _blockUserSite(model);
        }
    }
}

#pragma make-
#pragma make- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _numberPhoneText) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16 - 1];
            return NO;
        }
    }
    return YES;
}

#pragma make-
#pragma make- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        [_alertLabel setText:[NSString stringWithFormat:@"请输入收货的详细地址"]];
        [_alertLabel setHidden:NO];
    }
    else {
        [_alertLabel setText:nil];
        [_alertLabel setHidden:YES];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
//    [self.alertLabel removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
