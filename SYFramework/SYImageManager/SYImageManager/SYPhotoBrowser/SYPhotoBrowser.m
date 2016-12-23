//
//  SYPhotoBrowser.m
//  SYImagePickerDevelop
//
//  Created by leju_esf on 16/12/22.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYPhotoBrowser.h"
#import "SYBrowserViewCell.h"
#import "SDWebImageManager.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface SYPhotoBrowser ()<UICollectionViewDataSource,UICollectionViewDelegate,SYBrowserViewCellDelegate>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *pageLabel;
@end

@implementation SYPhotoBrowser

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.currentIndex > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadImages];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI {
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageLabel];
    
    self.pageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[label(20)]|" options:NSLayoutFormatAlignmentMask metrics:nil views:@{@"label":self.pageLabel}]];
    
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.currentIndex+1,self.images.count];
}

- (void)loadImages {
    for (int i = 0; i < self.images.count; i++) {
        SYPhoto *photo = self.images[i];
        if (photo.url) {
            [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:photo.url] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                if (image) {
                    photo.image = image;
                    [self.collectionView reloadData];
                }
            }];
        }
    }
}

- (void)show {
    if (self.sourceImageView) {
        CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:self.sourceImageView.frame fromView:self.sourceImageView.superview];
        UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:rect];
        animationImageView.image = self.sourceImageView.image;
        UIView *shadow = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        shadow.backgroundColor = [UIColor blackColor];
        shadow.alpha = 0;
        CGRect endRect = CGRectMake(0, (ScreenH - ScreenW * 0.75)*0.5, ScreenW, ScreenW * 0.75);
        [[UIApplication sharedApplication].keyWindow addSubview:shadow];
        [[UIApplication sharedApplication].keyWindow addSubview:animationImageView];
        [UIView animateWithDuration:0.25 animations:^{
            animationImageView.frame = endRect;
            shadow.alpha = 1;
        }completion:^(BOOL finished) {
            self.view.frame =[UIScreen mainScreen].bounds;
            [[UIApplication sharedApplication].keyWindow addSubview:self.view];
            [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:self];
            [animationImageView removeFromSuperview];
            [shadow removeFromSuperview];
        }];
    }else {
        UIViewController *topRootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (topRootVc.presentedViewController) {
            topRootVc = topRootVc.presentedViewController;
        }
        [topRootVc presentViewController:self animated:YES completion:nil];
    }
}

- (void)dismiss {
    if (self.sourceImageView) {
        [self.view removeFromSuperview];
        NSArray *currentCells = [self.collectionView visibleCells];
        if (currentCells.count > 0) {
            SYBrowserViewCell *cell = currentCells.firstObject;
            CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:cell.imageView.frame fromView:cell.contentView];
            UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:rect];
            animationImageView.image = cell.imageView.image;
            [[UIApplication sharedApplication].keyWindow addSubview:animationImageView];
            [UIView animateWithDuration:0.25 animations:^{
                animationImageView.frame = self.sourceImageView.frame;
            }completion:^(BOOL finished) {
                [animationImageView removeFromSuperview];
                [self removeFromParentViewController];
            }];
        }else {
            [self removeFromParentViewController];
        }
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)closeBrowser {
    [self dismiss];
}

#pragma mark : - collectionView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    int currentNum = (int)scale + 1;
    CGFloat decimal = scale - currentNum;
    if (decimal > 0.5) {
        currentNum +=1;
    }
    self.currentIndex = currentNum-1;
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",currentNum,self.images.count];
}


#pragma mark : - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYBrowserViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SYBrowserViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    SYPhoto *photo = self.images[indexPath.item];
    cell.image = photo.image?:photo.placeHolder;
    cell.delegate = self;
    return cell;
}

#pragma mark : - 懒加载
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width +20, [UIScreen mainScreen].bounds.size.height);
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width +20, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[SYBrowserViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SYBrowserViewCell class])];
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UILabel *)pageLabel {
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc] init];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.font = [UIFont systemFontOfSize:20.0];
    }
    return _pageLabel;
}

- (void)dealloc {
    NSLog(@"图片浏览器消失");
}

@end
