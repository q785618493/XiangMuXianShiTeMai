//
//  WYMeHeaderView.m
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYMeHeaderView.h"

@interface WYMeHeaderView ()

/** 底层视图 */
@property (strong, nonatomic) UIImageView *topImageView;

/** 登录按钮 */
@property (strong, nonatomic) UIButton *loginBtn;

/** 注册按钮*/
@property (strong, nonatomic) UIButton *registerBtn;

/** 用户名称*/
@property (weak, nonatomic) UILabel *nameLabel;

/** 会员状态*/
@property (weak, nonatomic) UILabel *memberLabel;

/** 用户按钮*/
@property (strong, nonatomic) UIButton *userBtn;

/** 保存用户头像 */
@property (strong, nonatomic) UIImage *imageUser;

@end

@implementation WYMeHeaderView

/** 没有登录的视图 */
+ (instancetype)showMeHeaderViewWidth:(CGFloat)width height:(CGFloat)height {
    
    WYMeHeaderView *meView = [[self alloc] initWithFrame:(CGRectMake(0, 0, width, height))];
    [meView addSubview:meView.topImageView];
    [meView.topImageView addSubview:meView.loginBtn];
    [meView.topImageView addSubview:meView.registerBtn];
    
    return meView;
}

/** 登录成功的视图 */
+ (instancetype)userMeHeaderViewWidth:(CGFloat)width height:(CGFloat)height {
    
    WYMeHeaderView *meView = [[self alloc] initWithFrame:(CGRectMake(0, 0, width, height))];
    [meView addSubview:meView.topImageView];
    [meView.topImageView addSubview:meView.userBtn];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(150, 33, width - 175, 20))];
    [nameLabel setFont:[UIFont systemFontOfSize:15]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [meView.topImageView addSubview:nameLabel];
    meView.nameLabel = nameLabel;
    
    UILabel *memberLabel = [[UILabel alloc] initWithFrame:(CGRectMake(150, 72, width - 175, 20))];
    [memberLabel setFont:[UIFont systemFontOfSize:15]];
    [memberLabel setTextColor:[UIColor whiteColor]];
    [meView.topImageView addSubview:memberLabel];
    meView.memberLabel = memberLabel;
    
    return meView;
}

/** 移除视图 */
- (void)hiddenDeleteView {
    [self removeFromSuperview];
}

/** 重写 get方法赋值 */
- (void)setMeDic:(NSDictionary *)meDic {
    _meDic = meDic;
    
    self.nameLabel.text = meDic[@"name"];
    self.memberLabel.text = meDic[@"member"];
}

- (void)setImageUser:(UIImage *)imageUser {
    _imageUser = imageUser;
    [self.userBtn setImage:imageUser forState:(UIControlStateNormal)];
}

#pragma make- 
#pragma make- 重写 get方法懒加载控件
/** 懒加载 注册 和 登录 视图 */
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, VIEW_WIDTH, 125))];
        [_topImageView setUserInteractionEnabled:YES];
        [_topImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"我的背景"]]];
        
    }
    return _topImageView;
}

/** 懒加载登录按钮 */
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBtn setFrame:(CGRectMake(0, 0, VIEW_WIDTH * 0.5, 125))];
        [_loginBtn setTitle:[NSString stringWithFormat:@"登 录"] forState:(UIControlStateNormal)];
        [_loginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
        [_loginBtn addTarget:self action:@selector(btnTouchActionLogin:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBtn;
}

/** 登录按钮点击事件 */
- (void)btnTouchActionLogin:(UIButton *)loginBtn {
    if (_blockLogin) {
        _blockLogin();
    }
}

/** 懒加载注册按钮 */
- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_registerBtn setFrame:(CGRectMake(VIEW_WIDTH * 0.5, 0, VIEW_WIDTH * 0.5, 125))];
        [_registerBtn setTitle:[NSString stringWithFormat:@"注 册"] forState:(UIControlStateNormal)];
        [_registerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
        [_registerBtn addTarget:self action:@selector(btnTouchActionRegister:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _registerBtn;
}

/** 注册按钮点击事件 */
- (void)btnTouchActionRegister:(UIButton *)registerBtn {
    if (_blockRegister) {
        _blockRegister();
    }
}

/** 懒加载 用户按钮*/
- (UIButton *)userBtn {
    if (!_userBtn) {
        _userBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_userBtn setFrame:(CGRectMake(25, 12, 100, 100))];
        [_userBtn.layer setMasksToBounds:YES];
        [_userBtn.layer setCornerRadius:50];
        [_userBtn setImage:[UIImage imageNamed:@"headLogo"] forState:(UIControlStateNormal)];
        [_userBtn addTarget:self action:@selector(btnTouchActionUser:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _userBtn;
}
/** 用户按钮点击事件*/
- (void)btnTouchActionUser:(UIButton *)userBtn {
    
    if (_blockUser) {
        _blockUser();
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
