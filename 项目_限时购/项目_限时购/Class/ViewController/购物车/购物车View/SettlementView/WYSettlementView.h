//
//  WYSettlementView.h
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

@interface WYSettlementView : WYBaseView

/** 接收价格 */
@property (copy, nonatomic) NSString *moneyText;

/** 去结算按钮回调的 block */
@property (copy, nonatomic) returnBlock blockPayment;

@end
