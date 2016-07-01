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
#import "WYDeliveryAddressViewController.h"
#import "WYMeCollectViewController.h"

#import "WYMeTableView.h"
#import "WYMeHeaderView.h"
#import "WYMeModel.h"

/** 保存用户头像的路径 */
#define USER_HEADER_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"headerImage"]

/** 用户信息的 key */
static NSString *userInfo = @"userInfo";
/** 判断登录状态 */
static NSString *status = @"status";
/** 用户头像 */
static NSString *keyHeader = @"imageUser";

@interface WYMeViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
        
        //解档没有获得数据,获取用户未登录状态的数据
        if (!_dataMuArray) {
            _dataMuArray = [self returnModelArray];
        }
    }
    return _dataMuArray;
}

/** 获得默认未登录状态的数据 */
- (NSMutableArray *)returnModelArray {
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MeModel.plist" ofType:nil]];
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        WYMeModel *model = [[WYMeModel alloc] initWithDic:dict];
        [muArray addObject:model];
    }
    return muArray;
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
        _quitView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 45))];
        [_quitView setBackgroundColor:RGB(245, 245, 245)];
    }
    return _quitView;
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_exitBtn setBackgroundColor:RGB(55, 183, 236)];
        [_exitBtn setTitle:[NSString stringWithFormat:@"退出登录"] forState:(UIControlStateNormal)];
        [_exitBtn.layer setMasksToBounds:YES];
        [_exitBtn.layer setCornerRadius:5];
        [_exitBtn addTarget:self action:@selector(btnTouchActionExit) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _exitBtn;
}

/** 用户退出登录按钮点击事件 */
- (void)btnTouchActionExit {
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"是否退出"] message:[NSString stringWithFormat:@"确定按钮退出当前登录账户,取消按钮保留当前用户状态"] preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"确 定"] style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"退出成功"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            
            //删除保存的用户数据
            BOOL removeData = [[NSFileManager defaultManager] removeItemAtPath:INFO_PATH error:nil];
            
            if (removeData) {
                /** 删除用户信息 */
                [XSG_USER_DEFAULTS removeObjectForKey:userInfo];
                [XSG_USER_DEFAULTS removeObjectForKey:LOGIN_USER];
                BOOL siteRemove = [[NSFileManager defaultManager] removeItemAtPath:SITE_PATH error:nil];
                /** 删除登录状态 */
                [XSG_USER_DEFAULTS removeObjectForKey:status];
                weakSelf.meTableView.infoArray = [self returnModelArray];
                [weakSelf.topUserView hiddenDeleteView];
                [weakSelf.quitView removeFromSuperview];
                [weakSelf controlAddMasonryNotLogin];
                [weakSelf.meTableView reloadData];
            }
        });
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
    /** 判断用户是否登录 */
    [self judgeUserIsLogin];
}

/** 判断用户是否登录 */
- (void)judgeUserIsLogin {
    
    /** 获取登录状态 */
    BOOL isStatu = [XSG_USER_DEFAULTS boolForKey:status];
    
    /** 判断登录状态 */
    if (isStatu) {
        [self controlAddMasonryLoginUser];
    }
    else {
        [self controlAddMasonryNotLogin];
    }
}

/** 添加未登录状态的视图和约束 */
- (void)controlAddMasonryNotLogin {
    WS(weakSelf);
    [self.view addSubview:self.meTableView];
    [self.meTableView setTableHeaderView:self.topLoginView];
    [self.meTableView setTableFooterView:self.lineView];
    [_meTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    weakSelf.topLoginView.blockLogin = ^() {
        WYLoginViewController *loginVC = [[WYLoginViewController alloc] init];
        loginVC.title = [NSString stringWithFormat:@"登 录"];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
        
        loginVC.passBackMe = ^(NSArray *meTableArray, NSDictionary *userDic, BOOL isStatus) {
            
            [weakSelf.topLoginView hiddenDeleteView];
            [weakSelf.lineView removeFromSuperview];
            
            [weakSelf.meTableView setTableHeaderView:weakSelf.topUserView];
            weakSelf.topUserView.meDic = userDic;
            [weakSelf replaceUserHeaderImage];
            
            [weakSelf.meTableView setTableFooterView:weakSelf.quitView];
            [weakSelf.quitView addSubview:weakSelf.exitBtn];
            weakSelf.meTableView.meCellRow = ^(NSInteger cellRow) {
                WYDeliveryAddressViewController *deliveryVC = [[WYDeliveryAddressViewController alloc] init];
                [weakSelf.navigationController pushViewController:deliveryVC animated:YES];
            };
            
            [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(weakSelf.quitView).with.insets(UIEdgeInsetsMake(5, 50, 5, 50));
            }];
            
            weakSelf.dataMuArray = [weakSelf returnModelArray];
            [weakSelf.dataMuArray addObjectsFromArray:meTableArray];
            
            weakSelf.meTableView.infoArray = weakSelf.dataMuArray;
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
        [weakSelf.navigationController pushViewController:registerVC animated:YES];
    };
}

/** 添加登录状态的视图和约束 */
- (void)controlAddMasonryLoginUser {
    WS(weakSelf);
    /** 获取本地保存的用户数据信息 */
    NSDictionary *dict = [XSG_USER_DEFAULTS dictionaryForKey:userInfo];
    
    [self.view addSubview:self.meTableView];
    [_meTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    self.topUserView.meDic = dict;
    [self replaceUserHeaderImage];
    
    NSData *data = [NSData dataWithContentsOfFile:USER_HEADER_PATH];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image) {
        [self.topUserView setValue:image forKey:keyHeader];
        [self replaceUserHeaderImage];
    }
    [self.meTableView setTableHeaderView:self.topUserView];
    [self.meTableView setTableFooterView:self.quitView];
    [self.quitView addSubview:self.exitBtn];
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.quitView).with.insets(UIEdgeInsetsMake(5, 50, 5, 50));
    }];
    
    weakSelf.meTableView.meCellRow = ^(NSInteger cellRow) {
        
        switch (cellRow) {
            case 0: {
                WYMeCollectViewController *collectVC = [[WYMeCollectViewController alloc] init];
                NSDictionary *userDic = [XSG_USER_DEFAULTS objectForKey:LOGIN_USER];
                collectVC.userID = userDic[@"MemberId"];
                [weakSelf.navigationController pushViewController:collectVC animated:YES];
            }
                
                break;
            case 1: {
                
            }
                
                break;
            case 2: {
                
            }
                
                break;
            case 3: {
                
            }
                
                break;
            case 4: {
                
            }
                
                break;
            case 5: {
                
            }
                
                break;
                
            case 6: {
                WYDeliveryAddressViewController *deliveryVC = [[WYDeliveryAddressViewController alloc] init];
                [weakSelf.navigationController pushViewController:deliveryVC animated:YES];
            }
                
            default:
                break;
        }
        
    };
}

/** 用户按钮点击事件,替换用户头像 */
- (void)replaceUserHeaderImage {
    WS(weakSelf);
    weakSelf.topUserView.blockUser = ^() {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"替换头像"] message:[NSString stringWithFormat:@"相机拍照,即时拍摄分享上传!相册选择,找到喜欢照片上传!取消不替换头像"] preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIAlertAction *camera = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"相机拍照"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *pickerCamera = [[UIImagePickerController alloc] init];
            [pickerCamera setSourceType:(UIImagePickerControllerSourceTypeCamera)];
            [pickerCamera setDelegate:self];
            [pickerCamera setAllowsEditing:YES];
            [weakSelf presentViewController:pickerCamera animated:YES completion:nil];
        }];
        
        UIAlertAction *photo = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"相册选择"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *pickerPhoto = [[UIImagePickerController alloc] init];
            [pickerPhoto setAllowsEditing:YES];
            [pickerPhoto setDelegate:self];
            [weakSelf presentViewController:pickerPhoto animated:YES completion:nil];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"⭐️取消⭐️"] style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:camera];
        [alertC addAction:photo];
        [alertC addAction:cancel];
        [weakSelf presentViewController:alertC animated:YES completion:nil];
    };
}

#pragma make-
#pragma make- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self.topUserView setValue:image forKey:keyHeader];
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"headerImage"];
    
    [UIImagePNGRepresentation(image) writeToFile:USER_HEADER_PATH atomically:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
