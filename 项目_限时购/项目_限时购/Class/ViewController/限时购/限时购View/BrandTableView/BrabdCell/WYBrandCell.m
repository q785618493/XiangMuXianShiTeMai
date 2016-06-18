//
//  WYBrandCell.m
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBrandCell.h"
#import "WYSaleModel.h"

@interface WYBrandCell ()

/** 商品图片 */
@property (strong, nonatomic) UIImageView *commodityImage;

/** 中心位置图片 */
@property (strong, nonatomic) UIImageView *centerImage;

@end

@implementation WYBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [self addSubview:self.commodityImage];
        [_commodityImage addSubview:self.centerImage];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self controlAddMasonry];
}

/** 给控件添加约束 */
- (void)controlAddMasonry {
    WS(weakSelf);
    
    [_commodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_centerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.commodityImage).insets(UIEdgeInsetsMake(30, 60, 30, 60));
    }];
}

/** 新品团购每一行数据 重写 set方法赋值 */
- (void)setModel:(WYSaleModel *)model {
    _model = model;
    
    [_commodityImage downloadImage:model.imgView];
    [_centerImage downloadImage:model.logoImg];
}

/** 重写get方法懒加载控件 */
- (UIImageView *)commodityImage {
    if (!_commodityImage) {
        _commodityImage = [[UIImageView alloc] init];
    }
    return _commodityImage;
}

- (UIImageView *)centerImage {
    if (!_centerImage) {
        _centerImage = [[UIImageView alloc] init];
        [_centerImage setAlpha:0.8];
    }
    return _centerImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
