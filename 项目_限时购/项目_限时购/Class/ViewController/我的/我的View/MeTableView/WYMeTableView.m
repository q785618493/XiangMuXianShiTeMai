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
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
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
    [cell setBackgroundColor:RGB(245, 245, 245)];
    WYMeModel *model = self.infoArray[indexPath.row];
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width, 30))];
//    [bgView setBackgroundColor:[UIColor whiteColor]];
//    return bgView;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
