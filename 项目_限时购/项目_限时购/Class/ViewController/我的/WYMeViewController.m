//
//  WYMeViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYMeViewController.h"
#import "WYLoginViewController.h"
#import "WYRegisterViewController.h"
#import "WYMeTableView.h"
#import "WYMeHeaderView.h"
#import "WYMeModel.h"

@interface WYMeViewController ()

/** 保存数据信息的 数组 */
@property (strong, nonatomic) NSMutableArray *dataMuArray;

/** 展示信息的 WYMeTableView */
@property (strong, nonatomic) WYMeTableView *meTableView;

/** 未登录顶部视图 */
@property (strong, nonatomic) WYMeHeaderView *topLoginView;

/** 用户登录顶部视图 */
@property (strong, nonatomic) WYMeHeaderView *topUserView;

@end

@implementation WYMeViewController

/** 重写 get方法懒加载 */
- (NSMutableArray *)dataMuArray {
    if (!_dataMuArray) {
        NSArray *oneArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MeModel.plist" ofType:nil]];
        NSMutableArray *muArray = [NSMutableArray array];
        
        [oneArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            WYMeModel *model = [WYMeModel meModelDic:dict];
            [muArray addObject:model];
        }];
        
        _dataMuArray = muArray;
    }
    return _dataMuArray;
}

- (WYMeTableView *)meTableView {
    if (!_meTableView) {
        _meTableView = [[WYMeTableView alloc] initWithFrame:(CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)) style:(UITableViewStylePlain)];
        _meTableView.infoArray = self.dataMuArray;
    }
    return _meTableView;
}

- (WYMeHeaderView *)topLoginView {
    if (!_topLoginView) {
        _topLoginView = [WYMeHeaderView showMeHeaderViewWidth:self.view.frame.size.width height:125];
    }
    return _topLoginView;
}

- (WYMeHeaderView *)topUserView {
    if (!_topUserView) {
        _topUserView = [WYMeHeaderView userMeHeaderViewWidth:self.view.frame.size.width height:125];
    }
    return _topUserView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self controlAddMasonry];
}

/** 添加视图和约束 */
- (void)controlAddMasonry {
    WS(weakSelf);
    [self.view addSubview:self.meTableView];
    weakSelf.topLoginView.blockLogin = ^() {
        WYLoginViewController *loginVC = [[WYLoginViewController alloc] init];
        loginVC.title = [NSString stringWithFormat:@"登 录"];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    };
    
    weakSelf.topLoginView.blockRegister = ^() {
        WYRegisterViewController *registerVC = [[WYRegisterViewController alloc] init];
        registerVC.title = [NSString stringWithFormat:@"注 册"];
        [registerVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:registerVC animated:YES];
    };
    
    
    [_meTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.meTableView setTableHeaderView:self.topLoginView];
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
