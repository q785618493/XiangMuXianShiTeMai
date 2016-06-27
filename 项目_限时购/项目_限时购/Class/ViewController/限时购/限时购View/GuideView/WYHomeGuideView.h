//
//  WYHomeGuideView.h
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

@interface WYHomeGuideView : WYBaseView

/** 接受数据信息 */
@property (strong, nonatomic) NSArray *imageArray;

/** 立即体验按钮回调点击事件的 block */
@property (copy, nonatomic) returnBlock leamAction;

@end
