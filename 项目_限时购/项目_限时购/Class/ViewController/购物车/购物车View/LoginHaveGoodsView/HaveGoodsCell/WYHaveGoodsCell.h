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

/** 勾选商品按钮 */
@property (strong, nonatomic) UIButton *checkTheBtn;

/** 添加商品数量按钮 */
@property (strong, nonatomic) UIButton *addBtn;

/** 减少商品数量按钮 */
@property (strong, nonatomic) UIButton *reduceBtn;

@end
