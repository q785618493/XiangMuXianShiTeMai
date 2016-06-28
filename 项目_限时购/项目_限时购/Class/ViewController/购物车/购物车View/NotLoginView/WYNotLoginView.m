//
//  WYNotLoginView.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYNotLoginView.h"

@interface WYNotLoginView ()

/** 提示去登录信息 */
@property (strong, nonatomic) UILabel *centerLabel;

/** 去我的酷兜 */
@property (strong, nonatomic) UIButton *loginBtn;

@end

@implementation WYNotLoginView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.centerLabel];
        [self addSubview:self.loginBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    [_centerLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 35, 0));
    }];
    
    [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.centerLabel.bottom);
        make.bottom.equalTo(weakSelf.bottom);
        make.left.equalTo(weakSelf.left).offset(10);
        make.right.equalTo(weakSelf.right).offset(-10);
    }];
}


/** 懒加载 */
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBtn setBackgroundColor:RGB(0, 183, 239)];
        [_loginBtn setTitle:[NSString stringWithFormat:@"去我的酷兜"] forState:(UIControlStateNormal)];
        [_loginBtn.layer setMasksToBounds:YES];
        [_loginBtn.layer setCornerRadius:5];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_loginBtn addTarget:self action:@selector(btnTouchActionLogin) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBtn;
}

- (void)btnTouchActionLogin {
    if (_blockLogin) {
        _blockLogin();
    }
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] init];
        [_centerLabel setBackgroundColor:RGB(245, 245, 245)];
        [_centerLabel setFont:[UIFont systemFontOfSize:14]];
        [_centerLabel setTextColor:RGB(225, 75, 145)];
        [_centerLabel setText:[NSString stringWithFormat:@"尊敬的用户您尚未登录,我的酷兜登录成为会员。"]];
        [_centerLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
        [_centerLabel setNumberOfLines:11];
    }
    return _centerLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
