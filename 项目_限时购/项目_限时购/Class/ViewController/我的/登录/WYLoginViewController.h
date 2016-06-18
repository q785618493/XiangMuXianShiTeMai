//
//  WYLoginViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

/** 登录成功后回调的 block*/
typedef void(^LoginSuccessBlock)(NSArray *meModel, NSDictionary *userData, BOOL isStatu);

@interface WYLoginViewController : WYBaseViewController

@property (copy, nonatomic) LoginSuccessBlock passBackMe;

@end
