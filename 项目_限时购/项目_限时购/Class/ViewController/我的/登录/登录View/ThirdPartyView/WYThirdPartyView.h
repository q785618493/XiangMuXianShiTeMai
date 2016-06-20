//
//  WYThirdPartyView.h
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

/** 第三方登录按钮点击回调的 block */
typedef void(^ThreeLoginBlock)(NSInteger btnAction);

@interface WYThirdPartyView : WYBaseView

/** 第三方登录按钮点击回调的 block */
@property (copy, nonatomic) ThreeLoginBlock thirdPartyBlock;

@end
