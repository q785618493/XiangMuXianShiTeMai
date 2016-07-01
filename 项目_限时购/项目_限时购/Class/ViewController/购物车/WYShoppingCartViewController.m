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

/** 记录购物车数据信息发生变化 */
@property (strong, nonatomic) NSMutableArray *buyCarArray;

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
        
    }
    return _haveGoodsView;
}

- (NSMutableArray *)buyCarArray {
    if (!_buyCarArray) {
        _buyCarArray = [NSMutableArray array];
    }
    return _buyCarArray;
}


- (WYSettlementView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WYSettlementView alloc] init];
        
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    /** 获取登录本地保存的用户数据 */
    NSDictionary *dictUser = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    
    if (dictUser) {
        /**
         *  数组是字符串元素的，用 #号 分隔每一个字符串，拼接成一个新的字符串
         */
        NSString *request = [self.buyCarArray componentsJoinedByString:@"#"];
        
        [self httpGetModifyTheRequestUpdateCartMsg:request];
    }
}


/** 判断当前用户是否登录 */
- (void)judgeCurrentUserIsLogin {
    
    WS(weakSelf);
    /** 获取登录本地保存的用户数据 */
    NSDictionary *dictUser = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    
    if (dictUser) {
        
        [self.notLoginView removeFromSuperview];
        
        [self.view addSubview:self.bottomView];
        [self.bottomView setHidden:YES];
        [self.view addSubview:self.haveGoodsView];
        [self.haveGoodsView setHidden:YES];
        
        weakSelf.haveGoodsView.blockPrice = ^(NSMutableArray *muArray) {
            weakSelf.shoppingMuArray = nil;
            weakSelf.shoppingMuArray = muArray;
            
            weakSelf.buyCarArray = nil;
            [weakSelf.shoppingMuArray enumerateObjectsUsingBlock:^(WYShoppingCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakSelf.buyCarArray addObject:[NSString stringWithFormat:@"%@,%@",model.uUID,model.goodsCount]];
            }];
        };
        
        [_bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view.bottom).offset(-49);
            make.top.equalTo(weakSelf.haveGoodsView.bottom);
            make.left.right.equalTo(weakSelf.view);
        }];
        
        
        weakSelf.bottomView.blockPayment = ^() {
            WYConfirmOrderViewController *confirmVC = [[WYConfirmOrderViewController alloc] init];
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:weakSelf.shoppingMuArray.count];
            
            for (WYShoppingCarModel *model in weakSelf.shoppingMuArray) {
                
                if (model.selected) {
                    [muArray addObject:model];
                }
            }
            
            confirmVC.dataArray = muArray;
            confirmVC.goodsPrice = weakSelf.thePrice;
            confirmVC.title = [NSString stringWithFormat:@"确认订单"];
            [weakSelf.navigationController pushViewController:confirmVC animated:YES];
        };
        
        [self httpGetShoppingCarListRequestMemberId:dictUser[@"MemberId"]];
        
        
        [self.view addSubview:self.noGoodsView];
        [self.noGoodsView setHidden:YES];
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

/** 计算商品价格 */
- (void)setShoppingMuArray:(NSMutableArray *)shoppingMuArray {
    _shoppingMuArray = shoppingMuArray;
    self.thePrice = 0;
    __block CGFloat price = 0;
    __block NSInteger number = 0;
    __block NSInteger goodsNumber = 0;
    
    WS(weakSelf);
    [self.shoppingMuArray enumerateObjectsUsingBlock:^(WYShoppingCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (model.selected) {
            price = [model.price floatValue];
            number = [model.goodsCount integerValue];
            goodsNumber += number;
            
            weakSelf.thePrice += number * price * 1.0;
        }
        
    }];
    
    if (goodsNumber != 0) {
        [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",goodsNumber]];
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
        
        if (array.count > 0) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                WYShoppingCarModel *model = [[WYShoppingCarModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            
            /** 遍历模型数据，默认商品选中 */
            [muArray enumerateObjectsUsingBlock:^(WYShoppingCarModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.selected = YES;
            }];
            
            if (muArray.count > 0) {
                [weakSelf.noGoodsView removeFromSuperview];
                weakSelf.shoppingMuArray = muArray;
                weakSelf.haveGoodsView.goodsMuArray = weakSelf.shoppingMuArray;
                [weakSelf.noGoodsView removeFromSuperview];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.haveGoodsView reloadData];
                    [weakSelf.haveGoodsView setHidden:NO];
                    [weakSelf.bottomView setHidden:NO];
                });
            }
            
        }
        else {
            ZDY_LOG(@"   购物车商品列表请求失败");
            [weakSelf.noGoodsView setHidden:NO];
            [weakSelf.haveGoodsView removeFromSuperview];
            [weakSelf.bottomView removeFromSuperview];
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error.localizedDescription);
    }];
}

/** 修改购物车记录 */
- (void)httpGetModifyTheRequestUpdateCartMsg:(NSString *)updateCartMsg {
    
//    WS(weakSelf);
    
    NSDictionary *requestDic = @{@"updateCartMsg":updateCartMsg};
    [self POSTHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/appUpdateCart.do"] progressDic:requestDic success:^(id JSON) {
        
        NSDictionary *dataDic = (NSDictionary *)JSON;
        
        if ([dataDic[@"result"] isEqualToString:[NSString stringWithFormat:@"success"]]) {
            
            ZDY_LOG(@"  ------- 修改商品成功 -------   ");
        }
        else {
            ZDY_LOG(@"  ------- 商品修改失败 -------   ");
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
