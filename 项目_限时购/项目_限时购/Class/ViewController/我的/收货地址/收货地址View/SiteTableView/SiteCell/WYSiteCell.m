//
//  WYSiteCell.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYSiteCell.h"
#import "WYContactsSiteModel.h"

@interface WYSiteCell ()

/** 用户名 */
@property (strong, nonatomic) UILabel *nameLabel;

/** 用户联系方式 */
@property (strong, nonatomic) UILabel *phoneLabel;

/** 用户收货地址 */
@property (strong, nonatomic) UILabel *siteLabel;

/** 分割线1 */
@property (strong, nonatomic) UILabel *lineLabel;

/** 分割线2 */
@property (strong, nonatomic) UILabel *wireLabel;

@end

@implementation WYSiteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.wireLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.siteLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.selectedBtn];
        [self addSubview:self.editBtn];
        [self addSubview:self.deleteBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf);
}

- (void)setModel:(WYContactsSiteModel *)model {
    _model = model;
    
    [_nameLabel setText:model.userName];
    [_phoneLabel setText:model.phoneNumber];
    [_siteLabel setText:model.siteInfo];
    [_selectedBtn setSelected:model.selected];
}

/** 懒加载 */
- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectedBtn setBackgroundColor:[UIColor whiteColor]];
        [_selectedBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -5, 0, 0))];
        [_selectedBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@""]] forState:(UIControlStateNormal)];
        [_selectedBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@""]] forState:(UIControlStateSelected)];
    }
    return _selectedBtn;
}

- (UILabel *)siteLabel {
    if (!_siteLabel) {
        _siteLabel = [[UILabel alloc] init];
        [_siteLabel setBackgroundColor:[UIColor whiteColor]];
        [_siteLabel setFont:[UIFont systemFontOfSize:14]];
        [_siteLabel setNumberOfLines:0];
    }
    return _siteLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        [_phoneLabel setBackgroundColor:[UIColor whiteColor]];
        [_phoneLabel setFont:[UIFont systemFontOfSize:14]];
        [_phoneLabel setTextAlignment:(NSTextAlignmentRight)];
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setBackgroundColor:[UIColor whiteColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _nameLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        [_lineLabel setBackgroundColor:RGB(184, 184, 184)];
    }
    return _lineLabel;
}

- (UILabel *)wireLabel {
    if (!_wireLabel) {
        _wireLabel = [[UILabel alloc] init];
        [_wireLabel setBackgroundColor:RGB(245, 245, 245)];
    }
    return _wireLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
