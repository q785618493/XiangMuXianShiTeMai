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

@end

@implementation WYDetailsClassfyViewController

/** 重写get方法懒加载 */
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _vcName;
    [self topAddFourBtnView];
    
    if (_start) {
        ZDY_LOG(@"%@",_typeID);
    }
    else {
        ZDY_LOG(@"%@",_typeID);
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
