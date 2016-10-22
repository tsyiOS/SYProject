//
//  SYPhotoBrowserViewController.m
//
//  Created by 唐绍禹 on 15/10/18.
//  Copyright (c) 2015年 tsy. All rights reserved.
//

#import "SYPhotoBrowserViewController.h"
#import "SYBrowserViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

NSString *const SYBrowserCell = @"SYBrowserCell";
@interface SYPhotoBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SYBrowserViewCellDelegate>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSArray *images;
@end

@implementation SYPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.label.text = [NSString stringWithFormat:@"%d/%lu",1,(unsigned long)self.images.count];
    [self setupUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupUI{
    
    self.flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width +20, [UIScreen mainScreen].bounds.size.height);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.collectionView registerClass:[SYBrowserViewCell class] forCellWithReuseIdentifier:SYBrowserCell];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.label];
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[label(20)]|" options:NSLayoutFormatAlignmentMask metrics:nil views:@{@"label":self.label}]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)canclebrowser {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma maSY : - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYBrowserViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SYBrowserCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    cell.image = self.images[indexPath.row];
    cell.delegate = self;
    return cell;
}

//实现cell的代理方法
- (void)closeBrowser {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma maSY : - collectionView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    int currentNum = (int)scale + 1;
    CGFloat decimal = scale - currentNum;
    if (decimal > 0.5) {
        currentNum +=1;
    }
    self.label.text = [NSString stringWithFormat:@"%d/%lu",currentNum,(unsigned long)self.images.count];
}

#pragma mark : - 懒加载
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width +20, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:self.flowLayout];
    }
    return _collectionView;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:20.0];
    }
    return _label;
}

- (NSArray *)images {
    if (_images == nil) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.assets.count];
            for (ALAsset *asset in self.assets) {
               UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                [tempArray addObject:image];
            }
        _images = tempArray;
    }
    return _images;
}

@end
