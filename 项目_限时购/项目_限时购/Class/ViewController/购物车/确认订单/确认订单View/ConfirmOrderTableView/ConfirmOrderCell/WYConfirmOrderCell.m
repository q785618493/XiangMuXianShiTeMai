//
//  WYConfirmOrderCell.m
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYConfirmOrderCell.h"

#import "WYShoppingCarModel.h"

@interface WYConfirmOrderCell ()

/** 商品展示图 */
@property (strong, nonatomic) UIImageView *goodsImage;

/** 商品名称 */
@property (strong, nonatomic) UILabel *titleLabel;

/** 商品价格 */
@property (strong, nonatomic) UILabel *priceLabel;

@end

@implementation WYConfirmOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [self addSubview:self.goodsImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf);
    
    CGFloat width = self.frame.size.width;
    
    [_goodsImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(10);
        make.bottom.equalTo(weakSelf.bottom).offset(-10);
        make.left.equalTo(weakSelf.left).offset(10);
        make.width.equalTo(80);
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(10);
        make.height.equalTo(40);
        make.left.equalTo(weakSelf.goodsImage.right).offset(10);
        make.right.equalTo(weakSelf.right).offset(-10);
    }];
    
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottom).offset(-10);
        make.height.equalTo(20);
        make.right.equalTo(weakSelf.right).offset(-10);
        make.left.equalTo(weakSelf.goodsImage.right).offset(10);
    }];
}

/** 赋值 */
- (void)setModel:(WYShoppingCarModel *)model {
    _model = model;
    
    [_goodsImage downloadImage:model.imgView];
    [_titleLabel setText:model.abbreviation];
    
    
    
    NSAttributedString *priceAttributed = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f",[model.price floatValue]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSAttributedString *countAttributed = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" x %@",model.goodsCount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSMutableAttributedString *muAttributed = [[NSMutableAttributedString alloc] init];
    [muAttributed insertAttributedString:priceAttributed atIndex:0];
    [muAttributed insertAttributedString:countAttributed atIndex:priceAttributed.length];
    [_priceLabel setAttributedText:muAttributed];
    
}

/** 懒加载 */
- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] init];
        [_goodsImage setBackgroundColor:[UIColor grayColor]];
    }
    return _goodsImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setTextColor:RGB(147, 147, 147)];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setBackgroundColor:[UIColor whiteColor]];
        [_priceLabel setTextAlignment:(NSTextAlignmentRight)];
    }
    return _priceLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
