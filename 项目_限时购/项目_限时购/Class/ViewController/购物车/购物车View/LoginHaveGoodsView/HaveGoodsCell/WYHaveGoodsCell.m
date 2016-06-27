//
//  WYHaveGoodsCell.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYHaveGoodsCell.h"
#import "WYShoppingCarModel.h"

#define BTN_TAG 30000

@interface WYHaveGoodsCell ()

/** 勾选商品按钮 */
@property (strong, nonatomic) UIButton *checkTheBtn;

/** 商品展示样图 */
@property (strong, nonatomic) UIImageView *showImage;

/** 商品标题 */
@property (strong, nonatomic) UILabel *titleLabel;

/** 商品价格 */
@property (strong, nonatomic) UILabel *priceLabel;

/** 添加 和 展示商品数量的背景视图 */
@property (strong, nonatomic) UIImageView *bgImageView;

/** 展示商品数量 */
@property (strong, nonatomic) UILabel *goodsNumberLabel;

/** 添加商品数量按钮 */
@property (strong, nonatomic) UIButton *addBtn;

/** 减少商品数量按钮 */
@property (strong, nonatomic) UIButton *reduceBtn;


@end

@implementation WYHaveGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.checkTheBtn];
        [self addSubview:self.showImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.goodsNumberLabel];
        [self.bgImageView addSubview:self.addBtn];
        [self.bgImageView addSubview:self.reduceBtn];
    }
    return self;
}

/** 添加约束 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    
    WS(weakSelf);
    [_checkTheBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(39);
        make.left.equalTo(weakSelf.left).offset(9);
        make.size.equalTo(CGSizeMake(21, 21));
    }];
    
    [_showImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(23);
        make.left.equalTo(weakSelf.checkTheBtn.right).offset(9);
        make.size.equalTo(CGSizeMake(54, 54));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(23);
        make.left.equalTo(weakSelf.checkTheBtn.right).offset(9);
        make.size.equalTo(CGSizeMake(width - 111, 20));
    }];
    
    [_bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottom).offset(-23);
        make.right.equalTo(weakSelf.right).offset(-15);
        make.size.equalTo(CGSizeMake(83, 50));
    }];
    
    [_reduceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.bgImageView);
        make.left.equalTo(weakSelf.bgImageView.left);
        make.width.equalTo(25);
    }];
    
    [_addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.bgImageView);
        make.right.equalTo(weakSelf.bgImageView.right);
        make.width.equalTo(25);
    }];

    
    [_goodsNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.bgImageView.bottom);
        make.left.equalTo(weakSelf.reduceBtn.right);
        make.right.equalTo(weakSelf.addBtn.left);
    }];
    
    
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf.showImage.right).offset(9);
        make.right.equalTo(weakSelf.bgImageView.left).offset(-9);
        make.height.equalTo(20);
    }];
    
    
}

/** 赋值 */
- (void)setModel:(WYShoppingCarModel *)model {
    _model = model;
    
    
}

/** 懒加载 */
- (UIButton *)checkTheBtn {
    if (!_checkTheBtn) {
        _checkTheBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_checkTheBtn setBackgroundColor:[UIColor whiteColor]];
        [_checkTheBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面商品未选中"]] forState:(UIControlStateNormal)];
        [_checkTheBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面商品选中对号按钮"]] forState:(UIControlStateSelected)];
        [_checkTheBtn addTarget:self action:@selector(btnTouchActionCheckThe:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _checkTheBtn;
}

- (void)btnTouchActionCheckThe:(UIButton *)checkThe {
    
    checkThe.selected = !checkThe.selected;
}

- (UIImageView *)showImage {
    if (!_showImage) {
        _showImage = [[UIImageView alloc] init];
        [_showImage setBackgroundColor:[UIColor grayColor]];
    }
    return _showImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setBackgroundColor:[UIColor whiteColor]];
        [_priceLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _priceLabel;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面商品加减按钮"]]];
        [_bgImageView setBackgroundColor:[UIColor grayColor]];
        [_bgImageView setUserInteractionEnabled:YES];
    }
    return _bgImageView;
}

- (UILabel *)goodsNumberLabel {
    if (!_goodsNumberLabel) {
        _goodsNumberLabel = [[UILabel alloc] init];
        [_goodsNumberLabel setBackgroundColor:[UIColor whiteColor]];
        [_goodsNumberLabel setTextAlignment:(NSTextAlignmentCenter)];
        [_goodsNumberLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _goodsNumberLabel;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setTag:BTN_TAG + 1];
        [_addBtn addTarget:self action:@selector(btnTouchActionTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_reduceBtn setTag:BTN_TAG + 0];
        [_reduceBtn addTarget:self action:@selector(btnTouchActionTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _reduceBtn;
}

- (void)btnTouchActionTarget:(UIButton *)targetBtn {
    
    NSInteger btnTag = targetBtn.tag - BTN_TAG;
    
    if (0 == btnTag) {
        NSInteger number = [self.goodsNumberLabel.text integerValue];
        number --;
        [self.goodsNumberLabel setText:[NSString stringWithFormat:@"%ld",number]];
    }
    else {
        NSInteger number = [self.goodsNumberLabel.text integerValue];
        number ++;
        [self.goodsNumberLabel setText:[NSString stringWithFormat:@"%ld",number]];
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
