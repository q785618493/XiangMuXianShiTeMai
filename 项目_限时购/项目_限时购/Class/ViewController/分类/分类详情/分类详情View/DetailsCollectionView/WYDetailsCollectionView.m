//
//  WYDetailsCollectionView.m
//  项目_限时购
//
//  Created by ma c on 16/6/24.
//  Copyright © 2016年 WY. All rights reserved.
//

#import "WYDetailsCollectionView.h"
#import "WYDetailsCell.h"

static NSString *IDColl = @"collID";

@interface WYDetailsCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation WYDetailsCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBounces:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self registerClass:[WYDetailsCell class] forCellWithReuseIdentifier:IDColl];
    }
    return self;
}

#pragma make-
#pragma make- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WYDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDColl forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        cell = [[WYDetailsCell alloc] init];
    }
    
    cell.model = self.infoArray[indexPath.row];
    
    return cell;
}

#pragma make-
#pragma make- UICollectionViewDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 6;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(VIEW_WIDTH * 0.5 - 3, VIEW_WIDTH * 0.5 - 3 + 70);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_collRow) {
        _collRow(indexPath);
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
