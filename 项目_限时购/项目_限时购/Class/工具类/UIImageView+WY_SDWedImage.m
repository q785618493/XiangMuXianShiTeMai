//
//  UIImageView+WY_SDWedImage.m
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "UIImageView+WY_SDWedImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (WY_SDWedImage)

#pragma mark SDWebImage缓存图片
- (void)downloadImage:(NSString *)url {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

#pragma mark SDWebImage缓存图片
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}



@end
