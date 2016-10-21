//
//  SYBottomView.m
//
//  Created by 唐绍禹 on 16/2/26.
//  Copyright © 2016年 tsy. All rights reserved.

#import "SYBottomView.h"

@interface SYBottomView ()
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIView *line;
@end

@implementation SYBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.previewButton];
    [self addSubview:self.doneButton];
    [self addSubview:self.line];
}

- (void)setSelectedNumber:(NSInteger)selectedNumber {
    _selectedNumber = selectedNumber;
    [_doneButton setTitle:[NSString stringWithFormat:@"完 成(%ld)",selectedNumber] forState:UIControlStateNormal];
}

- (void)previewButtonClick {
    if (self.previewSelectedImages) {
        self.previewSelectedImages();
    }
}

- (void)doneButtonClick {
    if (self.allowsEditing) {
        if (self.finishedChooseImagesAndAllowsEditing) {
            self.finishedChooseImagesAndAllowsEditing();
        }
    }else {
        if (self.finishedChooseImages) {
            self.finishedChooseImages();
        }
    }
   
}

#pragma mark - 懒加载
- (UIButton *)previewButton
{
    if (_previewButton == nil) {
        _previewButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 11, 80, 28)];
        [_previewButton setTitle:@"预 览" forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _previewButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _previewButton.layer.cornerRadius = 5;
        _previewButton.clipsToBounds = YES;
        _previewButton.layer.borderWidth = 1;
        _previewButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_previewButton addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewButton;
}

- (UIButton *)doneButton
{
    if (_doneButton == nil) {
        _doneButton = [[UIButton alloc] initWithFrame: CGRectMake(self.bounds.size.width - 90, 11, 80, 28)];
        [_doneButton setTitle:@"完 成(0)" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _doneButton.layer.cornerRadius = 5;
        _doneButton.clipsToBounds = YES;
        _doneButton.layer.borderWidth = 1;
        _doneButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (UIView *)line
{
    if (_line == nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}



@end
