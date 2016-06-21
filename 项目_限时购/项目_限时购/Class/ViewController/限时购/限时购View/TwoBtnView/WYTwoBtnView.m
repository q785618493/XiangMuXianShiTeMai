//
//  WYTwoBtnView.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYTwoBtnView.h"


@implementation WYTwoBtnView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self addSubview:self.NewBtn];
        [self addSubview:self.BrandBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self controlBtnMasonry];
}

/** 按钮控件添加约束 */
- (void)controlBtnMasonry {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    WS(weakSelf);
    
    [_NewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.size.mas_equalTo(CGSizeMake(width * 0.5, height));
    }];
    
    [_BrandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.size.mas_equalTo(CGSizeMake(width * 0.5, height));
    }];
    
}

/** 重写 get方法懒加载控件 */
- (UIButton *)NewBtn {
    if (!_NewBtn) {
        _NewBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_NewBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"新品团未选中"]] forState:(UIControlStateNormal)];
        [_NewBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"新品团选中"]] forState:(UIControlStateSelected)];
        [_NewBtn setTitle:[NSString stringWithFormat:@"新品团购"] forState:(UIControlStateNormal)];
        [_NewBtn setTitleColor:RGB(51, 197, 248) forState:(UIControlStateNormal)];
        [_NewBtn setTitleColor:RGB(239, 101, 48) forState:(UIControlStateSelected)];
        [_NewBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_NewBtn setSelected:YES];
    }
    return _NewBtn;
}

- (UIButton *)BrandBtn {
    if (!_BrandBtn) {
        _BrandBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_BrandBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"品牌团未选中"]] forState:(UIControlStateNormal)];
        [_BrandBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"品牌团选中"]] forState:(UIControlStateSelected)];
        [_BrandBtn setTitleColor:RGB(51, 197, 248) forState:(UIControlStateNormal)];
        [_BrandBtn setTitleColor:RGB(239, 101, 48) forState:(UIControlStateSelected)];
        [_BrandBtn setTitle:[NSString stringWithFormat:@"品牌团购"] forState:(UIControlStateNormal)];
    }
    return _BrandBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
