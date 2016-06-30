//
//  WYNewsSiteViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"
@class WYContactsSiteModel;

typedef void(^BackNewsModelBlock)(WYContactsSiteModel *model);

@interface WYNewsSiteViewController : WYBaseViewController

/** 回调保存新收货地址的 block */
@property (copy, nonatomic) BackNewsModelBlock blockBack;

@end
