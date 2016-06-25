//
//  WYProductViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/20.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYProductViewController.h"

#import "TopRollView.h"
#import "WYCenterView.h"
#import "WYGoodsScoreView.h"
#import "WYImageDetailsView.h"
#import "WYProductTableView.h"

#import "WYAllGoodsModel.h"
#import "WYScoreModel.h"
#import "WYGoodsDetailsModel.h"
#import "WYAllDetailsModel.h"

#define WIDTH  self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface WYProductViewController () <UMSocialUIDelegate>

/** 底层的承载视图 */
@property (strong, nonatomic) UIScrollView *bgScrollView;

/** 顶部轮播广告视图 */
@property (strong, nonatomic) TopRollView *adView;

/** 广告视图下面的商品信息价格视图 */
@property (strong, nonatomic) WYCenterView *thePriceView;

/** 文字详情展示视图 */
@property (strong, nonatomic) WYProductTableView *productTbaleView;

/** 图片展示视图 */
@property (strong, nonatomic) WYImageDetailsView *imageDetailsView;

/** 商品评分视图 */
@property (strong, nonatomic) WYGoodsScoreView *goodsScoreView;
@end

@implementation WYProductViewController

/** 懒加载 */
- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 64, WIDTH, HEIGHT - 108))];
        [_bgScrollView setShowsHorizontalScrollIndicator:NO];
        [_bgScrollView setShowsVerticalScrollIndicator:NO];
        [_bgScrollView setBounces:NO];
        [_bgScrollView setBackgroundColor:[UIColor whiteColor]];
        [_bgScrollView setContentOffset:(CGPointZero)];
        [_bgScrollView setContentSize:(CGSizeMake(WIDTH, 2000))];
    }
    return _bgScrollView;
}

- (TopRollView *)adView {
    if (!_adView) {
        _adView = [[TopRollView alloc] initWithFrame:(CGRectMake(0, 0, WIDTH, 320))];
    }
    return _adView;
}

- (WYCenterView *)thePriceView {
    if (!_thePriceView) {
        _thePriceView = [[WYCenterView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.adView.frame), WIDTH, 251))];
        _thePriceView.countryUrl = _countryImageUrl;
    }
    return _thePriceView;
}

- (WYProductTableView *)productTbaleView {
    if (!_productTbaleView) {
        _productTbaleView = [[WYProductTableView alloc] initWithFrame:(CGRectMake(0, -CGRectGetMaxY(self.thePriceView.frame), WIDTH, 358)) style:(UITableViewStyleGrouped)];
    }
    return _productTbaleView;
}

- (WYImageDetailsView *)imageDetailsView {
    if (!_imageDetailsView) {
        _imageDetailsView = [[WYImageDetailsView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.productTbaleView.frame), WIDTH, HEIGHT))];
    }
    return _imageDetailsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加控件 和 约束 */
    [self controlAddView];
    /** 添加导航条上的三个按钮 */
    [self navigationAddThreeBarBtnItem];
    
    /** 商品所有图片列表网络请求 */
    [self httpGetGoodsImagesRequest];
    /** 商品详情部分（包含价格，评分等）网络请求*/
    [self httpGetAllGoodsDetailsRequest];
    
}

/** 添加控件 和 约束 */
- (void)controlAddView {
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.adView];
    [self.bgScrollView addSubview:self.thePriceView];
    
    WS(weakSelf);
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor:RGB(245, 245, 245)];
    [self.view addSubview:bottomView];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    [lineLabel setBackgroundColor:RGB(213, 213, 213)];
    [bottomView addSubview:lineLabel];
    
    /**     购物车按钮     */
    UIButton *shoppingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shoppingBtn setImage:[UIImage imageNamed:@"详情界面购物车按钮"] forState:(UIControlStateNormal)];
    [shoppingBtn addTarget:self action:@selector(btnTouchActionShopping) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:shoppingBtn];
    
    
    /**     加入购物车按钮     */
    UIButton *addCartBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addCartBtn setImage:[UIImage imageNamed:@"详情界面加入购物车按钮"] forState:(UIControlStateNormal)];
    [addCartBtn addTarget:self action:@selector(btnTouchActionAddCart) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:addCartBtn];
    
    /**     立即购买按钮     */
    UIButton *buyNowBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [buyNowBtn setImage:[UIImage imageNamed:@"详情界面立即购买按钮"] forState:(UIControlStateNormal)];
    [buyNowBtn addTarget:self action:@selector(btnTouchActionBuyNow) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:buyNowBtn];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(HEIGHT - 44, 0, 0, 0));
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bottomView).with.insets(UIEdgeInsetsMake(0, 0, 43, 0));
    }];
    
    [shoppingBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(9);
        make.left.equalTo(bottomView).offset(15);
        make.size.equalTo(CGSizeMake(26, 26));
    }];
    
    CGFloat width = (WIDTH - 105) * 0.5;
    
    [addCartBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(5);
        make.bottom.equalTo(bottomView).offset(-5);
        make.left.equalTo(shoppingBtn.right).offset(34);
        make.width.equalTo(width);
    }];
    
    [buyNowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(5);
        make.bottom.equalTo(bottomView).offset(-5);
        make.right.equalTo(bottomView.right).offset(-15);
        make.width.equalTo(width);
    }];
}

/** 购物车按钮点击事件 */
- (void)btnTouchActionShopping {
    
}

/** 加入购物车按钮点击事件 */
- (void)btnTouchActionAddCart {
    
}

/** 立即购买按钮点击事件 */
- (void)btnTouchActionBuyNow {
    
}

/** 商品所有图片列表网络请求 */
- (void)httpGetGoodsImagesRequest {
    
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appGoods/findGoodsImgList.do"] progressDic:@{@"GoodsId":self.goodsID} success:^(id JSON) {
        
        NSArray *dataArray = (NSArray *)JSON;
        
        if (dataArray.count > 0) {
            
            /** 保存全部 商品所有图片列表数据的数组 */
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            
            /** 保存 imgType 1.轮播位图片 的数组  */
            NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            
            /** 保存 imgType 2.详情图片 的数组 */
            NSMutableArray *detailsImageArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            
            /** 保存 imgType 2.详情图片的高度数据 */
            NSMutableArray *detailsHeightArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            
            /**  保存 imgType 3.实拍图片 的数组 */
            NSMutableArray *topsImageArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            
            for (NSDictionary *dic in dataArray) {
                WYAllGoodsModel *model = [[WYAllGoodsModel alloc] initWithDictionary:dic];
                [muArray addObject:model];
                
                switch ([model.imgType integerValue]) {
                    case 1: {
                        [imageArray addObject:model.imgView];
                    }
                        break;
                    case 2: {
                        [detailsImageArray addObject:model.imgView];
                        [detailsHeightArray addObject:[NSNumber numberWithInteger:model.resolution]];
                    }
                        break;
                    case 3: {
                        [topsImageArray addObject:model.imgView];
                    }
                    default:
                        break;
                }
            }
            
            weakSelf.adView.arrayImages = imageArray;
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:[NSString stringWithFormat:@"没有该商品图片"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
            });
        }
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"====%@",error);
    }];
}

/** 商品详情部分（包含价格，评分等）网络请求*/
- (void)httpGetAllGoodsDetailsRequest {
    
    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appGoods/findGoodsDetail.do"] progressDic:@{@"GoodsId":self.goodsID} success:^(id JSON) {
        
        NSDictionary *infoDict = (NSDictionary *)JSON;
        
        if (infoDict) {
            
            WYAllDetailsModel *model = [[WYAllDetailsModel alloc] initWithDictionary:infoDict];
            weakSelf.thePriceView.model = model;
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:[NSString stringWithFormat:@"没有该商品详情"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"+++++%@",error);
    }];
    
}

/** 商品详情列表网络请求 */
- (void)httpGetGoodsDetailsRequest {
    
    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appGoods/findGoodsDetailList.do"] progressDic:@{@"GoodsId":self.goodsID} success:^(id JSON) {
        NSArray *dataArray = JSON;
        
        if (dataArray.count > 0) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            for (NSDictionary *dic in dataArray) {
                WYGoodsDetailsModel *model = [[WYGoodsDetailsModel alloc] initWithDictionary:dic];
                [muArray addObject:model];
            }
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:[NSString stringWithFormat:@"没有该商品列表"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"======%@",error);
    }];
}

/** 添加导航条上的2个按钮 */
- (void)navigationAddThreeBarBtnItem {
    /**     右边两个按钮     */
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:@"详情界面收藏按钮"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barItemCollect)];
    
    UIBarButtonItem *_rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:@"详情界面转发按钮"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barItemRelay)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:rightItem,_rightItem, nil];
    
    [self.navigationItem setRightBarButtonItems:itemsArray];
}

/** 右边收藏按钮点击事件 */
- (void)barItemCollect {
    
}

/** 右边转发按钮点击事件 */
- (void)barItemRelay {
    [WYTheThirdParty sinaWeiBoCurrentVC:self];
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
