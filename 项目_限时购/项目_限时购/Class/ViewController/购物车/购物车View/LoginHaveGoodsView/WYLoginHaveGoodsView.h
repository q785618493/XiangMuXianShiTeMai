//
//  WYLoginHaveGoodsView.h
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"

/** 购物车修改商品 回调的block */
typedef void(^GoodsPriceBlock)(NSMutableArray *muArray);

@interface WYLoginHaveGoodsView : WYBaesTableView

/** 接收购物车数据 */
@property (strong, nonatomic) NSMutableArray *goodsMuArray;

/** 购物车修改商品 回调的block */
@property (copy, nonatomic) GoodsPriceBlock blockPrice;

@end
