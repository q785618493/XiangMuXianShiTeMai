//
//  WYMeTableView.h
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"

@interface WYMeTableView : WYBaesTableView

/** 接收数据信息的 数组 */
@property (strong, nonatomic) NSArray *infoArray;

/** 选中行回调的 block */
@property (copy, nonatomic) TableCellBlock meCellRow;

@end
