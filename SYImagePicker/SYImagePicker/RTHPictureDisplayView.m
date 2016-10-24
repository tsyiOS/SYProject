//
//  RTHPictureDisplayView.m
//  SYImagePicker
//
//  Created by 唐绍禹 on 16/10/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHPictureDisplayView.h"
#import <SYCategory/SYCategory.h>

@implementation RTHPictureDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    if (images.count > 0) {
        
        CGFloat margin = 15;
        CGFloat ItemW = (self.sy_width - margin*5)/4;
        
        for (int i = 0; i< (self.maxCount > images.count?images.count + 1:self.maxCount); i++ ) {
            NSInteger row = i/4;
            NSInteger col = i%4;
            
            RTHPictureItem *item = [[RTHPictureItem alloc] initWithFrame:CGRectMake(col * (margin + ItemW) + margin, row * (margin + ItemW) + margin, ItemW, ItemW) andImage:i == images.count?[UIImage imageNamed:@"picture_add"]:images[i] isAddBtn:i == images.count];
            __weak typeof(self) weakSelf = self;
            [item setDeleateItem:^{
                [weakSelf deleteItemAtIndex:i];
            }];
            
            if (i == images.count) {
                item.clickAction = self.addPcitureAction;
            }
            [self addSubview:item];
        }
        self.sy_height = (images.count/4 + 1)*(ItemW + margin) + margin;
    }
}

- (void)deleteItemAtIndex:(NSInteger)index {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.images];
    [tempArray removeObjectAtIndex:index];
    self.images = tempArray;
}

@end

@interface RTHPictureItem ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation RTHPictureItem

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image isAddBtn:(BOOL)add{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.cancelBtn];
        self.imageView.image = image;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.cancelBtn.hidden = add;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapAction {
    if (self.cancelBtn.hidden == YES && self.clickAction) {
        self.clickAction();
    }
}

- (void)cancelAction {
    if (self.deleateItem) {
        self.deleateItem();
    }
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.sy_width - 17, 0, 17, 17)];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"picture_deleate"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end