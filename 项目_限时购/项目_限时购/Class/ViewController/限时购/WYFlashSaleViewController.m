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
#import "WYGoodsTableView.h"
#import "WYBrandTableView.h"

#import "WYNewsModel.h"
#import "WYSaleModel.h"

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

/** 新品团购的 TableView */
@property (strong, nonatomic) WYGoodsTableView *goodsTable;

/** 品牌团购的 TableView */
@property (strong, nonatomic) WYBrandTableView *brandTable;

/** 保存新品团购视图数据信息 */
@property (strong, nonatomic) NSMutableArray *newsMuArray;

/** 保存品牌团购视图数据信息 */
@property (strong, nonatomic) NSMutableArray *brandMuArray;

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
        _goodsTable = [[WYGoodsTableView alloc] initWithFrame:(CGRectMake(0, _scale + 50, self.view.frame.size.width, self.view.frame.size.height - _scale -  50)) style:(UITableViewStylePlain)];
    }
    return _goodsTable;
}

- (WYBrandTableView *)brandTable {
    if (!_brandTable) {
        _brandTable = [[WYBrandTableView alloc] initWithFrame:(CGRectMake(self.view.frame.size.width, _scale + 50, self.view.frame.size.width, self.view.frame.size.height - _scale - 50)) style:(UITableViewStylePlain)];
    }
    return _brandTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scale = 232 / 667.0 * HEIGHT;
    /** 添加控件和约束 */
    [self controlScrollViewMasonry];
    
    [self httpGetAdvertisingRequest];
    [self httpGetNewGoodsRequest];
}

/** 添加控件和约束 */
- (void)controlScrollViewMasonry {
    
    [self.view addSubview:self.rollScrollView];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.rollScrollView.contentSize.height - _scale - 50;
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
    [self.rollScrollView addSubview:self.goodsTable];
    [self.rollScrollView addSubview:self.brandTable];
    
    [_goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.twoBtnView.bottom);
        make.left.equalTo(weakSelf.rollScrollView.left);
        make.right.equalTo(weakSelf.rollScrollView.right);
        make.height.equalTo(height);
    }];
    
    [_goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.twoBtnView.bottom);
        make.left.equalTo(weakSelf.goodsTable.right);
        make.size.equalTo(CGSizeMake(width, height));
    }];
    
}

/** 顶部广告轮播视图的网络请求 */
- (void)httpGetAdvertisingRequest {
    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appHome/appHome.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                [muArray addObject:dict[@"ImgView"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.adView.arrayImages = muArray;
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

/** 新品团购的网络请求 */
- (void)httpGetNewGoodsRequest {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appActivity/appActivityList.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYNewsModel *model = [[WYNewsModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.newsMuArray addObjectsFromArray:muArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.goodsTable.infoGoodsArray = weakSelf.newsMuArray;
                [weakSelf.goodsTable reloadData];
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

/** 品牌团购的网络请求 */
- (void)httpGetBrandRequest {
    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appActivity/appHomeGoodsList.do"] progressDic:nil success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 1) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYSaleModel *model = [[WYSaleModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            [weakSelf.brandMuArray addObjectsFromArray:muArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.brandTable.infoBrandArray = weakSelf.brandMuArray;
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
