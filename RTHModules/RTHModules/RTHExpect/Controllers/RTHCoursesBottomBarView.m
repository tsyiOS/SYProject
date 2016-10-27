//
//  RTHCoursesBottomBarView.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/28.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCoursesBottomBarView.h"

@interface RTHCoursesBottomBarView ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@end

@implementation RTHCoursesBottomBarView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andImageNames:(NSArray *)images; {
    if (self = [super initWithFrame:frame]) {
        self.images = images;
        self.titles = titles;
        if (self.images.count == self.titles.count && self.images.count != 0) {
            [self setUpUI];
        }
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUpUI {
    for (int i = 0; i < _titles.count; i++) {
        NSString *image = self.images[i];
        NSString *title = self.titles[i];
        CGFloat w = (self.sy_width -20)/self.images.count;
        RTHCoursesButton *btn = [[RTHCoursesButton alloc] initWithFrame:CGRectMake(i*w + 10, 0, w, self.sy_height) andTitle:title andImageName:image];
        btn.tag = i + 1000;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i != 1) {
            [btn addTarget:self action:@selector(btnTouchDownAction:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(btnTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        }else {
            self.collectionBtn = btn;
        }
        [self addSubview:btn];
    }
}

- (void)btnAction:(RTHCoursesButton *)sender {
    if (sender.tag == 1001) {
        sender.btnSelected = !sender.btnSelected;
    }else {
        sender.btnSelected = NO;
    }
    if (self.bottomBtnClick) {
        self.bottomBtnClick(sender.tag - 1000);
    }
}

- (void)btnTouchDownAction:(RTHCoursesButton *)sender {
     sender.btnSelected = YES;
}

- (void)btnTouchUpOutside:(RTHCoursesButton *)sender {
    sender.btnSelected = NO;
}
@end

@interface RTHCoursesButton ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *imageName;
@end

@implementation RTHCoursesButton

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andImageName:(NSString *)image {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        self.iconImageView.image =[UIImage imageNamed:image];
        self.titleLabel.text = title;
        self.imageName = image;
    }
    return self;
}

- (void)setBtnSelected:(BOOL)btnSelected {
    _btnSelected = btnSelected;
    self.iconImageView.image = [UIImage imageNamed:btnSelected?[self.imageName stringByAppendingString:@"_selected"]:self.imageName];
    self.titleLabel.textColor = btnSelected?[UIColor appMainColor]:[UIColor textLightGrayColor];
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        CGFloat w = 23.0;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.sy_width - w)*0.5, 5, w, w)];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sy_height - 20, self.sy_width, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor textLightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
