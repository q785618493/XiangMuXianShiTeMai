//
//  WYShoppingCartViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYShoppingCartViewController.h"

#import "WYNotLoginView.h"
#import "WYLoginNoGoodsView.h"
#import "WYLoginHaveGoodsView.h"

#import "WYShoppingCarModel.h"

@interface WYShoppingCartViewController ()

/** 用户未登录状态提醒视图 */
@property (strong, nonatomic) WYNotLoginView *notLoginView;

/** 用户以登录,购物车无商品提醒视图 */
@property (strong, nonatomic) WYLoginNoGoodsView *noGoodsView;

/** 用户以登录,购物车有商品提醒视图 */
@property (strong, nonatomic) WYLoginHaveGoodsView *haveGoodsView;

/** 保存购物车商品数据 */
@property (strong, nonatomic) NSMutableArray *shoppingMuArray;

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
        _haveGoodsView = [[WYLoginHaveGoodsView alloc] initWithFrame:(CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 49 - 64)) style:(UITableViewStylePlain)];
    }
    return _haveGoodsView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 判断当前用户是否登录 */
    [self judgeCurrentUserIsLogin];
    
}

/** 判断当前用户是否登录 */
- (void)judgeCurrentUserIsLogin {
    
    WS(weakSelf);
    /** 获取登录本地保存的用户数据 */
    NSDictionary *dictUser = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
    
    if (dictUser) {
        
        NSInteger goodsNumber = [dictUser[@"result"] integerValue];
        
        if (0 == goodsNumber) {
            [self.view addSubview:self.noGoodsView];
            [_noGoodsView makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.view.centerX);
                make.centerY.equalTo(weakSelf.view.centerY);
                make.size.equalTo(CGSizeMake(VIEW_WIDTH, 334));
            }];
            
            weakSelf.noGoodsView.btnGoagoAction = ^() {
                ZDY_LOG(@"==== 逛一逛 ====");
            };
            
        }
        else {
            
            [self.view addSubview:self.haveGoodsView];
            
            [self httpGetShoppingCarListRequestMemberId:dictUser[@"MemberId"]];
            
        }
    }
    else {
        [self.view addSubview:self.notLoginView];
        [_notLoginView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.view.centerX);
            make.centerY.equalTo(weakSelf.view.centerY);
            make.size.equalTo(CGSizeMake(154, 44));
        }];
    }
}

/** 购物车商品列表的网络请求 */
- (void)httpGetShoppingCarListRequestMemberId:(NSString *)MemberId {
    WS(weakSelf);
    
    [self GETHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShopCart/appCartGoodsList.do"] progressDic:@{@"MemberId":MemberId} success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        NSString *dataJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON === %@",dataJson);
        
        if (array) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                WYShoppingCarModel *model = [[WYShoppingCarModel alloc] initWithDictionary:dict];
                [muArray addObject:model];
            }
            
            weakSelf.shoppingMuArray = muArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.haveGoodsView reloadData];
            });
        }
        else {
            ZDY_LOG(@"   购物车商品列表请求失败");
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@"error == %@",error);
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
