//
//  SYImageRenderViewController.m
//  SYImageManager
//
//  Created by leju_esf on 16/11/7.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import "SYImageRenderViewController.h"
#import "UIImage+SYExtension.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface SYImageRenderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UINavigationBar *sy_navigationBar;
@property (nonatomic, strong) UINavigationItem *sy_navigationItem;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *renderTitles;
@property (nonatomic, strong) NSArray *images;
@end

@implementation SYImageRenderViewController

- (instancetype)init {
    if (self = [super init]) {
        _sy_tintColor = [UIColor blackColor];
    }
    return self;
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sy_navigationBar];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self.collectionView registerClass:[SYImageRenderCell class] forCellWithReuseIdentifier:NSStringFromClass([SYImageRenderCell class])];
}

- (void)confromAction {

}

- (void)backAction {
    if ([self.navigationController.viewControllers containsObject:self] && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -UICollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.renderTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYImageRenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SYImageRenderCell class]) forIndexPath:indexPath];
    if (indexPath.item == 0) {
        cell.imageView.image = self.image;
    }else {
        cell.imageView.image = self.image?self.images[indexPath.item - 1]:nil;
    }
    cell.titleLabel.text = self.renderTitles[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        self.imageView.image = self.image;
    }else {
        self.imageView.image = [self.image sy_renderByType:indexPath.item];
    }
}

#pragma mark - 懒加载

- (NSArray *)renderTitles {
    if (_renderTitles == nil) {
        _renderTitles = @[@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐化",@"淡雅",@"酒红",@"清宁",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色"];
    }
    return _renderTitles;
}

- (NSArray *)images {
    if (_images == nil) {
//        NSData *imageData = UIImageJPEGRepresentation(self.image, 0.1);
        UIImage *smallImage = [self.image sy_scaleToSize:CGSizeMake(200, 200*self.image.size.height/self.image.size.width)];
        if (self.image) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (int i = 1; i < 14; i++) {
                UIImage *image = [smallImage sy_renderByType:i];
                [tempArray addObject:image];
            }
            _images  = tempArray;
        }
    }
    return _images;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, ScreenW-20, ScreenH - 64 - 130)];
        _imageView.image = self.image;
    }
    return _imageView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(60, 100);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ScreenH - 110, ScreenW, 100) collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UINavigationItem *)sy_navigationItem {
    if (_sy_navigationItem == nil) {
        _sy_navigationItem = [[UINavigationItem alloc] initWithTitle:@"渲染图片"];
        _sy_navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confromAction)];
        _sy_navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
    return _sy_navigationItem;
}

- (UINavigationBar *)sy_navigationBar {
    if (_sy_navigationBar == nil) {
        _sy_navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
        [_sy_navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:self.sy_tintColor}];
        _sy_navigationBar.barTintColor = self.sy_barTintColor;
        _sy_navigationBar.tintColor = self.sy_tintColor;
        [_sy_navigationBar setItems:@[self.sy_navigationItem]];
    }
    return _sy_navigationBar;
}

@end

@implementation SYImageRenderCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20)];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
