//
//  WYConfirmOrderViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYConfirmOrderViewController.h"
#import "WYConfirmOrderTableView.h"

@interface WYConfirmOrderViewController ()

/** 展示商品信息的 TableView */
@property (strong, nonatomic) WYConfirmOrderTableView *goodsTableView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.goodsTableView];
    
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
