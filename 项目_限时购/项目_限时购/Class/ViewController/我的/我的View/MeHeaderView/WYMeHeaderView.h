//
//  WYMeHeaderView.h
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"



@interface WYMeHeaderView : WYBaseView

/** 接收用户信息的字典 */
@property (strong, nonatomic) NSDictionary *meDic;

/** 登录按钮事件回调的block */
@property (copy, nonatomic) returnBlock blockLogin;

/** 注册按钮事件回调的block */
@property (copy, nonatomic) returnBlock blockRegister;

/** 用户按钮事件回调的block */
@property (copy, nonatomic) returnBlock blockUser;

/** 没有登录的视图 */
+ (instancetype)showMeHeaderViewWidth:(CGFloat)width height:(CGFloat)height;

/** 登录成功的视图 */
+ (instancetype)userMeHeaderViewWidth:(CGFloat)width height:(CGFloat)height;

/** 移除视图 */
- (void)hiddenDeleteView;


@end
