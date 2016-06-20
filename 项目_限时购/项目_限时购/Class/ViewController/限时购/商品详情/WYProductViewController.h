//
//  WYProductViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/20.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYProductViewController : WYBaseViewController

/** 接收商品的 ID,做网络请求参数,得到该商品的信息 */
@property (copy, nonatomic) NSString *goodsID;

/** 国旗图片的网络路径 */
@property (copy, nonatomic) NSString *countryImageUrl;

@end
