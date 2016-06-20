//
//  WYFaceCollection.h
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseCollectionView.h"

@interface WYFaceCollection : WYBaseCollectionView

/** 接收数据信息 */
@property (strong, nonatomic) NSMutableArray *collArray;

/** 选中哪一个cell 回调的方法 */
@property (copy, nonatomic) CollectionCellBlock collCellRow;

@end
