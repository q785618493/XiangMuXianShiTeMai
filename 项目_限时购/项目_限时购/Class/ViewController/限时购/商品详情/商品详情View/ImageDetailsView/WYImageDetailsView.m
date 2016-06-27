//
//  WYImageDetailsView.m
//  限时购
//
//  Created by ma c on 16/5/30.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYImageDetailsView.h"
#import "UIImageView+WY_SDWedImage.h"

@implementation WYImageDetailsView

- (void)setPhotoArray:(NSArray *)photoArray {
    _photoArray = photoArray;
    
    CGFloat countArr = photoArray.count;
    
    CGFloat viewHeight = VIEW_HEIGHT * _scale * countArr;
    
    CGFloat width = self.frame.size.width;
    
    CGFloat height = viewHeight / countArr;
    
    for (NSInteger i = 0; i < countArr; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, i * height, width, height))];
        [imageView downloadImage:photoArray[i]];
        [self addSubview:imageView];
    }
    
    if (_viewHeight) {
        _viewHeight(viewHeight);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
