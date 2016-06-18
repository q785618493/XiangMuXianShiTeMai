//
//  WYMeModel.h
//  限时购
//
//  Created by ma c on 16/6/2.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYMeModel : NSObject <NSCoding>

/** 标题 */
@property (copy, nonatomic) NSString *title;

/** 图片名称 */
@property (copy, nonatomic) NSString *image;

/** 副标题 */
@property (copy, nonatomic) NSString *detailText;


- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)meModelDic:(NSDictionary *)dic;

@end
