//
//  WYGoodsTableView.h
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"

/** 加入购物车按钮事件的回调 block */
typedef void(^AddShoppingBlock)(NSInteger btnTag);

@interface WYGoodsTableView : WYBaesTableView

/** 新品团购接收数据的 */
@property (strong, nonatomic) NSMutableArray *infoGoodsArray;

/** 新品团购选中哪一行cell回调的 block */
@property (copy, nonatomic) TableCellBlock goodsCellRow;

/** 加入购物车按钮事件的回调 block */
@property (copy, nonatomic) AddShoppingBlock shoppingCar;

@end
