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

#pragma make-
#pragma make- UITableViewDelegate

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
