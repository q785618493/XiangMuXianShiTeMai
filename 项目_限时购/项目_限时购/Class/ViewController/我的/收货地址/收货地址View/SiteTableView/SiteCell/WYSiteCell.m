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
    [_wireLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(5);
    }];
    
    [_phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.top).offset(10);
        make.right.equalTo(weakSelf.right).offset(-10);
        make.size.equalTo(CGSizeMake(140, 20));
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneLabel.centerY);
        make.height.equalTo(20);
        make.left.equalTo(weakSelf.left).offset(10);
        make.right.equalTo(weakSelf.phoneLabel.left);
    }];
    
    [_siteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.bottom).offset(10);
        make.height.equalTo(40);
        make.left.equalTo(weakSelf.left).offset(10);
        make.right.equalTo(weakSelf.right).offset(-10);
    }];
    
    [_lineLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.siteLabel.bottom).offset(10);
        make.height.equalTo(1);
        make.left.equalTo(weakSelf.left).offset(5);
        make.right.equalTo(weakSelf.right).offset(-5);
    }];
    
    [_selectedBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.bottom);
        make.bottom.equalTo(weakSelf.wireLabel.top);
        make.left.equalTo(weakSelf.left).offset(10);
        make.width.equalTo(110);
    }];
    
    [_deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.selectedBtn.centerY);
        make.height.equalTo(weakSelf.selectedBtn.height);
        make.right.equalTo(weakSelf.right).offset(-10);
        make.width.equalTo(60);
    }];
    
    [_editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.selectedBtn.centerY);
        make.height.equalTo(weakSelf.selectedBtn.height);
        make.right.equalTo(weakSelf.deleteBtn.left).offset(-20);
        make.width.equalTo(60);
    }];
}

- (void)setCellTag:(NSInteger)cellTag {
    _cellTag = cellTag;
    
    [_selectedBtn setTag:cellTag + 1000];
    [_editBtn setTag:cellTag + 2000];
    [_deleteBtn setTag:cellTag + 3000];
}

- (void)setModel:(WYContactsSiteModel *)model {
    _model = model;
    
    [_nameLabel setText:model.userName];
    [_phoneLabel setText:model.phoneNumber];
    [_siteLabel setText:model.siteInfo];
    [_selectedBtn setSelected:model.selected];
}

/** 懒加载 */
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [_deleteBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [_deleteBtn setTitle:[NSString stringWithFormat:@"编辑"] forState:(UIControlStateNormal)];
        [_deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _deleteBtn;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_editBtn setBackgroundColor:[UIColor whiteColor]];
        [_editBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [_editBtn setTitle:[NSString stringWithFormat:@"编辑"] forState:(UIControlStateNormal)];
        [_editBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _editBtn;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectedBtn setBackgroundColor:[UIColor whiteColor]];
        [_selectedBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -5, 0, 0))];
        [_selectedBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面商品未选中"]] forState:(UIControlStateNormal)];
        [_selectedBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"购物车界面商品选中对号按钮"]] forState:(UIControlStateSelected)];
        [_selectedBtn.titleLabel
          setFont:[UIFont systemFontOfSize:14]];
        [_selectedBtn setTitle:[NSString stringWithFormat:@"设为默认"] forState:(UIControlStateNormal)];
        [_selectedBtn setTitle:[NSString stringWithFormat:@"默认地址"] forState:(UIControlStateSelected)];
        [_selectedBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
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
