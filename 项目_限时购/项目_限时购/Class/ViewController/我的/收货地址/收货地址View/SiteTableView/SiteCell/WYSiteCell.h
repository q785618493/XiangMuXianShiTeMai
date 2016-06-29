//
//  WYSiteCell.h
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseTableCell.h"
@class WYContactsSiteModel;

@interface WYSiteCell : WYBaseTableCell

/** 接收数据 */
@property (strong, nonatomic) WYContactsSiteModel *model;

/** 默认选中按钮 */
@property (strong, nonatomic) UIButton *selectedBtn;

/** 编辑按钮 */
@property (strong, nonatomic) UIButton *editBtn;

/** 删除按钮 */
@property (strong, nonatomic) UIButton *deleteBtn;


@end
