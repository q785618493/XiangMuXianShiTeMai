//
//  WYModifySiteViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"
@class WYContactsSiteModel;

typedef void(^ReturnModifyNewsBlock)(WYContactsSiteModel *model);

@interface WYModifySiteViewController : WYBaseViewController

/** 接收要修改的数据 */
@property (strong, nonatomic) WYContactsSiteModel *model;

/** 返回修改后的数据 */
@property (copy, nonatomic) ReturnModifyNewsBlock blockModify;

@end
