//
//  WYMeTableView.m
//  项目_限时购
//
//  Created by ma c on 16/6/17.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYMeTableView.h"
#import "WYMeModel.h"

@interface WYMeTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation WYMeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBackgroundColor:RGB(245, 245, 245)];
        
    }
    return self;
}

#pragma make-
#pragma make- WYMeTableView的 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDCell = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:IDCell];
    }
    
    WYMeModel *model = self.infoArray[indexPath.row];
    [cell setBackgroundColor:RGB(245, 245, 245)];
    [cell.textLabel setText:model.title];
    [cell.detailTextLabel setText:model.detailText];
    [cell.imageView setImage:[UIImage imageNamed:model.image]];
    [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    
    return cell;
}

#pragma make-
#pragma make- WYMeTableView的 UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_meCellRow) {
        _meCellRow(indexPath.row);
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
