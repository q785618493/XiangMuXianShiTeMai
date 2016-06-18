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

#define INFO_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"infoArray.data"]

#define XSG_USER_DEFAULTS [NSUserDefaults standardUserDefaults]

static NSString *userInfo = @"userInfo";

static NSString *status = @"status";

@interface WYMeViewController ()

/** 保存数据信息的 数组 */
@property (strong, nonatomic) NSMutableArray *dataMuArray;

/** 展示信息的 WYMeTableView */
@property (strong, nonatomic) WYMeTableView *meTableView;

/** 未登录顶部视图 */
@property (strong, nonatomic) WYMeHeaderView *topLoginView;

/** 用户登录成功顶部视图 */
@property (strong, nonatomic) WYMeHeaderView *topUserView;

/** 用户登录成功底部退出登录视图 */
@property (strong, nonatomic) UIView *quitView;

/** 用户登录成功底部退出登录按钮 */
@property (strong, nonatomic) UIButton *exitBtn;

/** TabelView 分割线视图 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation WYMeViewController

/** 重写 get方法懒加载 */
- (NSMutableArray *)dataMuArray {
    if (!_dataMuArray) {
        
        //解档数组
        _dataMuArray = [NSKeyedUnarchiver unarchiveObjectWithFile:INFO_PATH];
        
        if (!_dataMuArray) {
            NSArray *oneArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MeModel.plist" ofType:nil]];
            NSMutableArray *muArray = [NSMutableArray array];
            
            [oneArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                WYMeModel *model = [WYMeModel meModelDic:dict];
                [muArray addObject:model];
            }];
            
            _dataMuArray = muArray;
        }
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

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
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

- (UIView *)quitView {
    if (!_quitView) {
        _quitView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 65))];
        [_quitView setBackgroundColor:RGB(245, 245, 245)];
    }
    return _quitView;
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_exitBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"我的界面退出登录按钮"]] forState:(UIControlStateNormal)];
        [_exitBtn addTarget:self action:@selector(btnTouchActionExit) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _exitBtn;
}

/** 用户退出登录按钮点击事件 */
- (void)btnTouchActionExit {
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"是否退出"] message:[NSString stringWithFormat:@"确定按钮退出当前登录账户,取消按钮保留当前用户状态"] preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"确 定"] style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        //删除保存的用户数据
        [[NSFileManager defaultManager] removeItemAtPath:INFO_PATH error:nil];
        [XSG_USER_DEFAULTS removeObjectForKey:status];
        
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MeModel.plist" ofType:nil]];
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            WYMeModel *model = [[WYMeModel alloc] initWithDic:dict];
            [muArray addObject:model];
        }
        weakSelf.meTableView.infoArray = muArray;
        [weakSelf.topUserView hiddenDeleteView];
        [weakSelf.quitView removeFromSuperview];
        [weakSelf.meTableView setTableHeaderView:weakSelf.topLoginView];
        [weakSelf.meTableView setTableFooterView:weakSelf.lineView];
        [weakSelf.meTableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"取 消"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:determineAction];
    [alertC addAction:cancelAction];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self controlAddMasonry];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BOOL isStatu = [XSG_USER_DEFAULTS boolForKey:status];
    
    NSDictionary *dict = [XSG_USER_DEFAULTS dictionaryForKey:userInfo];
    
    if (isStatu) {
        WS(weakSelf);
        [self.meTableView setTableHeaderView:self.topUserView];
        self.topUserView.meDic = dict;
        [self.meTableView setTableFooterView:self.quitView];
        [self.quitView addSubview:self.exitBtn];
        [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.quitView).with.insets(UIEdgeInsetsMake(10, 16, 10, 16));
        }];
    }
    else {
        [self.meTableView setTableFooterView:self.lineView];
        [self.meTableView setTableHeaderView:self.topLoginView];
    }
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
        
        loginVC.passBackMe = ^(NSArray *meTableArray, NSDictionary *userDic, BOOL isStatus) {
            
            [weakSelf.topLoginView hiddenDeleteView];
            [weakSelf.lineView removeFromSuperview];
            [weakSelf.meTableView setTableHeaderView:weakSelf.topUserView];
            [weakSelf.meTableView setTableFooterView:weakSelf.quitView];
            [weakSelf.quitView addSubview:weakSelf.exitBtn];
            
            [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(weakSelf.quitView).with.insets(UIEdgeInsetsMake(5, 16, 5, 16));
            }];
            
            [weakSelf.dataMuArray addObjectsFromArray:meTableArray];
            [weakSelf.meTableView reloadData];
            
            //偏好设置存储
            [XSG_USER_DEFAULTS setObject:userDic forKey:userInfo];
            [XSG_USER_DEFAULTS setBool:isStatus forKey:status];
            
            //归档数组
            [NSKeyedArchiver archiveRootObject:weakSelf.dataMuArray toFile:INFO_PATH];
        };
    };
    
    weakSelf.topLoginView.blockRegister = ^() {
        WYRegisterViewController *registerVC = [[WYRegisterViewController alloc] init];
        registerVC.title = [NSString stringWithFormat:@"注 册"];
        [registerVC setHidesBottomBarWhenPushed:YES];
        [weakSelf.navigationController pushViewController:registerVC animated:YES];
    };
    
    
    [_meTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
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
