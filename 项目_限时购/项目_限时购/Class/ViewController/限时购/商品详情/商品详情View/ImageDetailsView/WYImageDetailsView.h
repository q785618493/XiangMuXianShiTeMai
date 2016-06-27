//
//  WYImageDetailsView.h
//  限时购
//
//  Created by ma c on 16/5/30.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"


/** 返回自身高度的 block */
typedef void(^ReturnHeightBlock)(CGFloat height);

@interface WYImageDetailsView : WYBaseView

/** 接收图片比例 */
@property (assign, nonatomic) CGFloat scale;

/** 接收商品图片详情数据 */
@property (strong, nonatomic) NSArray *photoArray;

/** 返回自身高度的 block */
@property (copy, nonatomic) ReturnHeightBlock viewHeight;

@end
