//
//  SYImagePickerViewController.m
//  SYImagePicker
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYImagePickerViewController.h"
#import "SYImagePickerConstant.h"
#import "SYBottomView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SYImagePickerCell.h"
#import "SYPhotoBrowserViewController.h"

@interface SYImagePickerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UINavigationBar *sy_navigationBar;
@property (nonatomic, strong) UINavigationItem *sy_navigationItem;
@property (nonatomic, strong) UIBarButtonItem *cancleItem;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SYBottomView *bottomView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic, strong) NSArray *photoAssets;
@end

@implementation SYImagePickerViewController

- (instancetype)init {
    if (self = [super init]) {
        _sy_tintColor = [UIColor blackColor];
        _sy_columns = 4;
        _sy_rowSpacing = 2;
        _sy_lineSpacing = 2;
    }
    return self;
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sy_navigationBar];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getPhotoAssets];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self.collectionView registerClass:[SYImagePickerCell class] forCellWithReuseIdentifier:NSStringFromClass([SYImagePickerCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma maSY - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SYImagePickerCell class]) forIndexPath:indexPath];
    ALAsset *asset = self.photoAssets[indexPath.item];
    cell.image = [UIImage imageWithCGImage:asset.thumbnail];
    cell.isSelected = [self.selectedIndexPaths containsObject:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedIndexPaths containsObject:indexPath]) {
        [self.selectedIndexPaths removeObject:indexPath];
    }else {
        [self.selectedIndexPaths addObject:indexPath];
    }
    [collectionView reloadData];
    self.bottomView.selectedNumber = self.selectedIndexPaths.count;
}

// 设置内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, _sy_rowSpacing, 0, _sy_rowSpacing);
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

/**
 *  获取照片资源
 */
- (void)getPhotoAssets {
    ALAssetsLibrary *assetLibrary = [self defaultAssetsLibrary];
    __block NSMutableArray *groupPhotos = [[NSMutableArray alloc]init];
    __weak typeof(self) weakSelf = self;
    [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group){
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(nil == result){
                    return ;
                }
                [groupPhotos addObject:result];
            }];
            self.photoAssets = [[groupPhotos reverseObjectEnumerator] allObjects];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error --- %@",error);
    }];
}

- (NSDictionary *)getAssetsAndImages {
    NSMutableArray *selectedAssets = [NSMutableArray array];
    NSMutableArray *selectedImages = [NSMutableArray array];
    for (NSIndexPath *index in self.selectedIndexPaths) {
        ALAsset *asset = self.photoAssets[index.item];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [selectedAssets addObject:asset];
        [selectedImages addObject:image];
    }
    return @{SYSelectedImages:selectedImages,SYSelectedAssets:selectedAssets};
}

#pragma mark - 懒加载

- (SYBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[SYBottomView alloc] initWithFrame:CGRectMake(0, ScreenH - 49, ScreenW, 49)];
        __weak typeof(self) weakSelf = self;
        
        [_bottomView setFinishedChooseImages:^{
            if ([weakSelf.delegate respondsToSelector:@selector(sy_didFinishedPickingMediaWithInfo:)]) {
                [weakSelf.delegate sy_didFinishedPickingMediaWithInfo:[weakSelf getAssetsAndImages]];
            }
            [weakSelf dismissViewController];
        }];
        
        [_bottomView setPreviewSelectedImages:^{
            NSDictionary *info = [weakSelf getAssetsAndImages];
            NSArray *selectedAssets = info[SYSelectedAssets];
            if (selectedAssets.count > 0) {
                SYPhotoBrowserViewController *browserVc = [[SYPhotoBrowserViewController alloc] init];
                browserVc.assets = selectedAssets;
                [weakSelf presentViewController:browserVc animated:YES completion:nil];
            }
            
        }];
    }
    return _bottomView;
}

- (NSMutableArray *)selectedIndexPaths {
    if (_selectedIndexPaths == nil) {
        _selectedIndexPaths = [NSMutableArray array];
    }
    return _selectedIndexPaths;
}

- (NSArray *)photoAssets {
    if (_photoAssets == nil) {
        _photoAssets = [NSArray array];
    }
    return _photoAssets;
}


- (UICollectionViewFlowLayout *)flowlayout {
    if (_flowlayout == nil) {
        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (ScreenW - (_sy_columns + 1) * _sy_rowSpacing)/_sy_columns;
        _flowlayout.itemSize = CGSizeMake(width, width);
        _flowlayout.minimumLineSpacing = _sy_lineSpacing;
        _flowlayout.minimumInteritemSpacing = _sy_rowSpacing;
    }
    return _flowlayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGRect rect = CGRectMake(0, 64, ScreenW, ScreenH - 49 -64);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UINavigationItem *)sy_navigationItem {
    if (_sy_navigationItem == nil) {
        _sy_navigationItem = [[UINavigationItem alloc] initWithTitle:@"相册"];
        _sy_navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
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


- (void)dealloc {
    NSLog(@"控制器消失");
}

NSString *const SYSelectedImages = @"SYSelectedImages";
NSString *const SYSelectedAssets = @"SYSelectedAssets";
@end
