//
//  WYSiteTableView.m
//  项目_限时购
//
//  Created by ma c on 16/6/29.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYSiteTableView.h"
#import "WYSiteCell.h"

#import "WYContactsSiteModel.h"

#define CELL_TAG 43000

@interface WYSiteTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation WYSiteTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBounces:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    }
    return self;
}

#pragma make-
#pragma make- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDCell = @"cellID";
    WYSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[WYSiteCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:IDCell];
    }
    
    cell.model = self.dataMuArray[indexPath.row];
    cell.cellTag = indexPath.row + CELL_TAG;
    
    [cell.selectedBtn addTarget:self action:@selector(btnTouchActionSelected:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.editBtn addTarget:self action:@selector(btnTouchActionEdit:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.deleteBtn addTarget:self action:@selector(btnTouchActionDelete:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

- (void)btnTouchActionSelected:(UIButton *)selectedBtn {
    
    NSInteger indexRow = selectedBtn.tag - CELL_TAG - 1000;
    
    for (NSInteger i = 0; i < self.dataMuArray.count; i ++) {
        WYContactsSiteModel *model = self.dataMuArray[i];
        
        if (i == indexRow) {
            model.selected = YES;
        }
        else {
            model.selected = NO;
        }
    }
    
    if (_blockMuArray) {
        _blockMuArray(self.dataMuArray);
    }
    [self reloadData];
}

- (void)btnTouchActionEdit:(UIButton *)edit {
    
    NSInteger indexRow = edit.tag - CELL_TAG - 2000;
    
    if (_blockCellRow) {
        _blockCellRow(indexRow);
    }
    
}

- (void)btnTouchActionDelete:(UIButton *)delete {
    
    NSInteger indexRow = delete.tag - CELL_TAG - 3000;
    [self.dataMuArray removeObjectAtIndex:indexRow];
    [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexRow inSection:0]] withRowAnimation:(UITableViewRowAnimationRight)];
    [self reloadData];
    if (_blockMuArray) {
        _blockMuArray(self.dataMuArray);
    }
}

#pragma make-
#pragma make- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:[NSString stringWithFormat:@"删除"] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [weakSelf.dataMuArray removeObjectAtIndex:indexPath.row];
        [weakSelf deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
        [weakSelf reloadData];
        
        if (_blockMuArray) {
            _blockMuArray(weakSelf.dataMuArray);
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
