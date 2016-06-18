//
//  WYNewCell.h
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseTableCell.h"
@class WYNewsModel;

@interface WYNewCell : WYBaseTableCell

/** 接收新品团购每一行数据 */
@property (strong, nonatomic) WYNewsModel *model;

/** 保存cell 的行数 */
@property (assign, nonatomic) NSInteger cellTag;

/** cell上加入购物车按钮回调的 block */
@property (copy, nonatomic) BtnActionBlock btnTagBlock;

@end
