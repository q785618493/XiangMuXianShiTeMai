//
//  WYFlashSaleViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYFlashSaleViewController.h"

#import "TopRollView.h"
#import "WYTwoBtnView.h"

#define WIDTH  self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface WYFlashSaleViewController () <UIScrollViewDelegate>

/** 底层的 scrollView */
@property (strong, nonatomic) UIScrollView *rollScrollView;

/** 顶部广告轮播视图 */
@property (strong, nonatomic) TopRollView *adView;

/** 新品和品牌购按钮的视图 */
@property (strong, nonatomic) WYTwoBtnView *twoBtnView;

/** 顶部轮播视图的 比例高度 */
@property (assign, nonatomic) CGFloat scale;

@end

@implementation WYFlashSaleViewController

/** 重写 get方法懒加载控件 */
- (UIScrollView *)rollScrollView {
    if (!_rollScrollView) {
        _rollScrollView = [[UIScrollView alloc] init];
        [_rollScrollView setDelegate:self];
        [_rollScrollView setBounces:NO];
        [_rollScrollView setShowsVerticalScrollIndicator:NO];
        [_rollScrollView setShowsHorizontalScrollIndicator:NO];
        [_rollScrollView setContentSize:(CGSizeMake(WIDTH, HEIGHT - 64 - 49 + _scale))];
    }
    return _rollScrollView;
}

- (WYTwoBtnView *)twoBtnView {
    if (!_twoBtnView) {
        _twoBtnView = [[WYTwoBtnView alloc] init];
        [_twoBtnView.NewBtn addTarget:self action:@selector(btnTouchActionNew:) forControlEvents:(UIControlEventTouchUpInside)];
        [_twoBtnView.BrandBtn addTarget:self action:@selector(btnTouchActionBrand:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _twoBtnView;
}

/** 新品按钮点击事件 */
- (void)btnTouchActionNew:(UIButton *)newBtn {
    
    [newBtn setSelected:YES];
    [self.twoBtnView.BrandBtn setSelected:NO];
}

/** 品牌团购点击事件 */
- (void)btnTouchActionBrand:(UIButton *)brandBtn {
    
    [brandBtn setSelected:YES];
    [self.twoBtnView.NewBtn setSelected:NO];
}

- (TopRollView *)adView {
    if (!_adView) {
        _adView = [[TopRollView alloc] initWithFrame:(CGRectMake(0, 0, WIDTH, _scale))];
    }
    return _adView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scale = 232 / 667.0 * HEIGHT;
    /** 添加控件和约束 */
    [self controlScrollViewMasonry];
    
    
}

/** 添加控件和约束 */
- (void)controlScrollViewMasonry {
    
    [self.view addSubview:self.rollScrollView];
    
    WS(weakSelf);
    [_rollScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    [self.rollScrollView addSubview:self.twoBtnView];
    [_twoBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.rollScrollView).offset(_scale);
        make.left.mas_equalTo(weakSelf.rollScrollView);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 50));
    }];
    
    [self.rollScrollView addSubview:self.adView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
