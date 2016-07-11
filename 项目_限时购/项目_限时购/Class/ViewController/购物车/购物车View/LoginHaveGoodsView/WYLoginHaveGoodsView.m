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
    
    cell.cellTag = CELL_TAG + indexPath.row;
    WYShoppingCarModel *model = self.goodsMuArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

/** 勾选商品按钮点击事件 */
- (void)btnTouchActionCheckThe:(UIButton *)checkThe {
    
    /** 获取控件的父视图 */
//    UIView *cell = [[[checkThe superview] superview] superview];
    
    NSInteger indexRow = checkThe.tag - CELL_TAG - 1000;
    
    WYShoppingCarModel *model = self.goodsMuArray[indexRow];
    
    CGFloat goodsPrice = 0;
    CGFloat price = [model.price floatValue];
    NSInteger count = [model.goodsCount integerValue];
    
    if (checkThe.selected) {
        
        goodsPrice -= price * (count * 1.0);
    }
    else {
        goodsPrice += price * (count * 1.0);
    }
    model.selected = !checkThe.selected;
//    checkThe.selected = !checkThe.selected;
    
    if (_blockPrice) {
        _blockPrice(self.goodsMuArray);
    }
    [self reloadData];
}

/** 增加商品点击事件 */
- (void)btnTouchActionAdd:(UIButton *)addBtn {
    
    NSInteger indexRow = addBtn.tag - CELL_TAG - 3000;
    WYShoppingCarModel *model = self.goodsMuArray[indexRow];
    
    CGFloat goodsPrice = 0;
    CGFloat price = [model.price floatValue];
    NSInteger count = [model.goodsCount integerValue];
    count ++;
    
    goodsPrice = price * 1.0;
    
    model.goodsCount = [NSString stringWithFormat:@"%ld",count];
    
    if (_blockPrice) {
        _blockPrice(self.goodsMuArray);
    }
    
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexRow inSection:0]] withRowAnimation:(UITableViewRowAnimationFade)];

}

/** 减少商品点击事件 */
- (void)btnTouchActionReduce:(UIButton *)reduce {
    
    NSInteger indexRow = reduce.tag - CELL_TAG - 2000;
    
    WYShoppingCarModel *model = self.goodsMuArray[indexRow];
    
    CGFloat goodsPrice = 0;
    CGFloat price = [model.price floatValue];
    NSInteger count = [model.goodsCount integerValue];
    count --;
    goodsPrice -= price * 1.0;
    
    model.goodsCount = [NSString stringWithFormat:@"%ld",count];
    
    if (_blockPrice) {
        _blockPrice(self.goodsMuArray);
    }
    
    if (count == -1) {

        [self.goodsMuArray removeObjectAtIndex:indexRow];
        [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexRow inSection:0]] withRowAnimation:(UITableViewRowAnimationLeft)];
        
        if (_blockPrice) {
            _blockPrice(self.goodsMuArray);
        }
        
        [self reloadData];
        return;
    }
    
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexRow inSection:0]] withRowAnimation:(UITableViewRowAnimationFade)];
    
    
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
    
    WS(weakSelf);
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:[NSString stringWithFormat:@"删除"] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        WYShoppingCarModel *model = weakSelf.goodsMuArray[indexPath.row];
        CGFloat goodsPrice = 0;
        CGFloat price = [model.price floatValue];
        NSInteger count = [model.goodsCount integerValue];
        goodsPrice -= price * (count * 1.0);
        
        [weakSelf.goodsMuArray removeObjectAtIndex:indexPath.row];
        
        if (_blockPrice) {
            _blockPrice(weakSelf.goodsMuArray);
        }
        
        [weakSelf deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
        [weakSelf reloadData];
        
        
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
