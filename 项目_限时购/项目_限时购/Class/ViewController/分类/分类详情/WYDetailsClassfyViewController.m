//
//  WYDetailsClassfyViewController.m
//  项目_限时购
//
//  Created by ma c on 16/6/22.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYDetailsClassfyViewController.h"

#import "WYQueryModel.h"

#define BTN_RANK_TAG 22000

@interface WYDetailsClassfyViewController ()

/** 加载4个排序按钮的视图 */
@property (strong, nonatomic) UIView *fourBtnView;

/** 按钮选中状态底部的展示线 */
@property (strong, nonatomic) UILabel *wireLabel;

/** 底部展示线 的偏移量 */
@property (assign, nonatomic) CGFloat wire_Width;

/** 保存请求数据 */
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation WYDetailsClassfyViewController

/** 重写get方法 懒加载 */
- (UIView *)fourBtnView {
    if (!_fourBtnView) {
        _fourBtnView = [[UIView alloc] init];
        [_fourBtnView setBackgroundColor:[UIColor whiteColor]];
    }
    return _fourBtnView;
}

- (UILabel *)wireLabel {
    if (!_wireLabel) {
        _wireLabel = [[UILabel alloc] init];
        [_wireLabel setBackgroundColor:RGB(0, 180, 239)];
    }
    return _wireLabel;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _vcName;
    [self topAddFourBtnView];
    
    if (_start) {
        [self httpPostBrandListOrderName:[NSString stringWithFormat:@"host"] OrderType:[NSString stringWithFormat:@"DESC"]];
    }
    else {
        
    }
    
}

/** 添加排序的4个按钮 */
- (void)topAddFourBtnView {
    
    _wire_Width = self.view.frame.size.width * 0.25;
    
    [self.view addSubview:self.fourBtnView];
    WS(weakSelf);
    [_fourBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.top).offset(64);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(40);
    }];
    
    [self.view insertSubview:self.wireLabel aboveSubview:self.fourBtnView];
    [_wireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fourBtnView.bottom).offset(-1);
        make.left.equalTo(weakSelf.view);
        make.size.equalTo(CGSizeMake(_wire_Width, 1));
    }];
    
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"热门",@"价格",@"好评",@"新品", nil];
    for (NSInteger i = 0; i < titleArray.count; i ++) {
        
        UIButton *rankBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [rankBtn setTag:i + BTN_RANK_TAG];
        [rankBtn setTitle:titleArray[i] forState:(UIControlStateNormal)];
        [rankBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [rankBtn setTitleColor:RGB(0, 180, 239) forState:(UIControlStateSelected)];
        [rankBtn addTarget:self action:@selector(btnTouchActionRank:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.fourBtnView addSubview:rankBtn];
        
        if (0 == i) {
            [rankBtn setSelected:YES];
        }
        
        [rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.fourBtnView.top);
            make.left.equalTo(weakSelf.fourBtnView.left).offset(i * _wire_Width);
            make.size.equalTo(CGSizeMake(_wire_Width, 39));
        }];
    }
}

/** 4个排序按钮的点击事件 */
- (void)btnTouchActionRank:(UIButton *)rankBtn {
    
    rankBtn.selected = YES;
    CGFloat btnTag = rankBtn.tag - BTN_RANK_TAG;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect wireFrame = _wireLabel.frame;
        wireFrame.origin.x = btnTag * _wire_Width;
        _wireLabel.frame = wireFrame;
    }];
    
    for (UIButton *btn in self.fourBtnView.subviews) {
        
        if (rankBtn.tag != btn.tag) {
            btn.selected = NO;
        }
    }
}

/**
 *  根据品牌跳转至商品列表的 网络请求
 *
 *  @param OrderName 商品的排序方式
 *  @param OrderType 顺序还是倒序
 */
- (void)httpPostBrandListOrderName:(NSString *)OrderName OrderType:(NSString *)OrderType {
    
    WS(weakSelf);
    NSDictionary *requestDic = [NSDictionary dictionaryWithObjectsAndKeys:self.typeID,@"ShopId",OrderName,@"OrderName",OrderType,@"OrderType", nil];
    [self POSTHttpUrlString:[NSString stringWithFormat:@"http://123.57.141.249:8080/beautalk/appShop/appShopGoodsList.do"] progressDic:requestDic success:^(id JSON) {
        
        NSArray *array = (NSArray *)JSON;
        
        if (array.count > 0) {
            
            NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary *dict in array) {
                
                WYQueryModel *model = [[WYQueryModel alloc] initWithDic:dict];
                [muArray addObject:model];
            }
            weakSelf.dataArray = muArray;
            
        }
        else {
            [MBProgressHUD showError:[NSString stringWithFormat:@"请求数据失败"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }
        
    } failure:^(NSError *error) {
        ZDY_LOG(@" Error ==%@",error);
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
