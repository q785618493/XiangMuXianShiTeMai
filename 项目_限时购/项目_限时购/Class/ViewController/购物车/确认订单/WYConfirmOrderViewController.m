//
//  WYConfirmOrderViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYConfirmOrderViewController.h"
#import "WYDeliveryAddressViewController.h"

#import "WYConfirmOrderTableView.h"
#import "WYBottomPaymentView.h"
#import "WYTopConfirmView.h"

@interface WYConfirmOrderViewController ()

/** 展示商品信息的 TableView */
@property (strong, nonatomic) WYConfirmOrderTableView *goodsTableView;

/** 顶部用户收货信息视图 */
@property (strong, nonatomic) WYTopConfirmView *topConfirmView;

/** 底部视图 */
@property (strong, nonatomic) WYBottomPaymentView *bottomView;

@end

@implementation WYConfirmOrderViewController

/** 懒加载 */
- (WYConfirmOrderTableView *)goodsTableView {
    if (!_goodsTableView) {
        _goodsTableView = [[WYConfirmOrderTableView alloc] initWithFrame:(CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 45)) style:(UITableViewStylePlain)];
        _goodsTableView.goodsArray = self.dataArray;
        [_goodsTableView setTableHeaderView:self.topConfirmView];
    }
    return _goodsTableView;
}

- (WYTopConfirmView *)topConfirmView {
    if (!_topConfirmView) {
        _topConfirmView = [[WYTopConfirmView alloc] initWithFrame:(CGRectMake(0, 0, VIEW_WIDTH, 96))];
    }
    return _topConfirmView;
}

- (WYBottomPaymentView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WYBottomPaymentView alloc] init];
    }
    return _bottomView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 添加控件和约束 */
    [self controlAddMasonry];
    
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    
    [self.view addSubview:self.goodsTableView];
    [self.view addSubview:self.bottomView];
    self.bottomView.price = self.goodsPrice;
    
    WS(weakSelf);
    [_goodsTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 45, 0));
    }];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodsTableView.bottom);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.bottom);
    }];
    
    weakSelf.bottomView.blockPayment = ^() {
        
        ZDY_LOG(@"   -------------------   ");
    };
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [chooseBtn setBackgroundColor:RGB(248, 248, 248)];
    [chooseBtn setTitle:[NSString stringWithFormat:@"选择地址"] forState:(UIControlStateNormal)];
    [chooseBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [chooseBtn sizeToFit];
    [chooseBtn setTitleColor:RGB(253, 249, 246) forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(btnTouchActionChoose) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}
- (void)btnTouchActionChoose {
    WYDeliveryAddressViewController *deliveryVC = [[WYDeliveryAddressViewController alloc] init];
    [self.navigationController pushViewController:deliveryVC animated:YES];
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
