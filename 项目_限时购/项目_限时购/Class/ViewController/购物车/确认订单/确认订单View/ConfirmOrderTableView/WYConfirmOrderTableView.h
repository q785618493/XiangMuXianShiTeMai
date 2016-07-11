//
//  WYConfirmOrderTableView.h
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"

@interface WYConfirmOrderTableView : WYBaesTableView

/** 接收商品数据 */
@property (strong, nonatomic) NSArray *goodsArray;

@property (copy, nonatomic) TableCellBlock blockCellRow;

@end
