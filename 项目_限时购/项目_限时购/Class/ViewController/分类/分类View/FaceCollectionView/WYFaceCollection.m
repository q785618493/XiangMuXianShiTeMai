//
//  WYFaceCollection.m
//  项目_限时购
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYFaceCollection.h"
#import "WYFaceCell.h"

static NSString *IDCell = @"cellID";

static NSString *IDHead = @"headerID";

@interface WYFaceCollection () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** 分组标题头名称的 */
@property (strong, nonatomic) NSArray *titleArray;

/** 分组标题头颜色 */
@property (strong, nonatomic) NSArray *colorArray;

@end

@implementation WYFaceCollection

/** 重写get方法 懒加载 */
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"    功效专区 EFFECT",@"    面部专区 FACE",@"    身体专区 BODY",@"    品牌专区 BRAND", nil];
    }
    return _titleArray;
}

- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSArray arrayWithObjects:RGB(238, 248, 250),RGB(251, 243, 244),RGB(251, 243, 244),RGB(238, 248, 250), nil];
    }
    return _colorArray;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBounces:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self registerClass:[WYFaceCell class] forCellWithReuseIdentifier:IDCell];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDHead];
    }
    return self;
}

#pragma make-
#pragma make- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.collArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WYFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDCell forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        cell = [[WYFaceCell alloc] init];
    }
    
    cell.dataModel = self.collArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma make-
#pragma make- UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = VIEW_WIDTH * 0.25 - 2;
    return CGSizeMake(width, width);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(VIEW_WIDTH, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *nameID;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        nameID = IDHead;
    }
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:nameID forIndexPath:indexPath];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, VIEW_WIDTH, 40))];
    [titleLabel setBackgroundColor:self.colorArray[indexPath.section]];
    [titleLabel setText:self.titleArray[indexPath.section]];
    [titleLabel setTextColor:RGB(99, 99, 99)];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_collCellRow) {
        _collCellRow(indexPath.row);
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
