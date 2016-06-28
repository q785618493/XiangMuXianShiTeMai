//
//  WYConfirmOrderViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYConfirmOrderViewController : WYBaseViewController

/** 接收数据 */
@property (strong, nonatomic) NSMutableArray *dataArray;

/** 接收商品总价格 */
@property (assign, nonatomic) CGFloat goodsPrice;

@end
