//
//  WYGoodsTableView.m
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYGoodsTableView.h"
#import "WYNewsModel.h"
#import "WYNewCell.h"

@interface WYGoodsTableView () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation WYGoodsTableView


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
    return self.infoGoodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDCell = @"cellID";
    WYNewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[WYNewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:IDCell];
    }
    
    WYNewsModel *model = self.infoGoodsArray[indexPath.row];
    cell.cellTag = indexPath.row;
    cell.model = model;
    return cell;
}

#pragma make-
#pragma make- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_goodsCellRow) {
        _goodsCellRow(indexPath.row);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
