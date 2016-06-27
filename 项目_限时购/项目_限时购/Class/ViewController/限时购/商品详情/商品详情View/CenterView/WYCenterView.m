//
//  WYCenterView.m
//  限时购
//
//  Created by ma c on 16/5/30.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYCenterView.h"
#import "WYAllDetailsModel.h"
#import "UIImageView+WY_SDWedImage.h"

@interface WYCenterView()

@property (weak, nonatomic) UIImageView *countryImage;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *priceLabel;
@property (weak, nonatomic) UILabel *introduceLabel;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *shopName;
@property (weak, nonatomic) UILabel *countryLabel;

@end

@implementation WYCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = frame.size.width;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, width, 20))];
        [titleLabel setBackgroundColor:[UIColor whiteColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 20, width, 73))];
        [priceLabel setBackgroundColor:[UIColor whiteColor]];
        [priceLabel setTextAlignment:(NSTextAlignmentCenter)];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UILabel *introduceLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(priceLabel.frame) + 1, width, 57))];
        [introduceLabel setBackgroundColor:[UIColor whiteColor]];
        [introduceLabel setTextColor:RGB(169, 169, 169)];
        [introduceLabel setTextAlignment:(NSTextAlignmentCenter)];
        [introduceLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:introduceLabel];
        self.introduceLabel = introduceLabel;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:(CGRectMake(0, CGRectGetMaxY(introduceLabel.frame) + 10, width, 80))];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bottomView];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(5, 5, 100, 70))];
        [bottomView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *shopName = [[UILabel alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 10, width - 230, 20))];
        [shopName setFont:[UIFont systemFontOfSize:14]];
        [bottomView addSubview:shopName];
        self.shopName = shopName;
        
        UIImageView *countryImage = [[UIImageView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 35, 35, 35))];
        [countryImage.layer setMasksToBounds:YES];
        [countryImage.layer setCornerRadius:17.5];
        [bottomView addSubview:countryImage];
        self.countryImage = countryImage;
        
        UILabel *countryLabel = [[UILabel alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(countryImage.frame) + 5, 43, width - 270, 20))];
        [countryLabel setFont:[UIFont systemFontOfSize:14]];
        [bottomView addSubview:countryLabel];
        self.countryLabel = countryLabel;
        
        UIImageView *lookImage = [[UIImageView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(countryLabel.frame), 0, width - CGRectGetMaxX(countryLabel.frame) - 5, 80))];
        [lookImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"查看商品"]]];
        [lookImage setUserInteractionEnabled:YES];
        [bottomView addSubview:lookImage];
        
        UIButton *actionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [actionBtn setFrame:(CGRectMake(0, 0, width, 80))];
        [actionBtn addTarget:self action:@selector(btnTouchActionLook) forControlEvents:(UIControlEventTouchUpInside)];
        [bottomView addSubview:actionBtn];
    }
    return self;
}

- (void)btnTouchActionLook {
    
    if (_btnAction) {
        _btnAction();
    }
}

- (void)setCountryUrl:(NSString *)countryUrl {
    _countryUrl = countryUrl;
    
    [self.countryImage downloadImage:countryUrl];
}

- (void)setModel:(WYAllDetailsModel *)model {
    _model = model;
    
    [self.titleLabel setText:model.abbreviation];
    [self.introduceLabel setText:model.goodsIntro];
    [self.countryLabel setText:model.countryName];
    [self.shopName setText:model.brandCNName];
    [self.imageView downloadImage:model.shopImage];
    
    NSAttributedString *pricStr = [[NSAttributedString alloc] initWithString:model.price attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName : RGB(255, 64, 12)}];
    
    NSAttributedString *OriginalPrice = [[NSAttributedString alloc] initWithString:model.originalPrice attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : RGB(169, 169, 169),NSStrikethroughStyleAttributeName:@(1)}];
    
    NSAttributedString *Discount = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" (%@折)",model.discount] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    NSMutableAttributedString *infoString = [[NSMutableAttributedString alloc] init];
    [infoString insertAttributedString:pricStr atIndex:0];
    [infoString insertAttributedString:OriginalPrice atIndex:[pricStr length]];
    [infoString insertAttributedString:Discount atIndex:pricStr.length + OriginalPrice.length];
    [self.priceLabel setAttributedText:infoString];
}

//- (NSMutableAttributedString *)makeMutabelAttriButedStringModel:(WYAllDetailsModel *)model {
//    
//    NSString *nameStr = [NSString stringWithFormat:@"%@ - %@  ",model.originalPrice,model.originalPrice];
//    
//    NSDictionary * nameDic = @{NSFontAttributeName : [UIFont systemFontOfSize:16],
//                               NSForegroundColorAttributeName : [UIColor whiteColor],
//                               };
//    
//    NSAttributedString * attributed = [[NSAttributedString alloc]initWithString:nameStr attributes:nameDic];
//    
//    NSString * nameLabelStr = [NSString stringWithFormat:@" %@ ",model.countryName];
//    
//    NSDictionary * nameLabelDic = @{
//                                    NSFontAttributeName : [UIFont systemFontOfSize:11.0],
//                                    NSForegroundColorAttributeName : [UIColor whiteColor],
//                                    NSBackgroundColorAttributeName :[UIColor colorWithRed:227.0/255.0 green:168.0/255.0 blue:88.0/255.0 alpha:1],
//                                    NSBaselineOffsetAttributeName: @1.5
//                                    };
//    
//    NSMutableAttributedString * mutabelAttributed = [[NSMutableAttributedString alloc]init];
//    
//    NSAttributedString * Attributed = [[NSAttributedString alloc]initWithString:nameLabelStr attributes:nameLabelDic];
//    
//    [mutabelAttributed insertAttributedString:attributed atIndex:0];
//    
//    [mutabelAttributed insertAttributedString:Attributed atIndex:[attributed length]];
//    
//    return mutabelAttributed;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
