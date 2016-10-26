//
//  RTHPictureDisplayView.m
//  SYImagePicker
//
//  Created by 唐绍禹 on 16/10/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHPictureDisplayView.h"
#import <SYCategory/SYCategory.h>

#define CameraTag 1000
#define AddPictureTag 1001

@interface RTHPictureDisplayView ()
@property (nonatomic, assign) RTHPictuerDisplayType type;
@property (nonatomic, strong) NSArray *images;
@end

@implementation RTHPictureDisplayView

- (instancetype)initWithFrame:(CGRect)frame andType:(RTHPictuerDisplayType)type{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.maxCount = LONG_MAX;
        if (type != RTHPictuerDisplayTypeNormal) {
            [self initialActionBtn];
        }
    }
    return self;
}

- (CGFloat)dispalyImages:(NSArray *)images {
    _images = images;
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    
    if (self.type != RTHPictuerDisplayTypeNormal) {
        if (images.count > 0) {
            CGFloat margin = 15;
            CGFloat ItemW = (self.sy_width - margin*5)/4;
            
            NSInteger totalCount = self.maxCount > images.count?images.count + 1:self.maxCount;
            
            for (int i = 0; i< totalCount; i++ ) {
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
            self.sy_height = (totalCount/4 + 1)*(ItemW + margin) + margin;
        }else {
            [self initialActionBtn];
        }
    }else {
        if (images.count > 0) {
            CGFloat margin = 15;
            CGFloat ItemW = (self.sy_width - margin*5)/4;
            NSInteger totalCount = self.maxCount > images.count?images.count:self.maxCount;
            for (int i = 0; i< totalCount; i++ ) {
                NSInteger row = i/4;
                NSInteger col = i%4;
                
                RTHPictureItem *item = [[RTHPictureItem alloc] initWithFrame:CGRectMake(col * (margin + ItemW) + margin, row * (margin + ItemW) + margin, ItemW, ItemW) andImage:images[i] isAddBtn:YES];
                [self addSubview:item];
            }
            self.sy_height = (totalCount/4 + 1)*(ItemW + margin) + margin;
        }else {
            self.sy_height = 0;
        }
    }
    return self.sy_height;
}

- (void)initialActionBtn {
    CGFloat margin = 15;
    CGFloat ItemW = (self.sy_width - margin*5)/4;
    
    self.sy_height =  margin * 2 + ItemW;
    
    if (self.type == RTHPictuerDisplayTypePublish) {
        RTHPictureItem *cameraItem = [[RTHPictureItem alloc]initWithFrame:CGRectMake(margin, margin, ItemW, ItemW) andImage:[UIImage imageNamed:@"picture_takephoto"] isAddBtn:YES];
        cameraItem.clickAction = self.takePhotoAction;
        cameraItem.tag = CameraTag;
        [self addSubview:cameraItem];
        
        RTHPictureItem *photoItem = [[RTHPictureItem alloc]initWithFrame:CGRectMake(margin*2 + ItemW, margin, ItemW, ItemW) andImage:[UIImage imageNamed:@"picture_photo"] isAddBtn:YES];
        photoItem.clickAction = self.addPcitureAction;
        photoItem.tag = AddPictureTag;
        [self addSubview:photoItem];

    }else {
        RTHPictureItem *photoItem = [[RTHPictureItem alloc]initWithFrame:CGRectMake(margin, margin, ItemW, ItemW) andImage:[UIImage imageNamed:@"picture_add"] isAddBtn:YES];
        photoItem.clickAction = self.addPcitureAction;
        photoItem.tag = AddPictureTag;
        [self addSubview:photoItem];
    }
}

- (void)setTakePhotoAction:(void (^)())takePhotoAction {
    _takePhotoAction = takePhotoAction;
    RTHPictureItem *item = [self viewWithTag:CameraTag];
    if (item) {
        item.clickAction = takePhotoAction;
    }
}

- (void)setAddPcitureAction:(void (^)())addPcitureAction {
    _addPcitureAction = addPcitureAction;
    RTHPictureItem *item = [self viewWithTag:AddPictureTag];
    if (item) {
        item.clickAction = addPcitureAction;
    }
}

- (void)deleteItemAtIndex:(NSInteger)index {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.images];
    [tempArray removeObjectAtIndex:index];
    [self dispalyImages:tempArray];
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
