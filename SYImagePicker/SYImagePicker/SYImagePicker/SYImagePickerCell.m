//
//  SYImagePickerRootViewController.m
//
//  Created by 唐绍禹 on 16/2/26.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYImagePickerCell.h"

@interface SYImagePickerCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *markView;
@end

@implementation SYImagePickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.markView];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    NSString *imageName = isSelected ? @"sy_photo-selected":@"sy_photo-normal";
    _markView.image = [UIImage imageNamed:imageName];
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

- (UIImageView *)markView {
    if (_markView == nil) {
        CGFloat margin = 3;
        CGFloat width = self.bounds.size.width/5;
        CGRect rect = CGRectMake(self.bounds.size.width - margin - width, margin, width, width);
        _markView = [[UIImageView alloc] initWithFrame:rect];
    }
    return _markView;
}

@end
