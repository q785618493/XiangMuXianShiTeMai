//
//  WYTextFieldView.h
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

/** 当前视图注册按钮点击回调的 Block */
typedef void(^TextFieldBtnBlock)();

/** 当前视图登录按钮点击回调的 Block  */
typedef void(^UserAndCodeBlock)(NSString *userText, NSString *codeText);

@interface WYTextFieldView : WYBaseView

/** 保存数据信息的 Dictionary*/
@property (strong, nonatomic) NSDictionary *dataDic;

/** 登录按钮点击回调的 Block */
@property (copy, nonatomic) UserAndCodeBlock loginBlock;

/** 注册按钮点击回调的 Block */
@property (copy, nonatomic) TextFieldBtnBlock registerBlock;

@end
