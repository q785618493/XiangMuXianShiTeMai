//
//  UIImageView+WY_SDWedImage.h
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WY_SDWedImage)

/**
 *  SDWebImage 下载并缓存图片
 *
 *  @param url 图片的url
 *
 */
- (void)downloadImage:(NSString *)url;

@end
