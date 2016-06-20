//
//  WYFaceCell.m
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYFaceCell.h"
#import "WYFaceModel.h"
#import "WYSortModel.h"

@interface WYFaceCell ()

/** 功能分类的展示图 */
@property (strong, nonatomic) UIImageView *showImage;

/** 功能分类名称 */
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation WYFaceCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.showImage];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    [_showImage setFrame:(CGRectMake(20, 10, width - 20 * 2, width - 20 * 2))];
    [_titleLabel setFrame:(CGRectMake(0, width - 20, width, 20))];
}

/** 重写set赋值 */
- (void)setDataModel:(id)dataModel {
    _dataModel = dataModel;
    
    if ([dataModel isKindOfClass:[WYSortModel class]]) {
        
        WYSortModel *model = (WYSortModel *)dataModel;
        
        if (model.imgView.length == 0) {
            [_showImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"headLogo"]]];
        }
        else {
            [_showImage downloadImage:model.imgView];
        }
        if (model.goodsTypeName.length == 0) {
            model.goodsTypeName = [NSString stringWithFormat:@"搞机大队"];
        }
        [_titleLabel setText:model.goodsTypeName];
    }
    else {
        WYFaceModel *model = (WYFaceModel *)dataModel;
        
        if (model.imgView.length == 0) {
            [_showImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"headLogo"]]];
        }
        else {
            [_showImage downloadImage:model.imgView];
        }
        
        if (model.commodityText.length == 0) {
            model.commodityText = [NSString stringWithFormat:@"废铁战友"];
        }
        [_titleLabel setText:model.commodityText];
    }
}

/** 重写get 懒加载控件 */
- (UIImageView *)showImage {
    if (!_showImage) {
        _showImage = [[UIImageView alloc] init];
    }
    return _showImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
