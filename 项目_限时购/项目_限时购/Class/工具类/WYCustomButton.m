//
//  WYCustomButton.m
//  限时购
//
//  Created by ma c on 16/5/30.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYCustomButton.h"
#import "UIButton+WebCache.h"

@implementation WYCustomButton

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)sd_setBtnImageUrlString:(NSString *)urlString forState:(UIControlState)forState {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] forState:forState];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
