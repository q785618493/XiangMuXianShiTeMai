//
//  WYThirdPartyView.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYThirdPartyView.h"

#define THREE_BTN_TAG 41000

@interface WYThirdPartyView ()

/** 标题 */
@property (strong, nonatomic) UILabel *titleLabel;

/** 中间线 */
@property (strong, nonatomic) UILabel *lineLable;

/** 第三方登录 QQ */
@property (strong, nonatomic) UIButton *qqBtn;

/** 第三方登录 微信 */
@property (strong, nonatomic) UIButton *weChatBtn;

/** 第三方登录 微博 */
@property (strong, nonatomic) UIButton *weiBoBtn;

@end

@implementation WYThirdPartyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.lineLable];
        [self addSubview:self.titleLabel];
        [self addSubview:self.qqBtn];
        [self addSubview:self.weChatBtn];
        [self addSubview:self.weiBoBtn];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self controlAddMasonry];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    
    CGFloat width = self.frame.size.width;
    CGFloat interval = (width - 46 * 3) * 0.25;
    
    WS(weakSelf);
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(11);
        make.left.mas_equalTo(weakSelf.mas_left).offset(16);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top);
        make.left.mas_equalTo(weakSelf.mas_left).offset((width - 80) * 0.5);
        make.size.mas_equalTo(CGSizeMake(80, 21));
    }];
    
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(weakSelf.mas_left).offset(interval);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    
    [_weChatBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(weakSelf.qqBtn.mas_right).offset(interval);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    
    [_weiBoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(16);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-interval);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
}

/** 重写 get方法懒加载控件 */
- (UIButton *)weiBoBtn {
    if (!_weiBoBtn) {
        _weiBoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_weiBoBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"登陆界面微博登录"]] forState:(UIControlStateNormal)];
        [_weiBoBtn setTag:THREE_BTN_TAG + 2];
        [_weiBoBtn addTarget:self action:@selector(btnTouchActionThird:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _weiBoBtn;
}

- (UIButton *)weChatBtn {
    if (!_weChatBtn) {
        _weChatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_weChatBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"登录界面微信登录"]] forState:(UIControlStateNormal)];
        [_weChatBtn setTag:THREE_BTN_TAG + 1];
        [_weChatBtn addTarget:self action:@selector(btnTouchActionThird:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _weChatBtn;
}

- (UIButton *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_qqBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"登录界面qq登陆"]] forState:(UIControlStateNormal)];
        [_qqBtn setTag:THREE_BTN_TAG];
        [_qqBtn addTarget:self action:@selector(btnTouchActionThird:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _qqBtn;
}

- (void)btnTouchActionThird:(UIButton *)thirdBtn {
    if (_thirdPartyBlock) {
        _thirdPartyBlock(thirdBtn.tag - THREE_BTN_TAG);
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setBackgroundColor:RGB(245, 245, 245)];
        [_titleLabel setTextColor:RGB(208, 208, 208)];
        [_titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [_titleLabel setText:[NSString stringWithFormat:@"一键登录"]];
    }
    return _titleLabel;
}

- (UILabel *)lineLable {
    if (!_lineLable) {
        _lineLable = [[UILabel alloc] init];
        [_lineLable setBackgroundColor:RGB(208, 208, 208)];
    }
    return _lineLable;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
