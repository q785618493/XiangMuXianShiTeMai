//
//  UIImageView+WY_SDWedImage.m
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "UIImageView+WY_SDWedImage.h"
#import "UIImageView+WebCache.h"

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

#pragma mark SDWebImage图片下载进度
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place
              success:(DownloadSuccessBlock)success
              failure:(DownloadFailureBlock)failure
             received:(DownloadProgressBlock)progress {
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageLowPriority | SDWebImageRetryFailed  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (receivedSize && expectedSize) {
            progress(receivedSize, expectedSize);
        }
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            failure(error);
        }else{
            self.image = image;
            success(finished, cacheType, image);
        }
    }];
}

@end
