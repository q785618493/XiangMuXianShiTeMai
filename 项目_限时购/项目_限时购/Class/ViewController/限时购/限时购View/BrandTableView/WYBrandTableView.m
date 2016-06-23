//
//  WYBrandTableView.m
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBrandTableView.h"
#import "WYSaleModel.h"
#import "WYBrandCell.h"

@interface WYBrandTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation WYBrandTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBounces:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    }
    return self;
}

#pragma make-
#pragma make- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoBrandArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDCell = @"cellID";
    WYBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[WYBrandCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:IDCell];
    }
    
    WYSaleModel *model = self.infoBrandArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma make- 
#pragma make- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_brandCellRow) {
        _brandCellRow(indexPath.row);
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
