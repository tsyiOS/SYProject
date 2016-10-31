//
//  SYSelectBox.m
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYSelectBox.h"

#define SYArrowHeight  10
#define SYArrowWidth   15
#define SYCornerRodius 8

@interface SYSelectBox ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) SYSelectBoxArrowPosition arrowPosition;
@property (nonatomic, assign) CGPoint arrowPoint;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIBezierPath *borderPath;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@end

@implementation SYSelectBox

- (instancetype)initWithSize:(CGSize)size direction:(SYSelectBoxArrowPosition)position andCustomView:(UIView *)customView {
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]) {
        self.arrowPosition = position;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    self.layer.mask = self.maskLayer;
    [self.layer addSublayer:self.borderLayer];
}

- (void)showDependentOn:(UIView *)dependentView {
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:dependentView.frame fromView:dependentView.superview];
    
    CGRect frame = CGRectZero;
    
    CGFloat y = CGRectGetMaxY(rect);
    
    if (self.arrowPosition == SYSelectBoxArrowPositionLeft) {
        frame = CGRectMake(rect.origin.x+rect.size.width * 0.5 - 20, y, self.frame.size.width, self.frame.size.height);
    }else if (self.arrowPosition == SYSelectBoxArrowPositionRight) {
        frame = CGRectMake(rect.origin.x+rect.size.width * 0.5 - self.frame.size.width + 20,y, self.frame.size.width, self.frame.size.height);
    }else {
        frame = CGRectMake(rect.origin.x+rect.size.width * 0.5 - self.frame.size.width * 0.5,y, self.frame.size.width, self.frame.size.height);
    }
    self.frame = frame;
    
    //添加阴影
    self.backgroundView.layer.shadowPath =  [UIBezierPath bezierPathWithRect:CGRectMake(self.frame.origin.x, self.frame.origin.y + 10, self.frame.size.width, self.frame.size.height - 10) ].CGPath;
    self.backgroundView.layer.shadowOffset = CGSizeMake(5, 5);
    self.backgroundView.layer.shadowRadius = 5;
    self.backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundView.layer.shadowOpacity = 0.4;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 1.0;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, _arrowPoint.x - CGRectGetWidth(self.frame)/2.0, _arrowPoint.y - CGRectGetHeight(self.frame)/2.0);
    transform = CGAffineTransformScale(transform, 0.01, 0.01);
    self.transform = transform;
    self.alpha = 0.01;
    [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)dismiss {
    self.backgroundView.layer.shadowPath =  [UIBezierPath bezierPathWithRect:CGRectZero].CGPath;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, _arrowPoint.x - CGRectGetWidth(self.frame)/2.0, _arrowPoint.y - CGRectGetHeight(self.frame)/2.0);
    transform = CGAffineTransformScale(transform, 0.01, 0.01);
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = transform;
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - 懒加载
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SYArrowHeight, self.bounds.size.width, self.bounds.size.height)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        _backgroundView.userInteractionEnabled = YES;
        [_backgroundView addGestureRecognizer:tap];
        _backgroundView.tag = 9999;
    }
    return _backgroundView;
}

- (UIBezierPath *)borderPath {
    if (_borderPath == nil) {
        _borderPath = [[UIBezierPath alloc] init];

        CGFloat arrowLeftX = 0;
        
        switch (self.arrowPosition) {
            case SYSelectBoxArrowPositionLeft:
                arrowLeftX = 10;
                break;
            case SYSelectBoxArrowPositionCenter:
                arrowLeftX = (self.frame.size.width - SYArrowWidth)/2;
                break;
            case SYSelectBoxArrowPositionRight:
                arrowLeftX = self.frame.size.width - 10 - SYArrowWidth;
                break;
        }
        
        CGFloat arrowRightX = arrowLeftX + SYArrowWidth;
        
        CGFloat left = 0.0;
        CGFloat right = CGRectGetWidth(self.frame);
        CGFloat top = SYArrowHeight;
        CGFloat bottom = CGRectGetHeight(self.frame);
        
        //start
        [_borderPath moveToPoint:CGPointMake(left, SYCornerRodius+top)];
        
        //left
        [_borderPath addLineToPoint:CGPointMake(left, bottom-SYCornerRodius)];
        [_borderPath addQuadCurveToPoint:CGPointMake(left+SYCornerRodius, bottom) controlPoint:CGPointMake(left, bottom)];
        
        //bottom
        [_borderPath addLineToPoint:CGPointMake(right-SYCornerRodius, bottom)];
        [_borderPath addQuadCurveToPoint:CGPointMake(right, bottom-SYCornerRodius) controlPoint:CGPointMake(right, bottom)];
        
        //right
        [_borderPath addLineToPoint:CGPointMake(right, SYCornerRodius+top)];
        [_borderPath addQuadCurveToPoint:CGPointMake(right-SYCornerRodius, top) controlPoint:CGPointMake(right, top)];
        
        //arrow
        self.arrowPoint = CGPointMake(arrowRightX - SYArrowWidth/2, 0);
        [_borderPath addLineToPoint:CGPointMake(arrowRightX, top)];
        [_borderPath addLineToPoint:CGPointMake(arrowRightX - SYArrowWidth/2, 0)];
        [_borderPath addLineToPoint:CGPointMake(arrowLeftX, top)];
        
        //top
        [_borderPath addLineToPoint:CGPointMake(left+SYCornerRodius, top)];
        [_borderPath addQuadCurveToPoint:CGPointMake(left, SYCornerRodius+top) controlPoint:CGPointMake(left, top)];
    }
    return _borderPath;
}

- (CAShapeLayer *)maskLayer {
    if (_maskLayer == nil) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.path = self.borderPath.CGPath;
    }
    return _maskLayer;
}

- (CAShapeLayer *)borderLayer {
    if (_borderLayer == nil) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.path = self.borderPath.CGPath;
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
        _borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _borderLayer.lineWidth = 1;
        _borderLayer.frame=self.bounds;
    }
    return _borderLayer;
}

@end
