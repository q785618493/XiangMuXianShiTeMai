//
//  WYLoginViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

/** 登录成功后回调的 block 传输数据*/
typedef void(^LoginSuccessBlock)(NSArray *meModel, NSDictionary *userData, BOOL isStatu);

@interface WYLoginViewController : WYBaseViewController

/** 登录成功后回调的 block 传输数据*/
@property (copy, nonatomic) LoginSuccessBlock passBackMe;


@end
