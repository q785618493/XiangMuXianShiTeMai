//
//  WYDetailsClassfyViewController.h
//  项目_限时购
//
//  Created by ma c on 16/6/22.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYDetailsClassfyViewController : WYBaseViewController

/** 接收搜索的商品名 */
@property (copy, nonatomic) NSString *goodsName;

/** 用于接收商品分类的 ID用作网络请求的参数 */
@property (copy, nonatomic) NSString *typeID;

/** 用来判断是否开始网络请求 */
@property (assign, nonatomic, getter = isStart) BOOL start;

/** 用于判断 网络请求详情 */
@property (assign, nonatomic) NSInteger judgeRequest;

@end
