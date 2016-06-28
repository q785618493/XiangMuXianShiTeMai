//
//  WYShoppingCartViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYShoppingCartViewController.h"
#import "WYConfirmOrderViewController.h"

#import "WYNotLoginView.h"
#import "WYLoginNoGoodsView.h"
#import "WYLoginHaveGoodsView.h"
#import "WYSettlementView.h"

#import "WYShoppingCarModel.h"

@interface WYShoppingCartViewController ()

/** 用户未登录状态提醒视图 */
@property (strong, nonatomic) WYNotLoginView *notLoginView;

/** 用户以登录,购物车无商品提醒视图 */
@property (strong, nonatomic) WYLoginNoGoodsView *noGoodsView;

/** 用户以登录,购物车有商品提醒视图 */
@property (strong, nonatomic) WYLoginHaveGoodsView *haveGoodsView;

/** 底部结算视图 */
@property (strong, nonatomic) WYSettlementView *bottomView;

/** 保存购物车商品数据 */
@property (strong, nonatomic) NSMutableArray *shoppingMuArray;

/** 保存订单商品总价格 */
@property (assign, nonatomic) CGFloat thePrice;

@end

@implementation WYShoppingCartViewController

/** 懒加载 */
- (WYNotLoginView *)notLoginView {
    if (!_notLoginView) {
        _notLoginView = [[WYNotLoginView alloc] init];
    }
    return _notLoginView;
}

- (WYLoginNoGoodsView *)noGoodsView {
    if (!_noGoodsView) {
        _noGoodsView = [[WYLoginNoGoodsView alloc] init];
    }
    return _noGoodsView;
}

- (WYLoginHaveGoodsView *)haveGoodsView {
    if (!_haveGoodsView) {
        _haveGoodsView = [[WYLoginHaveGoodsView alloc] initWithFrame:(CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 49 - 64 - 56)) style:(UITableViewStylePlain)];
        [_haveGoodsView setHidden:YES];
    }
    return _haveGoodsView;
}

- (NSMutableArray *)shoppingMuArray {
    if (!_shoppingMuArray) {
        _shoppingMuArray = [NSMutableArray array];
    }
    return _shoppingMuArray;
}

- (WYSettlementView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WYSettlementView alloc] init];
        [_bottomView setHidden:YES];
    }
    return _bottomView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /** 判断当前用户是否登录 */
    [self judgeCurrentUserIsLogin];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

/** 判断当前用户是否登录 */
- (void)judgeCurrentUserIsLogin {
    
    WS(weakSelf);
    /** 获取登录本地保存的用户数据 */
    NSDictionary *dictUser = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    
    if (dictUser) {
        
        NSInteger goodsNumber = [dictUser[@"result"] integerValue];
        
        if (0 == goodsNumber) {
            [self.notLoginView removeFromSuperview];
            [self.bottomView removeFromSuperview];
            [self.haveGoodsView removeFromSuperview];
            [self.view addSubview:self.noGoodsView];
            [_noGoodsView makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.view.centerX);
                make.centerY.equalTo(weakSelf.view.centerY);
                make.size.equalTo(CGSizeMake(VIEW_WIDTH, 334));
            }];
            
            weakSelf.noGoodsView.btnGoagoAction = ^() {
                weakSelf.tabBarController.selectedIndex = 0;
            };
            
        }
        else {
            [self.notLoginView removeFromSuperview];
            [self.noGoodsView removeFromSuperview];
            [self.view addSubview:self.bottomView];
            [self.view addSubview:self.haveGoodsView];
            
            weakSelf.haveGoodsView.cellRow = ^(NSInteger cellRow) {
                
                WYShoppingCarModel *model = weakSelf.shoppingMuArray[cellRow];
                
                [weakSelf httpGetModifyTheRequestUpdateCartMsg:[NSString stringWithFormat:@"%@,%@",model.uUID,model.goodsCount]];
            };
            
            weakSelf.haveGoodsView.blockPrice = ^(NSString *goodsID, CGFloat price, BOOL stasus) {
                weakSelf.thePrice += price;
                
                if (stasus) {
                    
                }
                
            };
            
            [_bottomView makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf.view.bottom).offset(-49);
                make.top.equalTo(weakSelf.haveGoodsView.bottom);
                make.left.right.equalTo(weakSelf.view);
            }];
            
            
            weakSelf.bottomView.blockPayment = ^() {
                WYConfirmOrderViewController *confirmVC = [[WYConfirmOrderViewController alloc] init];
                confirmVC.dataArray = weakSelf.shoppingMuArray;
                confirmVC.goodsPrice = weakSelf.thePrice;
                confirmVC.title = [NSString stringWithFormat:@"确认订单"];
                [weakSelf.navigationController pushViewController:confirmVC animated:YES];
            };
            
            
            
            [self httpGetShoppingCarListRequestMemberId:dictUser[@"MemberId"]];
        }
    }
    else {
        [self.noGoodsView removeFromSuperview];
        [self.bottomView removeFromSuperview];
        [self.haveGoodsView removeFromSuperview];
        [self.view addSubview:self.notLoginView];
        [_notLoginView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.view.centerX);
            make.centerY.equalTo(weakSelf.view.centerY);
            make.size.equalTo(CGSizeMake(154, 74));
        }];
        
        weakSelf.notLoginView.blockLogin = ^() {
            weakSelf.tabBarController.selectedIndex = 3;
        };
    }
}

/** 修改商品价格 */
- (void)setThePrice:(CGFloat)thePrice {
    _thePrice = thePrice;
    
    self.bottomView.moneyText = [NSString stringWithFormat:@"%.2f",_thePrice];
}

/** 购物车商品列表的网络请求 */
- (void)httpGetShoppingCarListRequestMemberId:(NSString *)MemberId {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/appCartGoodsList.do"] progressDic:@{@"MemberId":MemberId} success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            weakSelf.thePrice = 0;
            CGFloat price;
            NSInteger number;
            
            for (NSDictionary *dict in array) {
                WYShoppingCarModel *model = [[WYShoppingCarModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
                
                price = [model.price floatValue];
                number = [model.goodsCount integerValue];
                weakSelf.thePrice += number * price * 1.0;
            }
            
            /** 遍历模型数据，默认商品选中 */
            [muArray enumerateObjectsUsingBlock:^(WYShoppingCarModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.selected = YES;
            }];
            
            [weakSelf.shoppingMuArray addObjectsFromArray:muArray];
            weakSelf.haveGoodsView.goodsMuArray = muArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.haveGoodsView reloadData];
                [weakSelf.haveGoodsView setHidden:NO];
                [weakSelf.bottomView setHidden:NO];
            });
        }
        else {
            ZDY_LOG(@"   购物车商品列表请求失败");
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error);
    }];
}

/** 修改购物车记录 */
- (void)httpGetModifyTheRequestUpdateCartMsg:(NSString *)updateCartMsg {
    
//    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"updateCartMsg":updateCartMsg};
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/appUpdateCart.do"] progressDic:requestDic success:^(id JSON) {
        
        NSDictionary *dataDic = (NSDictionary *)JSON;
        
        ZDY_LOG(@"    %@",dataDic);
        
        if ([dataDic[@"result"] isEqualToString:[NSString stringWithFormat:@"success"]]) {
            
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"删除成功"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        else {
            ZDY_LOG(@"  ------- 删除失败 -------   ");
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@" error == %@",error.localizedDescription);
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
