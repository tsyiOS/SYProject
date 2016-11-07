//
//  SYImageEditViewController.m
//  SYImageManager
//
//  Created by leju_esf on 16/11/4.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import "SYImageEditViewController.h"
#import "UIImage+SYExtension.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScrollViewHeight self.scrollView.bounds.size.height
#define ScrollViewWidth self.scrollView.bounds.size.width
#define NavBarHeight 64

@interface SYImageEditViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UINavigationBar *sy_navigationBar;
@property (nonatomic, strong) UINavigationItem *sy_navigationItem;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SYImageMaskView *imageMaskView;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat imageScale;
@property (nonatomic, assign) UIEdgeInsets imageInset;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat topMargin;
@end

@implementation SYImageEditViewController

- (instancetype)init {
    if (self = [super init]) {
        _sy_tintColor = [UIColor blackColor];
        _clipSize = CGSizeMake(300, 400);
    }
    return self;
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sy_navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.imageMaskView];
}

- (void)setClipSize:(CGSize)clipSize {
    _clipSize = clipSize;
    self.imageMaskView.clipSize = clipSize;
    [self refreshUI];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    if (image) {
        [self refreshUI];
    }
}

- (void)refreshUI {
    
    CGSize imageSize = [self getImageDisplaySizeWith:_image];
    _imageSize = imageSize;
    
    CGFloat y;
    if (_clipSize.height < ScrollViewHeight) {
        y = (ScrollViewHeight - _clipSize.height) *0.5;
    }else {
        y = (_clipSize.height - ScrollViewHeight) *0.5;
    }
    
    self.imageView.frame = CGRectMake(0, 0, _imageSize.width, _imageSize.height);
    self.scrollView.contentInset = UIEdgeInsetsMake(y, _leftMargin, y, _leftMargin);
    self.scrollView.contentSize = _imageSize;
    CGFloat scale = _clipSize.height == _imageSize.height ? -1:(-0.5);
    self.scrollView.contentOffset = CGPointMake((_imageSize.width - ScreenW) *0.5, scale*y);
}

- (CGSize)getImageDisplaySizeWith:(UIImage *)image {
    
    CGFloat scale = image.size.height / image.size.width;
    CGFloat height = scale *self.scrollView.bounds.size.width;
    if (height < _clipSize.height) {
        height = _clipSize.height;
    }
    
    self.leftMargin = (ScrollViewWidth - _clipSize.width)/2;
    self.topMargin = (ScrollViewHeight - _clipSize.height)/2;
    CGFloat left = (ScreenW - _clipSize.width) / 2;
    CGFloat top = (ScreenH - NavBarHeight - _clipSize.height) / 2;
    CGFloat right = ScreenW - _clipSize.width - left;
    CGFloat bottom = ScreenH - NavBarHeight - _clipSize.height - top;
    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
    
    self.imageScale = height/image.size.height;
    return CGSizeMake(height/scale, height);
}

- (UIImage *)clipImage {
    
    CGFloat zoomScale = self.scrollView.zoomScale;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat aX = offsetX+_imageInset.left;
    CGFloat aY = offsetY+_imageInset.top;
    CGFloat scale = zoomScale*self.imageScale;
    aX = aX / scale;
    aY = aY / scale;
    CGFloat aWidth = _clipSize.width / scale;
    CGFloat aHeight = _clipSize.height / scale;
    UIImage *clipImage = [_image sy_clipByRect:CGRectMake(aX, aY, aWidth, aHeight)];
    
    UIImage *editImage = [clipImage sy_scaleToSize:_clipSize];
    
    return editImage;
}

/**
 *  剪切按钮点击
 */
- (void)clipButtonClick {
    UIImage *image = [self clipImage];
    if ([self.delegate respondsToSelector:@selector(sy_didFinishedEditingPhoto:)]) {
        [self.delegate sy_didFinishedEditingPhoto:image];
    }
    UIView *flashView = [[UIView alloc] initWithFrame:self.view.bounds];
    flashView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:flashView];
    [UIView animateWithDuration:0.25 animations:^{
        flashView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [flashView removeFromSuperview];
        [self backAction];
    }];
}

/**
 *  返回按钮点击
 */
- (void)backAction {
    if ([self.navigationController.viewControllers containsObject:self] && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark: - UIScrollView代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    CGFloat offsetX = (ScrollViewWidth - _clipSize.width) * 0.5;
    offsetX = offsetX < 0 ? _leftMargin : offsetX;
    CGFloat offsetY = (ScrollViewHeight - _clipSize.height) * 0.5;
    offsetY = offsetY < 0 ? _leftMargin : offsetY;;
    self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX);
}

#pragma mark - 懒加载

- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenW, ScreenH - NavBarHeight )];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.autoresizingMask = YES;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 3.0;
        [_scrollView addSubview:self.imageView];
    }
    return _scrollView;
    
}

- (SYImageMaskView *)imageMaskView {
    
    if (_imageMaskView == nil) {
        _imageMaskView = [[SYImageMaskView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenW, ScreenH - NavBarHeight)];
        _imageMaskView.backgroundColor = [UIColor clearColor];
        _imageMaskView.userInteractionEnabled = NO;
        _imageMaskView.clipSize = _clipSize;
    }
    return _imageMaskView;
    
}

- (UINavigationItem *)sy_navigationItem {
    if (_sy_navigationItem == nil) {
        _sy_navigationItem = [[UINavigationItem alloc] initWithTitle:@"编辑图片"];
        _sy_navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(clipButtonClick)];
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

#pragma mark - SYImageMaskView

@interface SYImageMaskView ()
/**
 *  裁剪框的位置和大小
 */
@property (nonatomic, assign) CGRect clipRect;
@end

@implementation SYImageMaskView

- (void)setClipSize:(CGSize)clipSize {
    _clipSize = clipSize;
    
    CGFloat x = (self.bounds.size.width - clipSize.width)/2;
    CGFloat y = (self.bounds.size.height - clipSize.height)/2;
    _clipRect = CGRectMake(x, y, clipSize.width, clipSize.height);
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.7);
    CGContextFillRect(ctx, self.bounds);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokeRectWithWidth(ctx, _clipRect, 2.0);
    CGContextClearRect(ctx, _clipRect);
}

@end
