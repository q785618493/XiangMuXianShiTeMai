//
//  WYLoginNoGoodsView.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYLoginNoGoodsView.h"

@interface WYLoginNoGoodsView ()

/** 购物车界面静态购物车图标 */
@property (strong, nonatomic) UIImageView *carImage;

/** 购物车界面提示信息 */
@property (strong, nonatomic) UILabel *pointLabel;

/** 购物车界面 逛一逛 */
@property (strong, nonatomic) UIButton *goagoBtn;

@end

@implementation WYLoginNoGoodsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.carImage];
        [self addSubview:self.pointLabel];
        [self addSubview:self.goagoBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    [_carImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.centerX);
        make.size.equalTo(CGSizeMake(320, 258));
    }];
    
    [_pointLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.carImage.bottom);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(20);
    }];
    
    [_goagoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pointLabel.bottom).offset(20);
        make.centerX.equalTo(weakSelf.centerX);
        make.size.equalTo(CGSizeMake(113, 36));
    }];
}

/** 懒加载 */
- (UIImageView *)carImage {
    if (!_carImage) {
        _carImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面静态购物车图标"]]];
        [_carImage setBackgroundColor:RGB(245, 245, 245)];
    }
    return _carImage;
}

- (UILabel *)pointLabel {
    if (!_pointLabel) {
        _pointLabel = [[UILabel alloc] init];
        [_pointLabel setFont:[UIFont systemFontOfSize:12]];
        [_pointLabel setTextColor:RGB(99, 167, 180)];
        [_pointLabel setText:[NSString stringWithFormat:@"购物车还是空的，快去挑选宝贝吧~"]];
        [_pointLabel setBackgroundColor:RGB(245, 245, 245)];
        [_pointLabel setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _pointLabel;
}

- (UIButton *)goagoBtn {
    if (!_goagoBtn) {
        _goagoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_goagoBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面逛一逛按钮"]] forState:(UIControlStateNormal)];
        [_goagoBtn setBackgroundColor:RGB(245, 245, 245)];
        [_goagoBtn addTarget:self action:@selector(btnTouchActionGoago) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _goagoBtn;
}
- (void)btnTouchActionGoago {
    if (_btnGoagoAction) {
        _btnGoagoAction();
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
