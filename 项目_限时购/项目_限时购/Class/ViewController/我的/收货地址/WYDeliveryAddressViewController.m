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
        
        WS(weakSelf);
        _siteTableView.blockMuArray = ^(NSMutableArray *muArray) {
            weakSelf.muSiteArray = nil;
            weakSelf.muSiteArray = muArray;
            [NSKeyedArchiver archiveRootObject:weakSelf.muSiteArray toFile:SITE_PATH];
            
        };
        
        _siteTableView.blockCellRow = ^(NSInteger cellRow) {
            
            WYModifySiteViewController *modifyVC = [[WYModifySiteViewController alloc] init];
            modifyVC.model = weakSelf.muSiteArray[cellRow];
            modifyVC.cellRow = cellRow;
            
            modifyVC.blockModify = ^(WYContactsSiteModel *model, NSInteger cellRow) {
                
                WYContactsSiteModel *newsModel = weakSelf.muSiteArray[cellRow];
                newsModel.userName = model.userName;
                newsModel.phoneNumber = model.phoneNumber;
                newsModel.siteInfo = model.siteInfo;
                [NSKeyedArchiver archiveRootObject:weakSelf.muSiteArray toFile:SITE_PATH];
                [weakSelf.siteTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cellRow inSection:0]] withRowAnimation:(UITableViewRowAnimationRight)];
                
            };
            [weakSelf.navigationController pushViewController:modifyVC animated:YES];
        };
    }
    return _siteTableView;
}

- (NSMutableArray *)muSiteArray {
    if (!_muSiteArray) {
        
        _muSiteArray = [NSKeyedUnarchiver unarchiveObjectWithFile:SITE_PATH];
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self controlAddMasonry];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    
    WS(weakSelf);
    [self.view addSubview:self.siteTableView];
    self.siteTableView.dataMuArray = self.muSiteArray;
    
    [_siteTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 55, 0));
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addBtn setBackgroundColor:RGB(55, 183, 236)];
    [addBtn.layer setMasksToBounds:YES];
    [addBtn.layer setCornerRadius:5];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [addBtn setTitle:[NSString stringWithFormat:@"添加新的收货地址"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(btnTouchActionAdd) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addBtn];
    
    [addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.siteTableView.bottom).offset(10);
        make.bottom.equalTo(weakSelf.view).offset(-10);
        make.right.equalTo(weakSelf.view.right).offset(-50);
        make.left.equalTo(weakSelf.view.left).offset(50);
    }];
}

- (void)btnTouchActionAdd {
    
    WYNewsSiteViewController *newsVC = [[WYNewsSiteViewController alloc] init];
    WS(weakSelf);
    newsVC.blockBack = ^(WYContactsSiteModel *model) {
        
        [weakSelf.muSiteArray addObject:model];
        [weakSelf.siteTableView reloadData];
        [NSKeyedArchiver archiveRootObject:weakSelf.muSiteArray toFile:SITE_PATH];
    };
    
    [self.navigationController pushViewController:newsVC animated:YES];
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
