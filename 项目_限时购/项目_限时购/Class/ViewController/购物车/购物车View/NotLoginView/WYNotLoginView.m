//
//  WYNotLoginView.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYNotLoginView.h"

@interface WYNotLoginView ()

@property (strong, nonatomic) UILabel *centerLabel;

@end

@implementation WYNotLoginView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.centerLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    [_centerLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] init];
        [_centerLabel setBackgroundColor:RGB(245, 245, 245)];
        [_centerLabel setFont:[UIFont systemFontOfSize:14]];
        [_centerLabel setTextColor:RGB(225, 75, 145)];
        [_centerLabel setText:[NSString stringWithFormat:@"尊敬的用户您尚未登录,我的酷兜登录成为会员。"]];
        [_centerLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
        [_centerLabel setNumberOfLines:11];
    }
    return _centerLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
