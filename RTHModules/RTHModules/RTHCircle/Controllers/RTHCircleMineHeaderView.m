//
//  RTHCircleMineHeaderView.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/13.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCircleMineHeaderView.h"
#import "RTHCircleCycleCell.h"

@interface RTHCircleMineHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *colors;
@end

@implementation RTHCircleMineHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCollectionViewInformation];
}

- (void)setCollectionViewInformation {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"RTHCircleCycleCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([RTHCircleCycleCell class])];
    self.collectionView.pagingEnabled = YES;
    self.flowLayout.itemSize = CGSizeMake(ScreenW, ScreenW/375 * 141);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
}

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RTHCircleCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RTHCircleCycleCell class]) forIndexPath:indexPath];
    cell.imageView.backgroundColor = self.colors[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd",indexPath.item);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/ScreenW);
    if (index == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.colors.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else if (index == self.colors.count - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (NSArray *)colors {
    if (_colors == nil) {
        _colors = @[[UIColor grayColor],[UIColor redColor],[UIColor whiteColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor greenColor],[UIColor grayColor],[UIColor redColor]];
    }
    return _colors;
}
@end
