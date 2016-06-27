//
//  WYSettlementView.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYSettlementView.h"

@interface WYSettlementView ()

/** 合计 */
@property (strong, nonatomic) UILabel *titleLabel;

/** 价格 */
@property (strong, nonatomic) UILabel *priceLabel;

/** 全场包邮 */
@property (strong, nonatomic) UILabel *viceLabel;

/** 去结算 */
@property (strong, nonatomic) UIButton *paymentBtn;

@end

@implementation WYSettlementView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.viceLabel];
        [self addSubview:self.paymentBtn];
    }
    return self;
}

/** 添加约束 */
- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf);
    [_paymentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(8);
        make.right.equalTo(weakSelf.right).offset(-15);
        make.size.equalTo(CGSizeMake(110, 36));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(8);
        make.left.equalTo(weakSelf.left).offset(10);
        make.size.equalTo(CGSizeMake(35, 18));
    }];
    
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(8);
        make.left.equalTo(weakSelf.titleLabel.right).offset(6);
        make.right.equalTo(weakSelf.paymentBtn.left).offset(-5);
    }];
    
    [_viceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottom).offset(-10);
        make.left.equalTo(weakSelf.titleLabel.right).offset(6);
        make.right.equalTo(weakSelf.paymentBtn.left).offset(-5);
        make.height.equalTo(14);
    }];
}

- (void)setMoneyText:(NSString *)moneyText {
    _moneyText = moneyText;
    [_priceLabel setText:[NSString stringWithFormat:@"￥%@元",moneyText]];
}

/** 懒加载 */
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setText:[NSString stringWithFormat:@"合计:"]];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setBackgroundColor:[UIColor whiteColor]];
        [_priceLabel setTextColor:RGB(255, 32, 32)];
    }
    return _priceLabel;
}

- (UILabel *)viceLabel {
    if (!_viceLabel) {
        _viceLabel = [[UILabel alloc] init];
        [_viceLabel setFont:[UIFont systemFontOfSize:13]];
        [_viceLabel setText:[NSString stringWithFormat:@"(全场包邮)"]];
        [_viceLabel setBackgroundColor:[UIColor whiteColor]];
    }
    return _viceLabel;
}

- (UIButton *)paymentBtn {
    if (!_paymentBtn) {
        _paymentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_paymentBtn setBackgroundColor:[UIColor whiteColor]];
        [_paymentBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面去结算按钮"]] forState:(UIControlStateNormal)];
        [_paymentBtn addTarget:self action:@selector(btnTouchActionPayment) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _paymentBtn;
}

- (void)btnTouchActionPayment {
    if (_blockPayment) {
        _blockPayment();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
