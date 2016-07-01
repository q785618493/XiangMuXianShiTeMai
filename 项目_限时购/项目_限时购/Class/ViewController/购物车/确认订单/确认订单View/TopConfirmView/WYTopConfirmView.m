//
//  WYTopConfirmView.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYTopConfirmView.h"
#import "WYContactsSiteModel.h"

#import "NSString+Helper.h"

@interface WYTopConfirmView ()

/** 背景图 */
@property (strong, nonatomic) UIImageView *bgImageView;

/** 定位按钮 */
@property (strong, nonatomic) UIButton *seatBtn;

/** 收货人 */
@property (strong, nonatomic) UILabel *cargoLabel;

/** 用户名展示 */
@property (strong, nonatomic) UILabel *nameLabel;

/** 用户电话号码展示 */
@property (strong, nonatomic) UILabel *phoneLabel;

/** 收货地址 */
@property (strong, nonatomic) UILabel *profileLabel;

/** 用户输入地址 */
@property (strong, nonatomic) UILabel *addressLabel;

@end

@implementation WYTopConfirmView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.seatBtn];
        [self.bgImageView addSubview:self.cargoLabel];
        [self.bgImageView addSubview:self.nameLabel];
        [self.bgImageView addSubview:self.phoneLabel];
        [self.bgImageView addSubview:self.profileLabel];
        [self.bgImageView addSubview:self.addressLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    [_bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
    [_seatBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImageView.top).offset(24);
        make.bottom.equalTo(weakSelf.bgImageView.bottom).offset(-24);
        make.left.equalTo(weakSelf.bgImageView.left).offset(10);
        make.width.equalTo(48);
    }];
    
    [_cargoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImageView.top).offset(10);
        make.left.equalTo(weakSelf.seatBtn.right);
        make.size.equalTo(CGSizeMake(49, 20));
    }];
    
    [_phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImageView.top).offset(10);
        make.right.equalTo(weakSelf.bgImageView.right).offset(-10);
        make.size.equalTo(CGSizeMake(110, 20));
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.cargoLabel.centerY);
        make.height.equalTo(20);
        make.left.equalTo(weakSelf.cargoLabel.right);
        make.right.equalTo(weakSelf.phoneLabel);
    }];
    
    [_profileLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bgImageView.bottom).offset(-70);
        make.left.equalTo(weakSelf.seatBtn.right);
        make.size.equalTo(CGSizeMake(61, 20));
    }];
    
    [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.profileLabel.top);
        make.left.equalTo(weakSelf.profileLabel.right);
        make.right.equalTo(weakSelf.bgImageView.right).offset(-10);
    }];
    
    WYContactsSiteModel *model = [[WYContactsSiteModel alloc] init];
    model.userName = _nameLabel.text;
    model.phoneNumber = _phoneLabel.text;
    model.siteInfo = _addressLabel.text;
    
    if (_blockSiteInfo) {
        _blockSiteInfo(model);
    }
}

- (void)setModel:(WYContactsSiteModel *)model {
    _model = model;
    [_nameLabel setText:model.userName];
    [_phoneLabel setText:model.phoneNumber];
    [_addressLabel setText:model.siteInfo];
    
    CGFloat widthAddress = self.frame.size.width - 129;
    
    CGFloat heightAddress = [NSString autoHeightWithString:model.siteInfo Width:widthAddress Font:[UIFont systemFontOfSize:15]];
    
    [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(heightAddress);
    }];
    
    if (_blockSiteInfo) {
        _blockSiteInfo(model);
    }
}

/** 懒加载 */
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setBackgroundColor:RGB(253, 249, 246)];
        [_addressLabel setFont:[UIFont systemFontOfSize:14]];
        [_addressLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
        [_addressLabel setTextAlignment:(NSTextAlignmentLeft)];
        [_addressLabel setNumberOfLines:0];
    }
    return _addressLabel;
}

- (UILabel *)profileLabel {
    if (!_profileLabel) {
        _profileLabel = [[UILabel alloc] init];
        [_profileLabel setFont:[UIFont systemFontOfSize:14]];
        [_profileLabel setBackgroundColor:RGB(253, 249, 246)];
        [_profileLabel setText:[NSString stringWithFormat:@"收货地址:"]];
    }
    return _profileLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        [_phoneLabel setBackgroundColor:RGB(253, 249, 246)];
        [_phoneLabel setFont:[UIFont systemFontOfSize:14]];
        [_phoneLabel setTextAlignment:(NSTextAlignmentRight)];
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setBackgroundColor:RGB(253, 249, 246)];
        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _nameLabel;
}

- (UILabel *)cargoLabel {
    if (!_cargoLabel) {
        _cargoLabel = [[UILabel alloc] init];
        [_cargoLabel setBackgroundColor:RGB(253, 249, 246)];
        [_cargoLabel setFont:[UIFont systemFontOfSize:14]];
        [_cargoLabel setText:[NSString stringWithFormat:@"收货人:"]];
    }
    return _cargoLabel;
}

- (UIButton *)seatBtn {
    if (!_seatBtn) {
        _seatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_seatBtn setBackgroundColor:RGB(253, 249, 246)];
        [_seatBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"位置"]] forState:(UIControlStateNormal)];
        [_seatBtn addTarget:self action:@selector(btnTouchActionSeat) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _seatBtn;
}

- (void)btnTouchActionSeat {
    if (_blockLocate) {
        _blockLocate();
    }
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        [_bgImageView setUserInteractionEnabled:YES];
        [_bgImageView setBackgroundColor:RGB(253, 249, 246)];
        [_bgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"地址背景"]]];
    }
    return _bgImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
