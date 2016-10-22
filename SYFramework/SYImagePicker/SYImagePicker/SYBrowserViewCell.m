//
//  SYBrowserViewCell.m
//
//  Created by 唐绍禹 on 15/10/18.
//  Copyright (c) 2015年 tsy. All rights reserved.
//

#import "SYBrowserViewCell.h"

#define ScrollViewSize self.scrollView.bounds.size

@interface SYBrowserViewCell () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation SYBrowserViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
        [self prepareScrollView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    CGSize size = [self getImageDisplaySizeWith:image];
    [self resetScrollView];
    if (size.height < ScrollViewSize.height) {
        //短图
        CGFloat y = (ScrollViewSize.height - size.height) * 0.5;
        self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
        self.scrollView.contentInset = UIEdgeInsetsMake(y, 0, y, 0);
    }else {
        //长图
        self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
        self.scrollView.contentSize = size;
    }
    self.imageView.image = image;
}

- (void)prepareScrollView {
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 2.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapscrollView)];
    self.scrollView.userInteractionEnabled = YES;
    [self.scrollView addGestureRecognizer:tap];
}

- (void)tapscrollView {
    if ([self.delegate respondsToSelector:@selector(closeBrowser)]) {
        [self.delegate closeBrowser];
    }
}

- (void)resetScrollView{
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = CGSizeZero;
    self.scrollView.zoomScale = 1;
}

- (CGSize)getImageDisplaySizeWith:(UIImage *)image {
    CGFloat scale = image.size.height / image.size.width;
    CGFloat height = scale *self.scrollView.bounds.size.width;
    
    return CGSizeMake(self.scrollView.bounds.size.width, height);
}

#pragma mark : - scrollView代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    CGFloat offsetX = (ScrollViewSize.width - view.frame.size.width) * 0.5;
    offsetX = offsetX < 0 ? 0 : offsetX;
    CGFloat offsetY = (ScrollViewSize.height - view.frame.size.height) * 0.5;
    offsetY = offsetY < 0 ? 0 : offsetY;;
    self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, 0, 0);
}

#pragma mark : - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
