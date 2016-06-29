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
            
        };
        
        _siteTableView.blockCellRow = ^(NSInteger cellRow) {
            WYModifySiteViewController *modifyVC = [[WYModifySiteViewController alloc] init];
            
            [weakSelf.navigationController pushViewController:modifyVC animated:YES];
        };
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
    
    
    [self controlAddMasonry];
}

/** 添加控件和约束 */
- (void)controlAddMasonry {
    
    WS(weakSelf);
    [self.view addSubview:self.siteTableView];
    self.muSiteArray = [self returnMuModelArray];
    self.siteTableView.dataMuArray = self.muSiteArray;
    [self.siteTableView reloadData];
    
    [_siteTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 44, 0));
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
        make.top.equalTo(weakSelf.siteTableView.bottom).offset(6);
        make.bottom.equalTo(weakSelf.view).offset(-6);
        make.right.equalTo(weakSelf.view.right).offset(-50);
        make.left.equalTo(weakSelf.view.left).offset(50);
    }];
}

- (void)btnTouchActionAdd {
    
    WYNewsSiteViewController *newsVC = [[WYNewsSiteViewController alloc] init];
    
    
    
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (NSMutableArray *)returnMuModelArray {
    
    
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 9; i ++) {
        
        WYContactsSiteModel *model = [[WYContactsSiteModel alloc] init];
        model.userName = [NSString stringWithFormat:@"闫海鱼--%.2ld",i];
        model.phoneNumber = [NSString stringWithFormat:@"13838384378--%ld",i];
        model.siteInfo = [NSString stringWithFormat:@"案发瓦工商人太多人身体好讨厌复分析和杂体验和爱人会摄入会死人感染---%.2ld",i];
        if (0 == i) {
            model.selected = YES;
        }
        [muArray addObject:model];
    }
    
    return muArray;
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
