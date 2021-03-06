//
//  WYDetailsCollectionView.h
//  项目_限时购
//
//  Created by ma c on 16/6/24.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseCollectionView.h"

@interface WYDetailsCollectionView : WYBaseCollectionView

/** 接收数据 */
@property (strong, nonatomic) NSArray *infoArray;

/** 选中cell回调 */
@property (copy, nonatomic) CollectionCellBlock collRow;

@end
