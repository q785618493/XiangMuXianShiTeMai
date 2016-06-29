//
//  WYDeliveryAddressViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYDeliveryAddressViewController.h"
#import "WYNewsSiteViewController.h"
#import "WYModifySiteViewController.h"

#import "WYSiteTableView.h"
#import "WYContactsSiteModel.h"

@interface WYDeliveryAddressViewController ()

/** 展示所有收货地址的视图 */
@property (strong, nonatomic) WYSiteTableView *siteTableView;

/** 保存所有的收货地址 */
@property (strong, nonatomic) NSMutableArray *muSiteArray;

@end

@implementation WYDeliveryAddressViewController

/** 懒加载 */
- (WYSiteTableView *)siteTableView {
    if (!_siteTableView) {
        _siteTableView = [[WYSiteTableView alloc] initWithFrame:(CGRectMake(0, 64, 0, 0)) style:(UITableViewStylePlain)];
    }
    return _siteTableView;
}

- (NSMutableArray *)muSiteArray {
    if (!_muSiteArray) {
        
        _muSiteArray = [NSKeyedUnarchiver unarchiveObjectWithData:SITE_PATH];
        if (!_muSiteArray) {
            _muSiteArray = [NSMutableArray array];
        }
    }
    return _muSiteArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString  stringWithFormat:@"收货地址"];
    
    
    
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
