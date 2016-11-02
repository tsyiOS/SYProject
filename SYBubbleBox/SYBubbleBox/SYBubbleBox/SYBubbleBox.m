//
//  SYBubbleBox.m
//  SYBubbleBox
//
//  Created by leju_esf on 16/11/2.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYBubbleBox.h"

//static CGFloat const radius = 150;//圆心距
//static CGFloat const titleBtnR = 50;//小按钮的直径

CGFloat SYDistanceBetweenPoints(CGPoint p1, CGPoint p2){
    return sqrtf(powf(p1.x - p2.x, 2) + powf(p1.y - p2.y, 2));
}

@interface SYBubbleBox ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation SYBubbleBox

- (instancetype)initWithTitles:(NSArray *)titles andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _startAngle = 90;
        _endAngle = 180;
        _radius = 150;
        _centerRotateAngle = 45;
        _itemDiam = [self centerButtonDiam] - 10;
        _itemColor = [UIColor darkGrayColor];
        _itemFont = [UIFont systemFontOfSize:12];
        _itemTextColor = [UIColor whiteColor];
        _centerTitle = @"+";
        _centerColor = [UIColor redColor];
        _centerFont = [UIFont boldSystemFontOfSize:45];
        _centerTextColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    for (int i = 0; i<_titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i+1000;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_itemTextColor forState:UIControlStateNormal];
        btn.backgroundColor = _itemColor;
        btn.bounds = CGRectMake(0, 0, _itemDiam, _itemDiam);
        btn.layer.cornerRadius = _itemDiam*0.5;
        btn.clipsToBounds = YES;
        btn.titleLabel.font = _itemFont;
        btn.center = self.centerButton.center;
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    [self addSubview:self.centerButton];
}

#pragma mark - 设置小按钮的属性
- (void)setItemDiam:(CGFloat)itemDiam {
    if (itemDiam > 0 && itemDiam <= [self centerButtonDiam]) {
        _itemDiam = itemDiam;
        [self setItemProprety:^(UIButton *sub){
            sub.bounds = CGRectMake(0, 0, itemDiam,itemDiam);
            sub.layer.cornerRadius = itemDiam*0.5;
        }];
    }
}

- (void)setItemColor:(UIColor *)itemColor {
    _itemColor = itemColor;
    [self setItemProprety:^(UIButton *sub) {
        [sub setBackgroundColor:itemColor];
    }];
}

- (void)setItemFont:(UIFont *)itemFont {
    _itemFont = itemFont;
    [self setItemProprety:^(UIButton *sub) {
        sub.titleLabel.font = itemFont;
    }];
}

- (void)setItemTextColor:(UIColor *)itemTextColor {
    _itemTextColor = itemTextColor;
    [self setItemProprety:^(UIButton *sub) {
        [sub setTitleColor:itemTextColor forState:UIControlStateNormal];
    }];
}

- (void)setItemProprety:(void(^)(UIButton *sub))block {
    if (block) {
        for (UIButton *sub in self.subviews) {
            if (sub.tag >= 1000){
                block(sub);
            }
        }
    }
}

#pragma mark - 设置中心按钮属性
- (void)setCenterImage:(UIImage *)centerImage {
    _centerImage = centerImage;
    [self.centerButton setBackgroundImage:centerImage forState:UIControlStateNormal];
}

- (void)setCenterTitle:(NSString *)centerTitle {
    _centerTitle = centerTitle;
    [self.centerButton setTitle:self.centerTitle forState:UIControlStateNormal];
}

- (void)setCenterColor:(UIColor *)centerColor {
    _centerColor = centerColor;
    [self.centerButton setBackgroundColor:centerColor];
}

- (void)setCenterFont:(UIFont *)centerFont {
    _centerFont = centerFont;
    self.centerButton.titleLabel.font = centerFont;
}

- (void)setCenterTextColor:(UIColor *)centerTextColor {
    _centerTextColor = centerTextColor;
    [self.centerButton setTitleColor:centerTextColor forState:UIControlStateNormal];
}

#pragma mark - 设置自身属性
- (void)setAllowRotation:(BOOL)allowRotation {
    _allowRotation = allowRotation;
    if (allowRotation) {
        for (UIView *sub in self.subviews) {
            if (sub.tag >= 1000) {
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerMove:)];
                [sub addGestureRecognizer:pan];
            }
        }
    }
}

- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = [self transformAngle:startAngle];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = [self transformAngle:endAngle];
}

- (CGFloat)transformAngle:(CGFloat)angle {
    while (angle > 360) {
        angle -= 360;
    }
    
    while (angle < 0) {
        angle += 360;
    }
    
    return angle;
}

#pragma mark - 移动手势
- (void)panGestureRecognizerMove:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self];
    
    CGFloat distance = SYDistanceBetweenPoints(point, self.centerButton.center);
    CGFloat offsetX = (point.x - self.centerButton.center.x)*_radius/distance;
    CGFloat offsetY = (point.y - self.centerButton.center.y)*_radius/distance;
    
    CGFloat marginAngle = (self.endAngle - self.startAngle)/_titles.count;
    
    CGFloat newStartAnagle= 0;
    if (offsetY >= 0) {
        newStartAnagle = (-1)*acos(offsetX/_radius)*180.0/M_PI;
    }else {
        newStartAnagle = acos(offsetX/_radius)*180.0/M_PI;
    }
    
    for (UIView *sub in self.subviews) {
        CGFloat startAngle = (newStartAnagle + marginAngle*(sub.tag - pan.view.tag))/180.0 * M_PI ;
        if (sub.tag >= 1000 ) {
            CGFloat marginX = _radius* cos(startAngle);
            CGFloat marginY = _radius* sin(startAngle) * (-1);
            sub.center = CGPointMake(self.centerButton.center.x + marginX, self.centerButton.center.y + marginY);
        }
    }
}

#pragma mark - 点击事件
- (void)centerButtonClick:(UIButton *)sender {
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
    [self centerButtonClick:self.centerButton];
}

- (void)backgroundViewCilck {
    [self dismiss];
}

#pragma mark - 展开与收起
- (void)show {
    if (self.centerButton.selected || self.titles.count == 0) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.centerButton.transform = CGAffineTransformMakeRotation(_centerRotateAngle/180*M_PI);
    }];
    
    CGFloat marginAngle = (self.endAngle - self.startAngle)/(_titles.count - 1);
    for (UIView *sub in self.subviews) {
        CGFloat startAngle = (self.startAngle + marginAngle*(sub.tag - 1000))/180.0 * M_PI ;
        if (sub.tag >= 1000) {
            CGFloat marginX = (_radius*self.titles.count/self.titles.count) * cos(startAngle);
            CGFloat marginY = (_radius*self.titles.count/self.titles.count) * sin(startAngle) * (-1);
            [UIView animateWithDuration:0.25+0.1*(sub.tag - 1000) animations:^{
                sub.center = CGPointMake(self.centerButton.center.x + marginX, self.centerButton.center.y + marginY);
                
            }];
        }
    }
    
    [self.superview addSubview:self.backgroundView];
    [self.superview bringSubviewToFront:self];
    self.centerButton.selected = YES;
}

- (void)dismiss {
    
    if (!self.centerButton.selected || self.titles.count == 0) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.centerButton.transform = CGAffineTransformIdentity;
    }];
    
    for (UIView *sub in self.subviews) {
        if (sub.tag >= 1000) {
            [UIView animateWithDuration:0.25 animations:^{
                sub.center = self.centerButton.center;
            }];
        }
    }
    
    [self.backgroundView removeFromSuperview];
    self.centerButton.selected = NO;
}

#pragma mark - 其他

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

- (CGFloat)centerButtonDiam {
    return MAX(self.frame.size.width, self.frame.size.height);
}

#pragma mark - 懒加载
- (UIButton *)centerButton {
    if (_centerButton == nil) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat itemW = [self centerButtonDiam];
        _centerButton.frame = CGRectMake(0,0,itemW,itemW);
        _centerButton.backgroundColor = _centerColor;
        _centerButton.titleLabel.font = _centerFont;
        _centerButton.layer.cornerRadius = _centerButton.frame.size.width*0.5;
        _centerButton.clipsToBounds = YES;
        _centerButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
        [_centerButton setTitle:_centerTitle forState:UIControlStateNormal];
        [_centerButton setTitleColor:_centerTextColor forState:UIControlStateNormal];
        [_centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
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
