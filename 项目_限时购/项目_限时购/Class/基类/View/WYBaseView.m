//
//  WYBaseView.m
//  项目_限时购
//
//  Created by ma c on 16/6/16.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYBaseView.h"

@implementation WYBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:RGB(245, 245, 245)];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:RGB(245, 245, 245)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
