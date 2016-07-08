//
//  AppDelegate.h
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/** 窗口 */
@property (strong, nonatomic) UIWindow *window;

/** 保存第三方APP跳转过来的URL */
@property (copy, nonatomic) NSString *threeString;


@end

