//
//  WYDetailsCell.h
//  项目_限时购
//
//  Created by ma c on 16/6/24.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseCollectionCell.h"
@class WYQueryModel;

@interface WYDetailsCell : WYBaseCollectionCell

/** 接收数据 */
@property (strong, nonatomic) WYQueryModel *model;

@end
