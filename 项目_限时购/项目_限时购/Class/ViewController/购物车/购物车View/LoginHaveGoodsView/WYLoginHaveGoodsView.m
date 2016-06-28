//
//  WYLoginHaveGoodsView.m
//  项目_限时购
//
//  Created by ma c on 16/6/27.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYLoginHaveGoodsView.h"
#import "WYHaveGoodsCell.h"
#import "WYShoppingCarModel.h"

#define CELL_TAG 30000

@interface WYLoginHaveGoodsView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation WYLoginHaveGoodsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setDelegate:self];
        [self setDataSource:self];
        [self setTableFooterView:[[UIView alloc] init]];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}

#pragma make-
#pragma make- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDCell = @"cellID";
    WYHaveGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    
    if (!cell) {
        cell = [[WYHaveGoodsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:IDCell];
    }
    
    [cell.checkTheBtn addTarget:self action:@selector(btnTouchActionCheckThe:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.addBtn addTarget:self action:@selector(btnTouchActionAdd:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.reduceBtn addTarget:self action:@selector(btnTouchActionReduce:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell setTag:CELL_TAG + indexPath.row];
    WYShoppingCarModel *model = self.goodsMuArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

/** 勾选商品按钮点击事件 */
- (void)btnTouchActionCheckThe:(UIButton *)checkThe {
    
}

/** 增加商品点击事件 */
- (void)btnTouchActionAdd:(UIButton *)addBtn {
    
}

/** 减少商品点击事件 */
- (void)btnTouchActionReduce:(UIButton *)reduce {
    
}

#pragma make-
#pragma make- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:[NSString stringWithFormat:@"删除"] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self.goodsMuArray removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
        [self reloadData];
        
        if (_cellRow) {
            _cellRow(indexPath.row);
        }
    }];
    return @[rowAction];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
