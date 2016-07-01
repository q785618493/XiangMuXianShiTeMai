//
//  WYTopConfirmView.h
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

@class WYContactsSiteModel;

/** 返回当前地址信息的 block */
typedef void(^ReturnSiteInfoBlock)(WYContactsSiteModel *currentModel);

@interface WYTopConfirmView : WYBaseView

/** 接收数据 */
@property (strong, nonatomic) WYContactsSiteModel *model;

/** 定位按钮回调的 block */
@property (copy, nonatomic) returnBlock blockLocate;

/** 返回当前地址信息的 block */
@property (copy, nonatomic) ReturnSiteInfoBlock blockSiteInfo;

@end
