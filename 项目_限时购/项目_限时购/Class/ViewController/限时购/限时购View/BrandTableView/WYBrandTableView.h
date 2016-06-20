//
//  WYBrandTableView.h
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaesTableView.h"

@interface WYBrandTableView : WYBaesTableView

/** 品牌团购接收数据的 */
@property (strong, nonatomic) NSMutableArray *infoBrandArray;

/** 品牌团购选中哪一行cell回调的 block */
@property (copy, nonatomic) TableCellBlock brandCellRow;

@end
