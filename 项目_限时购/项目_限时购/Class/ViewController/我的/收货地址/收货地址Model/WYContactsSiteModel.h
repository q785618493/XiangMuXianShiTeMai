//
//  WYContactsSiteModel.h
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYContactsSiteModel : NSObject <NSCoding>

@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *phoneNumber;
@property (copy, nonatomic) NSString *siteInfo;
@property (assign, nonatomic) BOOL selected;

- (instancetype)initWithContactsSiteModelDict:(NSDictionary *)dict;
+ (instancetype)contactsSiteModelDict:(NSDictionary *)dict;

@end
