//
//  WYBaseTableCell.h
//  项目_限时购
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>
#import <UIButton+WebCache.h>

#import "UIImageView+WY_SDWedImage.h"

/** 选中 cell上按钮回调的block */
typedef void(^BtnActionBlock)(NSInteger btnRow);

@interface WYBaseTableCell : UITableViewCell

@end
