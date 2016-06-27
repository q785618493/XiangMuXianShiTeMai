//
//  WYHomeGuideView.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYHomeGuideView.h"
#import "MTool.h"

@interface WYHomeGuideView () <UIScrollViewDelegate>

@property (weak, nonatomic) UIPageControl *pageControl;

@property (weak, nonatomic) UIScrollView *guideScrollView;

@end

@implementation WYHomeGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *guideView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [guideView setShowsHorizontalScrollIndicator:NO];
        [guideView setShowsVerticalScrollIndicator:NO];
        [guideView setBounces:NO];
        [guideView setDelegate:self];
        [guideView setPagingEnabled:YES];
        [guideView setContentOffset:(CGPointZero)];
        [self addSubview:guideView];
        self.guideScrollView = guideView;
        
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    
    [self.guideScrollView setContentSize:(CGSizeMake(VIEW_WIDTH * imageArray.count, VIEW_HEIGHT))];
    
    for (NSInteger i = 0; i < imageArray.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(i * VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT))];
        [imageView setUserInteractionEnabled:YES];
        [imageView setImage:[UIImage imageNamed:imageArray[i]]];
        [self.guideScrollView addSubview:imageView];
        
        if (i == imageArray.count - 1) {
            
            UIButton *useBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [useBtn setFrame:(CGRectMake(0, VIEW_HEIGHT - 35 * [MTool getScreenHightscale] * 2.8, 187 / 7.0 * 5.0 * [MTool getScreenWidthscale], 62 / 7.0 * 5 * [MTool getScreenHightscale]))];
            useBtn.center = CGPointMake(self.center.x, useBtn.center.y);
            [useBtn.layer setCornerRadius:10];
            [useBtn setImage:[UIImage imageNamed:@"立即体验"] forState:(UIControlStateNormal)];
            [useBtn addTarget:self action:@selector(btnTouchActionUse:) forControlEvents:(UIControlEventTouchUpInside)];
            [imageView addSubview:useBtn];
        }
    }
    
    UIPageControl *pageC = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, VIEW_HEIGHT - 20, VIEW_WIDTH, 10))];
    [pageC setNumberOfPages:imageArray.count];
    [pageC setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageC setPageIndicatorTintColor:[UIColor whiteColor]];
    [pageC setCurrentPage:0];
    [pageC  setUserInteractionEnabled:NO];
    [self addSubview:pageC];
    self.pageControl = pageC;
}

/** 立即体验按钮的点击事件 */
- (void)btnTouchActionUse:(UIButton *)useBtn  {
    if (_leamAction) {
        _leamAction();
    }
}

#pragma make-
#pragma make- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / VIEW_WIDTH;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
