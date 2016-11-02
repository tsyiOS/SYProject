//
//  SYBubbleBox.m
//  SYBubbleBox
//
//  Created by leju_esf on 16/11/2.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYBubbleBox.h"

static CGFloat const radius = 150;//圆心距
static CGFloat const titleBtnR = 50;//小按钮的直径

@interface SYBubbleBox ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation SYBubbleBox

- (instancetype)initWithTitles:(NSArray *)titles andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        for (int i = 0; i<titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.tag = i+1000;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor darkGrayColor];
            btn.bounds = CGRectMake(0, 0, titleBtnR, titleBtnR);
            btn.layer.cornerRadius = titleBtnR*0.5;
            btn.clipsToBounds = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.center = self.addButton.center;
            [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        [self addSubview:self.addButton];
    }
    return self;
}

- (void)addButtonClick:(UIButton *)sender {
    if (sender.selected) {
        [self dismiss];
    }else {
        [self show];
    }
}

- (void)titleBtnClick:(UIButton *)sender {
    if (self.action) {
        self.action(sender.tag - 1000);
    }
    [self addButtonClick:self.addButton];
}

- (void)backgroundViewCilck {
    [self addButtonClick:self.addButton];
}

- (void)show {
    if (self.addButton.selected) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.addButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
    
    CGFloat marginAngle = 90.0/(_titles.count - 1);
    for (UIView *sub in self.subviews) {
        CGFloat startAngle = (90 + marginAngle*(sub.tag - 1000))/180.0 * M_PI ;
        if (sub.tag >= 1000) {
            CGFloat marginX = (radius*self.titles.count/5.0) * cos(startAngle);
            CGFloat marginY = (radius*self.titles.count/5.0) * sin(startAngle) * (-1);
            [UIView animateWithDuration:0.25+0.1*(sub.tag - 1000) animations:^{
                sub.center = CGPointMake(self.addButton.center.x + marginX, self.addButton.center.y + marginY);
                
            }];
        }
    }
    
    [self.superview addSubview:self.backgroundView];
    [self.superview bringSubviewToFront:self];
    self.addButton.selected = YES;
}

- (void)dismiss {
    
    if (!self.addButton.selected) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.addButton.transform = CGAffineTransformIdentity;
    }];
    
    for (UIView *sub in self.subviews) {
        if (sub.tag >= 1000) {
            [UIView animateWithDuration:0.25 animations:^{
                sub.center = self.addButton.center;
            }];
        }
    }
    
    [self.backgroundView removeFromSuperview];
    self.addButton.selected = NO;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.bounds, point)) {
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if (CGRectContainsPoint(subView.frame, point)) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 懒加载
- (UIButton *)addButton {
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height);
        _addButton.backgroundColor = [UIColor redColor];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont boldSystemFontOfSize:45];
        _addButton.layer.cornerRadius = _addButton.frame.size.width*0.5;
        _addButton.clipsToBounds = YES;
        _addButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
         _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
         _backgroundView.userInteractionEnabled = YES;
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewCilck)];
         [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}


- (NSArray *)titles {
    if (_titles == nil) {
        _titles = [[NSArray alloc] init];
    }
    return _titles;
}

@end
