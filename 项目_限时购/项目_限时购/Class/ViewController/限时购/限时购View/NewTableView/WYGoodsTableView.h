//
//  WYGoodsTableView.h
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"


@interface WYGoodsTableView : WYBaesTableView

/** 新品团购接收数据的 */
@property (strong, nonatomic) NSMutableArray *infoGoodsArray;

/** 新品团购选中哪一行cell回调的 block */
@property (copy, nonatomic) TableCellBlock goodsCellRow;


@end
