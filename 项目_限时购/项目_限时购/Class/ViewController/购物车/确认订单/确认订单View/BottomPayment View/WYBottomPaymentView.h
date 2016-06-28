//
//  WYBottomPaymentView.h
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

@interface WYBottomPaymentView : WYBaseView

/** 接收商品价格信息 */
@property (assign, nonatomic) CGFloat price;

/** 立即支付按钮点击事件回调的 block */
@property (copy, nonatomic) returnBlock blockPayment;

@end
