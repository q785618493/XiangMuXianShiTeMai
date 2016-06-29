//
//  WYConfirmOrderViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYConfirmOrderViewController.h"
#import "WYConfirmOrderTableView.h"
#import "WYBottomPaymentView.h"

@interface WYConfirmOrderViewController ()

/** 展示商品信息的 TableView */
@property (strong, nonatomic) WYConfirmOrderTableView *goodsTableView;

/** 底部视图 */
@property (strong, nonatomic) WYBottomPaymentView *bottomView;

@end

@implementation WYConfirmOrderViewController

/** 懒加载 */
- (WYConfirmOrderTableView *)goodsTableView {
    if (!_goodsTableView) {
        _goodsTableView = [[WYConfirmOrderTableView alloc] initWithFrame:(CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 45)) style:(UITableViewStylePlain)];
        _goodsTableView.goodsArray = self.dataArray;
    }
    return _goodsTableView;
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
