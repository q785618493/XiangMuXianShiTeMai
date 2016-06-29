//
//  WYDetailsCell.m
//  项目_限时购
//
//  Created by ma c on 16/6/24.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYDetailsCell.h"
#import "WYQueryModel.h"

@interface WYDetailsCell ()

/** 国旗 */
@property (strong, nonatomic) UIImageView *countryImage;

/** 商品 */
@property (strong, nonatomic) UIImageView *goodsImage;

/** 商品名信息 */
@property (strong, nonatomic) UILabel *titleLabel;

/** 价格信息 */
@property (strong, nonatomic) UILabel *priceLabel;

@end

@implementation WYDetailsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.goodsImage];
        [self.goodsImage addSubview:self.countryImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /** 给控件添加约束 */
    [self controlAddMasonry];
}

/** 给控件添加约束 */
- (void)controlAddMasonry {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    WS(weakSelf);
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView).with.insets(UIEdgeInsetsMake(0, 0, 70, 0));
    }];
    
    [_countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.goodsImage).with.insets(UIEdgeInsetsMake(10, 10, width - 27, width - 33));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodsImage.bottom).offset(10);
        make.left.equalTo(weakSelf.contentView.left).offset(10);
        make.right.equalTo(weakSelf.contentView.right).offset(-10);
        make.bottom.equalTo(weakSelf.contentView.bottom).offset(-20);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView).with.insets(UIEdgeInsetsMake(height - 20, 0, 0, 0));
    }];
}

/** 重写set方法赋值 */
- (void)setModel:(WYQueryModel *)model {
    _model = model;
    
    [self.countryImage downloadImage:model.CountryImg];
    [self.goodsImage downloadImage:model.ImgView];
    [self.titleLabel setText:model.Title];
    
    NSAttributedString *priceAttribute = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",model.Price] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : RGB(255, 67, 0)}];
    
    NSAttributedString *domesticAttribute = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.DomesticPrice] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],NSForegroundColorAttributeName : RGB(169, 169, 169),NSStrikethroughStyleAttributeName:@(1)}];
    
    
    NSMutableAttributedString *muAttString = [[NSMutableAttributedString alloc] init];
    [muAttString insertAttributedString:priceAttribute atIndex:0];
    [muAttString insertAttributedString:domesticAttribute atIndex:priceAttribute.length];
    
    [self.priceLabel setAttributedText:muAttString];
}

/** 重写get方法懒加载 */
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setBackgroundColor:[UIColor whiteColor]];
        [_priceLabel setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _priceLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}

- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage= [[UIImageView alloc] init];
        [_goodsImage setBackgroundColor:[UIColor grayColor]];
    }
    return _goodsImage;
}

- (UIImageView *)countryImage {
    if (!_countryImage) {
        _countryImage = [[UIImageView alloc] init];
        [_countryImage setBackgroundColor:[UIColor whiteColor]];
    }
    return _countryImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
