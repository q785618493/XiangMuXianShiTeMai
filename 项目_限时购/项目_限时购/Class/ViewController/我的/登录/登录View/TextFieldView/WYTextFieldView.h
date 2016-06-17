//
//  WYTextFieldView.h
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

/** 当前视图按钮点击回调的 Block */
typedef void(^TextFieldBtnBlock)();

@interface WYTextFieldView : WYBaseView

/** 登录按钮点击回调的 Block */
@property (copy, nonatomic) TextFieldBtnBlock loginBlock;

/** 注册按钮点击回调的 Block */
@property (copy, nonatomic) TextFieldBtnBlock registerBlock;

@end
