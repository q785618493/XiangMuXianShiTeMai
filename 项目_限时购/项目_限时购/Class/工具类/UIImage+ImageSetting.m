//
//  UIImage+ImageSetting.m
//  彩票
//
//  Created by ma c on 16/5/25.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "UIImage+ImageSetting.h"

@implementation UIImage (ImageSetting)

+ (instancetype)imageWithModeImageName:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 创建位图上下文（指定将来创建出来的bitmap的大小）
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color填充上下文的颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
