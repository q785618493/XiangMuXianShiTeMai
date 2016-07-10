//
//  WYFlashSaleViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYFlashSaleViewController.h"
#import "WYSearchViewController.h"
#import "WYProductViewController.h"
#import "WYDetailsClassfyViewController.h"

#import "WYHomeGuideView.h"
#import "TopRollView.h"
#import "WYTwoBtnView.h"
#import "WYGoodsTableView.h"
#import "WYBrandTableView.h"

#import "WYNewsModel.h"
#import "WYSaleModel.h"

#define WIDTH  self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

/** 判断是否第一次应用软件的Key */
static NSString *versionKey = @"CFBundleShortVersionString";

@interface WYFlashSaleViewController () <UIScrollViewDelegate>

/** 用户第一次启动app的引导视图 */
@property (strong, nonatomic) WYHomeGuideView *guideView;

/** 底层的 scrollView */
@property (strong, nonatomic) UIScrollView *rollScrollView;

/** 顶部广告轮播视图 */
@property (strong, nonatomic) TopRollView *adView;

/** 新品和品牌购按钮的视图 */
@property (strong, nonatomic) WYTwoBtnView *twoBtnView;

/** 顶部轮播视图的 比例高度 */
@property (assign, nonatomic) CGFloat scale;

/** 新品团购的 TableView */
@property (strong, nonatomic) WYGoodsTableView *goodsTable;

/** 品牌团购的 TableView */
@property (strong, nonatomic) WYBrandTableView *brandTable;

/** 保存新品团购视图数据信息 */
@property (strong, nonatomic) NSMutableArray *newsMuArray;

/** 保存品牌团购视图数据信息 */
@property (strong, nonatomic) NSMutableArray *brandMuArray;

/** 保存TableView 的高度 */
@property (assign, nonatomic) CGFloat height;

@end

@implementation WYFlashSaleViewController

/** 重写 get方法懒加载控件 */
- (WYHomeGuideView *)guideView {
    if (!_guideView) {
        _guideView = [[WYHomeGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _guideView;
}

- (UIScrollView *)rollScrollView {
    if (!_rollScrollView) {
        _rollScrollView = [[UIScrollView alloc] init];
        [_rollScrollView setDelegate:self];
        [_rollScrollView setBounces:NO];
        [_rollScrollView setBackgroundColor:RGB(245, 245, 245)];
        [_rollScrollView setShowsVerticalScrollIndicator:NO];
        [_rollScrollView setShowsHorizontalScrollIndicator:NO];
        [_rollScrollView setContentOffset:(CGPointZero)];
        [_rollScrollView setContentSize:(CGSizeMake(WIDTH, self.scale + 50 + 1750))];
        [_rollScrollView setHidden:YES];
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
    
    __weak typeof(self) weakSelf = self;
    [newBtn setSelected:YES];
    [self.twoBtnView.BrandBtn setSelected:NO];
    [self.rollScrollView setContentSize:(CGSizeMake(WIDTH, 175 * self.newsMuArray.count + _scale + 50))];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect brandRect = weakSelf.brandTable.frame;
        brandRect.origin.x = WIDTH;
        weakSelf.brandTable.frame = brandRect;
        
        CGRect goodsRect = weakSelf.goodsTable.frame;
        goodsRect.origin.x = 0;
        weakSelf.goodsTable.frame = goodsRect;
    }];
}

/** 品牌团购点击事件 */
- (void)btnTouchActionBrand:(UIButton *)brandBtn {
    WS(weakSelf);
    [brandBtn setSelected:YES];
    [self.twoBtnView.NewBtn setSelected:NO];
    
    [self.rollScrollView setContentSize:(CGSizeMake(WIDTH,180 * self.brandMuArray.count + _scale + 50))];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect goodsRect = weakSelf.goodsTable.frame;
        goodsRect.origin.x = WIDTH - WIDTH * 2;
        weakSelf.goodsTable.frame = goodsRect;
        
        CGRect brandRect = weakSelf.brandTable.frame;
        brandRect.origin.x = 0;
        weakSelf.brandTable.frame = brandRect;
    }];
}

- (TopRollView *)adView {
    if (!_adView) {
        _adView = [[TopRollView alloc] initWithFrame:(CGRectMake(0, 0, WIDTH, _scale))];
        [_adView setBackgroundColor:RGB(245, 245, 245)];
    }
    return _adView;
}

- (NSMutableArray *)newsMuArray {
    if (!_newsMuArray) {
        _newsMuArray = [NSMutableArray array];
    }
    return _newsMuArray;
}

- (NSMutableArray *)brandMuArray {
    if (!_brandMuArray) {
        _brandMuArray = [NSMutableArray array];
    }
    return _brandMuArray;
}

- (WYGoodsTableView *)goodsTable {
    if (!_goodsTable) {
        _goodsTable = [[WYGoodsTableView alloc] initWithFrame:(CGRectMake(0, _scale + 50, WIDTH, 1750)) style:(UITableViewStylePlain)];
    }
    return _goodsTable;
}

- (WYBrandTableView *)brandTable {
    if (!_brandTable) {
        _brandTable = [[WYBrandTableView alloc] initWithFrame:(CGRectMake(WIDTH, _scale + 50, WIDTH, 1800)) style:(UITableViewStylePlain)];
    }
    return _brandTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 顶部轮播视图的 比例高度 */
    _scale = 232 / 667.0 * HEIGHT;
    /** 添加控件和约束 */
    [self controlScrollViewMasonry];
    
    /** 添加导航右上角的搜索按钮 */
    [self rightNavAddBtnItem];
    
    /** 判断用户是否第一次使用 app */
    [self userFirstMakeApp];
    
//    [self leftNavigationTabBarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //从沙盒取出存储的上次软件版本号（上次使用的记录）
    NSString *lastVersion = [XSG_USER_DEFAULTS objectForKey:versionKey];
    
    //获取当前使用软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        
        /** 显示导航 */
        [self.navigationController.navigationBar setHidden:NO];
        
        /** 显示标签栏 */
        [self.tabBarController.tabBar setHidden:NO];
        
    } else {
        
        /** 隐藏导航 */
        [self.navigationController.navigationBar setHidden:YES];
        /** 隐藏标签栏 */
        [self.tabBarController.tabBar setHidden:YES];
    }
}

/** 添加控件和约束 */
- (void)controlScrollViewMasonry {
    
    [self.view addSubview:self.rollScrollView];
    WS(weakSelf);
    [_rollScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    [self.rollScrollView addSubview:self.adView];
    [self.rollScrollView addSubview:self.goodsTable];
    [self.rollScrollView addSubview:self.brandTable];
    [self.rollScrollView addSubview:self.twoBtnView];
    [self.twoBtnView setFrame:(CGRectMake(0, _scale, WIDTH, 50))];
    
    /**
     *  新品团购cell选中回调实现的 block
     *
     *  @param cellRow 选中的行
     *
     *  @return 
     */
    weakSelf.goodsTable.goodsCellRow = ^(NSInteger cellRow) {
        
        WYProductViewController *productVC = [[WYProductViewController alloc] init];
        productVC.title = [NSString stringWithFormat:@"商品详情"];
        
        WYNewsModel *model = weakSelf.newsMuArray[cellRow];
        productVC.goodsID = model.goodsId;
        productVC.countryImageUrl = model.countryImg;
        
        [weakSelf.navigationController pushViewController:productVC animated:YES];
    };
    
    /** 加入购物车按钮回调的block */
    weakSelf.goodsTable.shoppingCar = ^(NSInteger btnTag) {
        /** 获取登录保存的本地数据 */
        NSDictionary *userDic = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
        if (userDic) {
            WYNewsModel *model = self.newsMuArray[btnTag];
            [weakSelf httpGetGoodsAddSgoppingCarRequestMemberId:userDic[@"MemberId"] GoodsId:model.goodsId];
        }
        else {
            [MBProgressHUD showError:[NSString stringWithFormat:@"尊敬的用户您尚未登录"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
    };
    
    /**
     *  品牌团购cell选中回调实现的 block
     *
     *  @param cellRow 选中的行
     *
     *  @return
     */
    weakSelf.brandTable.brandCellRow = ^(NSInteger cellRow) {
        WYSaleModel *model = weakSelf.brandMuArray[cellRow];
        WYDetailsClassfyViewController *detailsVC = [[WYDetailsClassfyViewController alloc] init];
        detailsVC.title = model.shopTitle;
        detailsVC.typeID = model.activityId;
        detailsVC.judgeRequest = 3;
        [weakSelf.navigationController pushViewController:detailsVC animated:YES];
    };
}

/** 添加导航右上角的搜索按钮 */
- (void)rightNavAddBtnItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithModeImageName:[NSString stringWithFormat:@"限时特卖界面搜索按钮"]] style:(UIBarButtonItemStylePlain) target:self action:@selector(barBtnItemActionRight:)];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
}

/** 导航右上搜索按钮的点击事件 */
- (void)barBtnItemActionRight:(UIBarButtonItem *)rightItem {
    
    WYSearchViewController *searchVC = [[WYSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

/** 判断用户是否第一次使用 app */
- (void)userFirstMakeApp {
    
    //从沙盒取出存储的上次软件版本号（上次使用的记录）
    NSString *lastVersion = [XSG_USER_DEFAULTS objectForKey:versionKey];
    
    //获取当前使用软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        /** 请求网络数据 */
        [self requestNetworkData];
    }
    else {
        /** 添加引导页视图 */
        [self addGuideScrollView];
    }
}

/** 添加引导页视图 */
- (void)addGuideScrollView {
    [self.view addSubview:self.guideView];
    
    NSArray *imageArray = [NSArray arrayWithObjects:@"微商引导页1",@"微商引导页2",@"微商引导页3", nil];
    self.guideView.imageArray = imageArray;
    
    WS(weakSelf);
    /** 立即体验回调的点击事件 */
    weakSelf.guideView.leamAction = ^() {
        
        /** 移除引导视图 */
        [weakSelf.guideView removeFromSuperview];
        
        /** 记录当前的版本号     */
        //从沙盒取出存储的上次软件版本号（上次使用的记录）
        //获取当前使用软件的版本号
        NSString *currKey = [NSBundle mainBundle].infoDictionary[versionKey];
        //存储本次使用软件的版本
        [XSG_USER_DEFAULTS setObject:currKey forKey:versionKey];
        //马上进行存储，不写随机存储，可能无效
        [XSG_USER_DEFAULTS synchronize];
        
        /** 显示导航 */
        [weakSelf.navigationController.navigationBar setHidden:NO];
        /** 显示标签栏 */
        [weakSelf.tabBarController.tabBar setHidden:NO];
        
        /** 请求网络数据 */
        [weakSelf requestNetworkData];
    };
}

/** 请求网络数据 */
- (void)requestNetworkData {
    /** 顶部广告轮播视图的网络请求 */
    [self httpGetAdvertisingRequest];
    
    /** 新品团购的网络请求 */
    [self httpGetNewGoodsRequest];
    
    /** 品牌团购的网络请求 */
    [self httpGetBrandRequest];
}

/** 顶部广告轮播视图的网络请求 */
- (void)httpGetAdvertisingRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appHome/appHome.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];

            for (NSDictionary *dict in array) {
                [muArray addObject:dict[@"ImgView"]];
            }
            weakSelf.adView.arrayImages = muArray;
            
        }
        else {
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"加载数据失败,请您检查网络"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"失败==%@",error);
    }];
}

/** 新品团购的网络请求 */
- (void)httpGetNewGoodsRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appActivity/appHomeGoodsList.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYNewsModel *model = [[WYNewsModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.newsMuArray addObjectsFromArray:muArray];
            CGRect goodsRect = weakSelf.goodsTable.frame;
            goodsRect.size.height = weakSelf.newsMuArray.count * 175;
            weakSelf.goodsTable.frame = goodsRect;
            weakSelf.goodsTable.infoGoodsArray = weakSelf.newsMuArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.goodsTable reloadData];
                [weakSelf.rollScrollView setHidden:NO];
                [MBProgressHUD hideHUD];
            });
        
        }
        else {
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"加载数据失败,请您检查网络"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"失败==%@",error.localizedDescription);
    }];
}

/** 品牌团购的网络请求 */
- (void)httpGetBrandRequest {
    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appActivity/appActivityList.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count >= 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYSaleModel *model = [[WYSaleModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.brandMuArray addObjectsFromArray:muArray];
            
            CGRect brandRect = weakSelf.brandTable.frame;
            brandRect.size.height = weakSelf.brandMuArray.count * 180;
            weakSelf.brandTable.frame = brandRect;
            
            weakSelf.brandTable.infoBrandArray = weakSelf.brandMuArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.brandTable reloadData];
            });
            
        }
        else {
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"加载数据失败,请您检查网络"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"失败==%@",error.localizedDescription);
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"请您检查网络"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];
}

/** 商品加入购物车的网络请求 */
- (void)httpGetGoodsAddSgoppingCarRequestMemberId:(NSString *)MemberId GoodsId:(NSString *)GoodsId {
    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"MemberId":MemberId,
                                 @"GoodsId":GoodsId};
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/insert.do"] progressDic:requestDic success:^(id JSON) {
        NSDictionary *statusDic = (NSDictionary *)JSON;
        
        NSString *dataJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil] encoding:NSUTF8StringEncoding];
        ZDY_LOG(@"====%@",dataJson);
        
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
            ZDY_LOG(@"----- 加入购物车失败 -----");
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make-
#pragma make- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _rollScrollView) {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > _scale) {
            CGRect twoRect = _twoBtnView.frame;
            twoRect.origin.y = scrollView.contentOffset.y;
            _twoBtnView.frame = twoRect;
        }
        else {
            _twoBtnView.frame = CGRectMake(0, _scale, WIDTH, 50);
        }
    }
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
