//
//  WYProductViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/20.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYProductViewController.h"
#import "WYDetailsClassfyViewController.h"

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

/** 添加轮播视图上的购买人数按钮 */
@property (strong, nonatomic) UIButton *buyBtn;

/** 收藏按钮 */
@property (weak, nonatomic) UIButton *collectBtn;

/** 商品详情价格、评分的数据 model */
@property (strong, nonatomic) WYAllDetailsModel *allModel;

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

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyBtn setFrame:(CGRectMake(WIDTH - 85, 320 - 50, 92, 22))];
        [_buyBtn setBackgroundColor:RGB(255, 75, 34)];
        [_buyBtn.layer setMasksToBounds:YES];
        [_buyBtn.layer setCornerRadius:11];
        [_buyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_buyBtn addTarget:self action:@selector(btnTouchActionBuy) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _buyBtn;
}

- (void)btnTouchActionBuy {
    
    [self.bgScrollView setContentOffset:(CGPointMake(0, CGRectGetMaxY(self.productTbaleView.frame))) animated:YES];
}

- (WYCenterView *)thePriceView {
    if (!_thePriceView) {
        _thePriceView = [[WYCenterView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.adView.frame) + 10, WIDTH, 271))];
        _thePriceView.countryUrl = _countryImageUrl;
    }
    return _thePriceView;
}

- (WYProductTableView *)productTbaleView {
    if (!_productTbaleView) {
        _productTbaleView = [[WYProductTableView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.thePriceView.frame), WIDTH, 358)) style:(UITableViewStyleGrouped)];
    }
    return _productTbaleView;
}

- (WYImageDetailsView *)imageDetailsView {
    if (!_imageDetailsView) {
        _imageDetailsView = [[WYImageDetailsView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.productTbaleView.frame), WIDTH, HEIGHT))];
    }
    return _imageDetailsView;
}

- (WYGoodsScoreView *)goodsScoreView {
    if (!_goodsScoreView) {
        _goodsScoreView = [[WYGoodsScoreView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(self.imageDetailsView.frame), WIDTH, 130))];
    }
    return _goodsScoreView;
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
    
    /** 商品详情列表网络请求 */
    [self httpGetGoodsDetailsRequest];
    
    /** 商品评分部分网络请求 */
    [self httpGetGoodsScoreRequest];
    
    /** 商品评论部分网络请求(空的) */
//    [self httpGetCommentRequest];
}

/** 添加控件 和 约束 */
- (void)controlAddView {
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.adView];
    [self.adView addSubview:self.buyBtn];
    [self.bgScrollView addSubview:self.thePriceView];
    [self.bgScrollView addSubview:self.productTbaleView];
    [self.bgScrollView addSubview:self.imageDetailsView];
    [self.bgScrollView addSubview:self.goodsScoreView];
    
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
    
    weakSelf.thePriceView.btnAction = ^() {
        WYDetailsClassfyViewController *classDetailsVC = [[WYDetailsClassfyViewController alloc] init];
        classDetailsVC.title = weakSelf.allModel.brandCNName;
        classDetailsVC.typeID = weakSelf.allModel.shopId;
        classDetailsVC.judgeRequest = 1;
        [weakSelf.navigationController pushViewController:classDetailsVC animated:YES];
    };
    
    weakSelf.imageDetailsView.viewHeight = ^(CGFloat viewHeight) {
        CGRect imageRect = weakSelf.imageDetailsView.frame;
        imageRect.size.height = viewHeight;
        weakSelf.imageDetailsView.frame = imageRect;
        
        CGRect scoreRect = weakSelf.goodsScoreView.frame;
        scoreRect.origin.y = CGRectGetMaxY(imageRect);
        weakSelf.goodsScoreView.frame = scoreRect;
        
        [weakSelf.bgScrollView setContentSize:(CGSizeMake(WIDTH, CGRectGetMaxY(scoreRect) + 10))];
    };
}

/** 购物车按钮点击事件 */
- (void)btnTouchActionShopping {
    [self.tabBarController setSelectedIndex:2];
}

/** 加入购物车按钮点击事件 */
- (void)btnTouchActionAddCart {
    
    /** 获取登录保存的本地数据 */
    NSDictionary *userDic = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    if (userDic) {
        
        [self httpGetGoodsAddSgoppingCarRequestMemberId:userDic[@"MemberId"] GoodsId:self.goodsID];
    }
    else {
        [self showTostView:[NSString stringWithFormat:@"尊敬的用户您尚未登录"]];
    }
}

/** 立即购买按钮点击事件 */
- (void)btnTouchActionBuyNow {
    /** 获取登录保存的本地数据 */
    NSDictionary *userDic = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    
    if (userDic) {
        [self httpGetRequestImmediatelyBuyGoodsMemberId:userDic[@"MemberId"] GoodsId:self.goodsID];
    }
    else {
        [self showTostView:[NSString stringWithFormat:@"尊敬的用户您尚未登录"]];
    }
    
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.adView.arrayImages = imageArray;
                CGFloat height = [detailsHeightArray[0] floatValue];
                CGFloat scale = height / 667.0 < 667 / height ? height / 667.0 : 667 / height;
                weakSelf.imageDetailsView.scale = scale;
                weakSelf.imageDetailsView.photoArray = detailsImageArray;
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
            
            weakSelf.allModel = [[WYAllDetailsModel alloc] initWithDictionary:infoDict];
            
            ZDY_LOG(@"     %@ ",weakSelf.allModel.isCollected);
            
            BOOL collect;
            if ([weakSelf.allModel.isCollected isEqualToString:[NSString stringWithFormat:@"YES"]]) {
                collect = YES;
            }
            else {
                collect = NO;
            }
            [weakSelf.collectBtn setSelected:collect];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.thePriceView.model = weakSelf.allModel;
                [weakSelf.buyBtn setTitle:weakSelf.allModel.buyCount forState:(UIControlStateNormal)];
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.productTbaleView.dataArray = muArray;
                [weakSelf.productTbaleView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"======%@",error);
        
    }];
}

/** 商品评分部分网络请求 */
- (void)httpGetGoodsScoreRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appGoods/findGoodsScore.do"] progressDic:@{@"GoodsId":self.goodsID} success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 0) {
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                WYScoreModel *model = [[WYScoreModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.goodsScoreView.dataArray = muArray;
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"-----%@",error);
        
    }];
    
}

/** 商品评论部分网络请求(空的) */
- (void)httpGetCommentRequest {
//    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appGoods/findGoodsComment.do"] progressDic:@{@"GoodsId":self.goodsID} success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        NSString *nameJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil] encoding:NSUTF8StringEncoding];
        
        ZDY_LOG(@"商品评论 == %@",nameJson);
        
        if (array.count > 0) {
            
//            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
//            
//            for (NSDictionary *dict in array) {
//                
//            }
            
        }
        else {
            ZDY_LOG(@"   请求评论失败");
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error.localizedDescription);
    }];
}

/**
 *  商品加入个人收藏的网络请求  (服务器错误)
 *
 *  @param MemberId       用户 ID
 *  @param CollectionType 商品是选择添加收藏@“1” 还是 取消收藏@“2”
 */
- (void)httpGetGoodsAddUserCollectRequestMemberId:(NSString *)MemberId CollectionType:(NSInteger)CollectionType {
    
    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"MemberId":MemberId,
                                 @"CollectionType":[NSString stringWithFormat:@"%ld",CollectionType],
                                 @"RelatedType":@"1",
                                 @"RelatedId":self.allModel.goodsId};
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appCollection/insertIOS.do"] progressDic:requestDic success:^(id JSON) {
        
        NSDictionary *dataDict = (NSDictionary *)JSON;
        
        if ([dataDict[@"result"] isEqualToString:[NSString stringWithFormat:@"success"]]) {
            
            if (1 == CollectionType) {
                [weakSelf showTostView:[NSString stringWithFormat:@"成功加入收藏夹"]];
            }
            else {
                [weakSelf showTostView:[NSString stringWithFormat:@"已从收藏夹移除"]];
            }
            
        }
        else {
            [weakSelf showTostView:[NSString stringWithFormat:@"收藏失败"]];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error.localizedDescription);
    }];
}

/**
 *  商品加入购物车的网络请求
 *
 *  @param MemberId 用户的 ID
 *  @param GoodsId  商品的标识 ID
 */
- (void)httpGetGoodsAddSgoppingCarRequestMemberId:(NSString *)MemberId GoodsId:(NSString *)GoodsId {
    
    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"MemberId":MemberId,
                                 @"GoodsId":GoodsId};
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/insert.do"] progressDic:requestDic success:^(id JSON) {
        NSDictionary *statusDic = (NSDictionary *)JSON;
        
        if ([statusDic[@"result"] isEqualToString:[NSString stringWithFormat:@"success"]]) {
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"已将商品添加到购物车"] message:[NSString stringWithFormat:@"点击去付款到购物车结算，点击再逛逛查看其它商品"] preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *paymentAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"去付款"] style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                
                weakSelf.tabBarController.selectedIndex = 2;
                
            }];
            
            UIAlertAction *goagoAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"再逛逛"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:paymentAction];
            [alertC addAction:goagoAction];
            [weakSelf presentViewController:alertC animated:YES completion:nil];
            
        }
        else {
            [weakSelf showTostView:[NSString stringWithFormat:@"加入购物车失败"]];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error);
    }];
}

/**
 *  立即购买:添加到购物车，并跳转到购物车界面确认订单
 *
 *  @param MemberId 用户的 ID
 *  @param GoodsId  商品的标识 ID
 */
- (void)httpGetRequestImmediatelyBuyGoodsMemberId:(NSString *)MemberId GoodsId:(NSString *)GoodsId {
    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"MemberId":MemberId,
                                 @"GoodsId":GoodsId};
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/insert.do"] progressDic:requestDic success:^(id JSON) {
        NSDictionary *statusDic = (NSDictionary *)JSON;
        
        NSString *dataJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil] encoding:NSUTF8StringEncoding];
        ZDY_LOG(@"====%@",dataJson);
        
        if ([statusDic[@"result"] isEqualToString:[NSString stringWithFormat:@"success"]]) {
            
            weakSelf.tabBarController.selectedIndex = 2;
            
        }
        else {
            [weakSelf showTostView:[NSString stringWithFormat:@"立即购买跳转购物车失败"]];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error);
    }];
}

/** 添加导航条上的2个按钮 */
- (void)navigationAddThreeBarBtnItem {
    /**     右边两个按钮     */
    UIButton *collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [collectBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"详情界面收藏按钮"]] forState:(UIControlStateNormal)];
    [collectBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"详情界面收藏按钮sel"]] forState:(UIControlStateSelected)];
    [collectBtn sizeToFit];
    [collectBtn addTarget:self action:@selector(btnTouchActionCollect:) forControlEvents:(UIControlEventTouchUpInside)];
    self.collectBtn = collectBtn;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    
    UIBarButtonItem *_rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:@"详情界面转发按钮"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barItemRelay)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:rightItem,_rightItem, nil];
    
    [self.navigationItem setRightBarButtonItems:itemsArray];
}

/** 右边收藏按钮点击事件 */
- (void)btnTouchActionCollect:(UIButton *)collect {
    
    NSDictionary *userDic = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    
    if (userDic) {
        
        if (collect.selected) {
            [self httpGetGoodsAddUserCollectRequestMemberId:userDic[@"MemberId"] CollectionType:2];
        }
        else {
            [self httpGetGoodsAddUserCollectRequestMemberId:userDic[@"MemberId"] CollectionType:1];
        }
        collect.selected = !collect.selected;
    }
    else {
        [MBProgressHUD showError:[NSString stringWithFormat:@"尊敬的用户您尚未登录"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }
    
    
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
