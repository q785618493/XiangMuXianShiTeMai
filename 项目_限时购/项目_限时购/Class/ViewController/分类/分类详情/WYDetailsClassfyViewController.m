//
//  WYDetailsClassfyViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/22.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYDetailsClassfyViewController.h"
#import "WYDetailsCollectionView.h"
#import "WYQueryModel.h"

#define BTN_RANK_TAG 22000

@interface WYDetailsClassfyViewController ()

/** 加载4个排序按钮的视图 */
@property (strong, nonatomic) UIView *fourBtnView;

/** 按钮选中状态底部的展示线 */
@property (strong, nonatomic) UILabel *wireLabel;

/** 底部展示线 的偏移量 */
@property (assign, nonatomic) CGFloat wire_Width;

/** 保存请求数据 */
@property (strong, nonatomic) NSArray *dataArray;

/** 展示商品信息的 WYDetailsCollectionView */
@property (strong, nonatomic) WYDetailsCollectionView *detailsCollView;

@end

@implementation WYDetailsClassfyViewController

/** 重写get方法 懒加载 */
- (UIView *)fourBtnView {
    if (!_fourBtnView) {
        _fourBtnView = [[UIView alloc] init];
        [_fourBtnView setBackgroundColor:[UIColor whiteColor]];
    }
    return _fourBtnView;
}

- (UILabel *)wireLabel {
    if (!_wireLabel) {
        _wireLabel = [[UILabel alloc] init];
        [_wireLabel setBackgroundColor:RGB(0, 180, 239)];
    }
    return _wireLabel;
}

- (WYDetailsCollectionView *)detailsCollView {
    if (!_detailsCollView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
        _detailsCollView = [[WYDetailsCollectionView alloc] initWithFrame:(CGRectMake(0, 104, VIEW_WIDTH, VIEW_HEIGHT - 104)) collectionViewLayout:flowLayout];
    }
    return _detailsCollView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加排序的4个按钮 */
    [self topAddFourBtnView];
    
    /** 添加控件 和 约束 */
    [self controlAddMasonry];
    
    /** 判断网络请求的数据类型 */
    [self judgeDataRequest];
    
    
}

/** 判断网络请求的数据类型 */
- (void)judgeDataRequest {
    
    if (_start) {
        switch (_judgeRequest) {
            case 1: {
                [self httpPostBrandListOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
            }
                break;
            case 2: {
                [self httpPostSearchRequestOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
            }
                break;
            case 3: {
                [self httpPostSaleBrandOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
            }
                break;
            case 4: {
                [self httpGetGoodsDetailsOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
            }
                break;
                
            default:
                break;
        }
    }
    else {
        [MBProgressHUD showError:[NSString stringWithFormat:@"该商品已下架"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }
}

/** 添加排序的4个按钮 */
- (void)topAddFourBtnView {
    
    _wire_Width = self.view.frame.size.width * 0.25;
    
    [self.view addSubview:self.fourBtnView];
    WS(weakSelf);
    [_fourBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.top).offset(64);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(40);
    }];
    
    [self.view insertSubview:self.wireLabel aboveSubview:self.fourBtnView];
    [_wireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fourBtnView.bottom).offset(-1);
        make.left.equalTo(weakSelf.view);
        make.size.equalTo(CGSizeMake(_wire_Width, 1));
    }];
    
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"热门",@"价格",@"好评",@"新品", nil];
    for (NSInteger i = 0; i < titleArray.count; i ++) {
        
        UIButton *rankBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [rankBtn setTag:i + BTN_RANK_TAG];
        [rankBtn setTitle:titleArray[i] forState:(UIControlStateNormal)];
        [rankBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [rankBtn setTitleColor:RGB(0, 180, 239) forState:(UIControlStateSelected)];
        [rankBtn addTarget:self action:@selector(btnTouchActionRank:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.fourBtnView addSubview:rankBtn];
        
        if (0 == i) {
            [rankBtn setSelected:YES];
        }
        
        [rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.fourBtnView.top);
            make.left.equalTo(weakSelf.fourBtnView.left).offset(i * _wire_Width);
            make.size.equalTo(CGSizeMake(_wire_Width, 39));
        }];
    }
}

/** 4个排序按钮的点击事件 */
- (void)btnTouchActionRank:(UIButton *)rankBtn {
    
    rankBtn.selected = YES;
    NSInteger rankTag = rankBtn.tag - BTN_RANK_TAG;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect wireFrame = _wireLabel.frame;
        wireFrame.origin.x = rankTag * _wire_Width;
        _wireLabel.frame = wireFrame;
    }];
    
    for (UIButton *btn in self.fourBtnView.subviews) {
        
        if (rankBtn.tag != btn.tag) {
            btn.selected = NO;
        }
    }
    
    switch (rankTag) {
        case 0: {
            
            switch (_judgeRequest) {
                case 1: {
                    [self httpPostBrandListOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 2: {
                    [self httpPostSearchRequestOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 3: {
                    [self httpPostSaleBrandOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 4: {
                    [self httpGetGoodsDetailsOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                default:
                    break;
            }
            
        }
            
            break;
        case 1: {
            
            switch (_judgeRequest) {
                case 1: {
                    [self httpPostBrandListOrderName:[NSString stringWithFormat:@"price"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 2: {
                    [self httpPostSearchRequestOrderName:[NSString stringWithFormat:@"price"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 3: {
                    [self httpPostSaleBrandOrderName:[NSString stringWithFormat:@"price"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 4: {
                    [self httpGetGoodsDetailsOrderName:[NSString stringWithFormat:@"price"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                default:
                    break;
            }
            
        }
            
            break;
        case 2: {
            
            switch (_judgeRequest) {
                case 1: {
                    [self httpPostBrandListOrderName:[NSString stringWithFormat:@"score"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 2: {
                    [self httpPostSearchRequestOrderName:[NSString stringWithFormat:@"score"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 3: {
                    [self httpPostSaleBrandOrderName:[NSString stringWithFormat:@"score"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                    break;
                case 4: {
                    [self httpGetGoodsDetailsOrderName:[NSString stringWithFormat:@"score"] OrderType:[NSString stringWithFormat:@"DESC"]];
                }
                default:
                    break;
            }
            
        }
            
            break;
        case 3: {
            
            switch (_judgeRequest) {
                case 1: {
                    [self httpPostBrandListOrderName:[NSString stringWithFormat:@"time"] OrderType:[NSString stringWithFormat:@"ASC"]];
                }
                    break;
                case 2: {
                    [self httpPostSearchRequestOrderName:[NSString stringWithFormat:@"time"] OrderType:[NSString stringWithFormat:@"ASC"]];
                }
                    break;
                case 3: {
                    [self httpPostSaleBrandOrderName:[NSString stringWithFormat:@"time"] OrderType:[NSString stringWithFormat:@"ASC"]];
                }
                    break;
                case 4: {
                    [self httpGetGoodsDetailsOrderName:[NSString stringWithFormat:@"time"] OrderType:[NSString stringWithFormat:@"ASC"]];
                }
                default:
                    break;
            }
            
        }
            
        default:
            break;
    }
    
    
}

/** 添加控件 和 约束 */
- (void)controlAddMasonry {
    
    [self.view addSubview:self.detailsCollView];
    
    WS(weakSelf);
    [_detailsCollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(104, 0, 0, 0));
    }];
}

/**
 * 分类:根据品牌跳转至商品列表的 网络请求
 *
 *  @param OrderName 商品的排序方式   NSString
 *  @param OrderType 顺序还是倒序     NSString
 */
- (void)httpPostBrandListOrderName:(NSString *)OrderName OrderType:(NSString *)OrderType {
    
    WS(weakSelf);
    NSDictionary *requestDic = [NSDictionary dictionaryWithObjectsAndKeys:self.typeID,@"ShopId",OrderName,@"OrderName",OrderType,@"OrderType", nil];
    [self POSTHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShop/appShopGoodsList.do"] progressDic:requestDic success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 0) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                
                WYQueryModel *model = [[WYQueryModel alloc] initWithDic:dict];
                [muArray addObject:model];
            }
            weakSelf.dataArray = muArray;
            weakSelf.detailsCollView.infoArray = weakSelf.dataArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.detailsCollView reloadData];
            });
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:[NSString stringWithFormat:@"请求数据失败"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
            });
            
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@" Error ==%@",error);
    }];
    
    
}

/**
 *  搜索:根据商品名称跳转至商品列表的 搜索的网络请求
 *
 *  @param OrderName 商品的排序方式  NSString
 *  @param OrderType 顺序还是倒序    NSString
 */
- (void)httpPostSearchRequestOrderName:(NSString *)OrderName OrderType:(NSString *)OrderType {
    
    NSDictionary *requestDic = @{@"search":self.title,
                                 @"OrderName":OrderName,
                                 @"OrderType":OrderType};
    
    WS(weakSelf);
    [self POSTHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appSearch/searchList.do"] progressDic:requestDic success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 0) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                WYQueryModel *model = [[WYQueryModel alloc] initWithDic:dict];
                [muArray addObject:model];
            }
            
            weakSelf.dataArray = muArray;
            weakSelf.detailsCollView.infoArray = muArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.detailsCollView reloadData];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:[NSString stringWithFormat:@"没有此类商品,请重新搜索"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                });
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"   NSError===%@",error);
    }];
    
}

/**
 *  首页品牌团购:根据品牌活动跳转至商品列表的网络请求
 *
 *  @param OrderName 商品的排序方式  NSString
 *  @param OrderType 顺序还是倒序    NSString
 */
- (void)httpPostSaleBrandOrderName:(NSString *)OrderName OrderType:(NSString *)OrderType {
    
    NSDictionary *requestDic = @{@"GrouponId":_typeID,
                                 @"OrderName":OrderName,
                                 @"OrderType":OrderType};
    
    WS(weakSelf);
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appGgroupon/appGrounpGoodsList.do"] progressDic:requestDic success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 0) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                WYQueryModel *model = [[WYQueryModel alloc] initWithDic:dict];
                [muArray addObject:model];
            }
            weakSelf.dataArray = muArray;
            weakSelf.detailsCollView.infoArray = weakSelf.dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.detailsCollView reloadData];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:[NSString stringWithFormat:@"没有商品信息"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
            });
            
        }
        
    } failure:^(NSError *error) {
        
        ZDY_LOG(@"====%@",error);
    }];
}

/**
 *  商品详情:查看同品牌商品
 *
 *  @param OrderName 商品的排序方式  NSString
 *  @param OrderType 顺序还是倒序    NSString
 */
- (void)httpGetGoodsDetailsOrderName:(NSString *)OrderName OrderType:(NSString *)OrderType {
    
    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"ShopId":_typeID,
                                 @"OrderName":OrderName,
                                 @"OrderType":OrderType};
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShop/appShopGoodsList.do"] progressDic:requestDic success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 0) {
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                WYQueryModel *model = [[WYQueryModel alloc] initWithDic:dict];
                [muArray addObject:model];
            }
            weakSelf.dataArray = muArray;
            weakSelf.detailsCollView.infoArray = weakSelf.dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.detailsCollView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"-------%@",error);
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
