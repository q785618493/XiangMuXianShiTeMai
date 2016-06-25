//
//  WYSearchViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/20.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYSearchViewController.h"
#import "WYDetailsClassfyViewController.h"

@interface WYSearchViewController () <UISearchBarDelegate>

/** 搜索框 */
@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation WYSearchViewController

/** 懒加载 */
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(0, 0, 220, 31))];
        [_searchBar setDelegate:self];
        [_searchBar setSearchBarStyle:(UISearchBarStyleDefault)];
        [_searchBar setKeyboardType:(UIKeyboardTypeDefault)];
        [_searchBar setPlaceholder:[NSString stringWithFormat:@"请输入商品名称"]];
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self searchAddView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

/** 添加搜索框 */
- (void)searchAddView {
    
    [self.navigationItem setTitleView:self.searchBar];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"取消"] style:(UIBarButtonItemStylePlain) target:self action:@selector(barBtnItemActionRight)];
    [self.navigationItem setRightBarButtonItem:rightBarBtn];
}

/** 右边取消按钮点击事件 */
- (void)barBtnItemActionRight {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

#pragma make-
#pragma make- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchBar resignFirstResponder];
    WYDetailsClassfyViewController *detailsVC = [[WYDetailsClassfyViewController alloc] init];
    detailsVC.judgeRequest = 2;
    detailsVC.start = YES;
    detailsVC.title = searchBar.text;
    [self.navigationController pushViewController:detailsVC animated:YES];
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
