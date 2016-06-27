//
//  WYHaveGoodsCell.h
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseTableCell.h"
@class WYShoppingCarModel;

@interface WYHaveGoodsCell : WYBaseTableCell

/** 接收模型数据 */
@property (strong, nonatomic) WYShoppingCarModel *model;

@end
