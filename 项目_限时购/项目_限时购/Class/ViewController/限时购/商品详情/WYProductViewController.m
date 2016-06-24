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
    }
    return _thePriceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加控件 */
    [self controlAddView];
    /** 添加导航条上的三个按钮 */
    [self navigationAddThreeBarBtnItem];
    
    /** 商品所有图片列表网络请求 */
    [self httpGetGoodsImagesRequest];
    /** 商品详情部分（包含价格，评分等）网络请求*/
    [self httpGetAllGoodsDetailsRequest];
    
}

/** 添加控件 */
- (void)controlAddView {
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.adView];
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
            
            WYAllGoodsModel *model = [[WYAllGoodsModel alloc] initWithDictionary:infoDict];
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
