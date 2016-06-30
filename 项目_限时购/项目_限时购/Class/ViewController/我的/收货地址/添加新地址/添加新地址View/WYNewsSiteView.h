//
//  WYNewsSiteView.h
//  项目_限时购
//
//  Created by ma c on 16/6/30.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

@class WYContactsSiteModel;
typedef void(^BackUserSiteInfoBlock)(WYContactsSiteModel *model);

@interface WYNewsSiteView : WYBaseView

/** 回调用户添加新的地址信息 */
@property (copy, nonatomic) BackUserSiteInfoBlock blockUserSite;

/** 接收修改数据 */
@property (strong, nonatomic) WYContactsSiteModel *model;

@end
