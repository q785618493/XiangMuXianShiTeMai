//
//  WYBottomPaymentView.m
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBottomPaymentView.h"

@interface WYBottomPaymentView ()

/** 立即支付按钮 */
@property (strong, nonatomic) UIButton *paymentBtn;

/** 商品价格信息 */
@property (strong, nonatomic) UILabel *goodsPriceLabel;

@end

@implementation WYBottomPaymentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.goodsPriceLabel];
        [self addSubview:self.paymentBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    [_paymentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(8);
        make.bottom.equalTo(weakSelf.bottom).offset(-8);
        make.right.equalTo(weakSelf.right).offset(-15);
        make.width.equalTo(113);
    }];
    
    [_goodsPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.paymentBtn.centerY);
        make.left.equalTo(weakSelf.left).offset(15);
        make.right.equalTo(weakSelf.paymentBtn.left).offset(-15);
        make.height.equalTo(21);
    }];
}

- (void)setPrice:(CGFloat)price {
    _price = price;
    
    NSAttributedString *titleAttributed = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    NSAttributedString *moneyAttributed = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f",price] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:RGB(243, 89, 49)}];
    
    NSMutableAttributedString *muAttributed = [[NSMutableAttributedString alloc] init];
    [muAttributed insertAttributedString:titleAttributed atIndex:0];
    [muAttributed insertAttributedString:moneyAttributed atIndex:titleAttributed.length];
    [_goodsPriceLabel setAttributedText:muAttributed];
}

/** 懒加载 */
- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        [_goodsPriceLabel setBackgroundColor:[UIColor whiteColor]];
        [_goodsPriceLabel setTextAlignment:(NSTextAlignmentRight)];
    }
    return _goodsPriceLabel;
}

- (UIButton *)paymentBtn {
    if (!_paymentBtn) {
        _paymentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_paymentBtn setBackgroundColor:RGB(55, 183, 236)];
        [_paymentBtn setTitle:[NSString stringWithFormat:@"立即支付"] forState:(UIControlStateNormal)];
        [_paymentBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_paymentBtn.layer setMasksToBounds:YES];
        [_paymentBtn.layer setCornerRadius:5];
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
