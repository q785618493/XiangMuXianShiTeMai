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

- (void)downloadImage:(NSString *)url {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

@end
