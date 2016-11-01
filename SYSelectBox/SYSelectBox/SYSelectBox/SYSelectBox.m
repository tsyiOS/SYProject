//
//  SYSelectBox.m
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYSelectBox.h"
#import "SYBezierModel.h"

#define SYArrowHeight  10
#define SYArrowWidth   15
#define SYCornerRodius 8
#define SYArrowBorderMargin 15
#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface SYSelectBox ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) SYSelectBoxArrowPosition arrowPosition;
@property (nonatomic, assign) CGPoint arrowPoint;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIBezierPath *borderPath;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic) CGAffineTransform animationTransform;
@end

@implementation SYSelectBox

- (instancetype)initWithSize:(CGSize)size direction:(SYSelectBoxArrowPosition)position andCustomView:(UIView *)customView {
    
    size = [self decentSizeWithSize:size andDirection:position];
    
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]) {
        _arrowPosition = position;
        _customView = customView;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
    
}

- (CGSize)decentSizeWithSize:(CGSize)size andDirection:(SYSelectBoxArrowPosition)position{
    
    CGFloat minWidth = 2*SYCornerRodius + 2*SYArrowBorderMargin + SYArrowWidth;
    
    if (size.width < minWidth) {
        size.width = minWidth;
    }
    
    if(size.height < minWidth){
        size.height = minWidth;
    }
    
    switch (position) {
        case SYSelectBoxArrowPositionTopLeft:
        case SYSelectBoxArrowPositionTopCenter:
        case SYSelectBoxArrowPositionTopRight:
            size.height += SYArrowHeight;
            break;
        case SYSelectBoxArrowPositionLeftTop:
        case SYSelectBoxArrowPositionLeftCenter:
        case SYSelectBoxArrowPositionLeftBottom:
            size.width += SYArrowHeight;
            break;
        case SYSelectBoxArrowPositionBottomLeft:
        case SYSelectBoxArrowPositionBottomCenter:
        case SYSelectBoxArrowPositionBottomRight:
            size.height += SYArrowHeight;
            break;
        case SYSelectBoxArrowPositionRightTop:
        case SYSelectBoxArrowPositionRightCenter:
        case SYSelectBoxArrowPositionRightBottom:
            size.width += SYArrowHeight;
            break;
    }
    
    return size;
}

- (void)showDependentOnView:(UIView *)dependentView {
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:dependentView.frame fromView:dependentView.superview];
    self.arrowPoint = [self arrowPointWithDependentViewFrame:rect];
    [self show];
}

- (void)showDependentOnPoint:(CGPoint)point {
    self.arrowPoint = point;
    [self show];
}

- (void)show {
    
    self.frame = [self frameWithArrorPoint:self.arrowPoint];
    
    self.customView.frame = self.contentView.bounds;
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.customView];
    self.layer.mask = self.maskLayer;
    [self.layer addSublayer:self.borderLayer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.transform = self.animationTransform;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
        self.backgroundView.alpha = 0.05;
    }];
}

- (void)dismiss {
    self.backgroundView.layer.shadowPath =  [UIBezierPath bezierPathWithRect:CGRectZero].CGPath;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = self.animationTransform;
        self.backgroundView.alpha =  0;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (CGPoint)arrowPointWithDependentViewFrame:(CGRect)rect {
    CGPoint point = CGPointZero;
    switch (self.arrowPosition) {
        case SYSelectBoxArrowPositionTopLeft:
        case SYSelectBoxArrowPositionTopCenter:
        case SYSelectBoxArrowPositionTopRight:
           point = CGPointMake(rect.origin.x + rect.size.width * 0.5, rect.origin.y + rect.size.height);
            break;
        case SYSelectBoxArrowPositionLeftTop:
        case SYSelectBoxArrowPositionLeftCenter:
        case SYSelectBoxArrowPositionLeftBottom:
           point = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height * 0.5);
            break;
        case SYSelectBoxArrowPositionBottomLeft:
        case SYSelectBoxArrowPositionBottomCenter:
        case SYSelectBoxArrowPositionBottomRight:
           point = CGPointMake(rect.origin.x + rect.size.width * 0.5, rect.origin.y);
            break;
        case SYSelectBoxArrowPositionRightTop:
        case SYSelectBoxArrowPositionRightCenter:
        case SYSelectBoxArrowPositionRightBottom:
            point = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.5);
            break;
    }
    return point;
}

- (CGRect)frameWithArrorPoint:(CGPoint)point {
    CGRect frame = CGRectZero;
    
    switch (self.arrowPosition) {
        case SYSelectBoxArrowPositionTopLeft:
            frame = CGRectMake(point.x - SYArrowBorderMargin - SYArrowWidth * 0.5 - SYCornerRodius, point.y, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionTopCenter:
            frame = CGRectMake(point.x - self.frame.size.width * 0.5, point.y, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionTopRight:
            frame = CGRectMake(point.x - self.frame.size.width + SYArrowBorderMargin + SYArrowWidth * 0.5 + SYCornerRodius, point.y, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionLeftTop:
             frame = CGRectMake(point.x, point.y - SYArrowBorderMargin - SYArrowWidth * 0.5 - SYCornerRodius, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionLeftCenter:
             frame = CGRectMake(point.x, point.y - self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionLeftBottom:
             frame = CGRectMake(point.x, point.y - self.frame.size.height + SYArrowWidth*0.5 + SYArrowBorderMargin + SYCornerRodius, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionBottomLeft:
            frame = CGRectMake(point.x - SYArrowBorderMargin - SYArrowWidth * 0.5 - SYCornerRodius, point.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionBottomCenter:
            frame = CGRectMake(point.x - self.frame.size.width * 0.5, point.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionBottomRight:
             frame = CGRectMake(point.x - self.frame.size.width + SYArrowBorderMargin + SYArrowWidth * 0.5 + SYCornerRodius, point.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionRightTop:
             frame = CGRectMake(point.x - self.frame.size.width, point.y - SYArrowBorderMargin - SYArrowWidth * 0.5 - SYCornerRodius, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionRightCenter:
              frame = CGRectMake(point.x - self.frame.size.width, point.y - self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height);
            break;
        case SYSelectBoxArrowPositionRightBottom:
              frame = CGRectMake(point.x - self.frame.size.width, point.y - self.frame.size.height + SYArrowWidth*0.5 + SYArrowBorderMargin + SYCornerRodius, self.frame.size.width, self.frame.size.height);
            break;
    }
    
    if (frame.origin.x < 0) {
        frame = CGRectMake(10, frame.origin.y, frame.size.width + frame.origin.x - 10, frame.size.height);
    }
    
    if (frame.origin.x + frame.size.width > ScreenW) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, ScreenW - frame.origin.x - 10, frame.size.height);
    }
    
    if (frame.origin.y < 0) {
        frame = CGRectMake(frame.origin.x, 20, frame.size.width, frame.origin.y + frame.size.height - 20);
    }
    
    if (frame.origin.y + frame.size.height > ScreenH) {
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ScreenH - frame.origin.y - 10);
    }
    
    return frame;
}

- (CGAffineTransform)animationTransform {
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.arrowPosition) {
        case SYSelectBoxArrowPositionTopLeft:
        case SYSelectBoxArrowPositionTopCenter:
        case SYSelectBoxArrowPositionTopRight:
            transform = CGAffineTransformTranslate(transform, 0, -self.frame.size.height/2);
            break;
        case SYSelectBoxArrowPositionLeftTop:
        case SYSelectBoxArrowPositionLeftCenter:
        case SYSelectBoxArrowPositionLeftBottom:
            transform = CGAffineTransformTranslate(transform, -self.frame.size.width/2, 0);
            break;
        case SYSelectBoxArrowPositionBottomLeft:
        case SYSelectBoxArrowPositionBottomCenter:
        case SYSelectBoxArrowPositionBottomRight:
            transform = CGAffineTransformTranslate(transform, 0, self.frame.size.height/2);
            break;
        case SYSelectBoxArrowPositionRightTop:
        case SYSelectBoxArrowPositionRightCenter:
        case SYSelectBoxArrowPositionRightBottom:
            transform = CGAffineTransformTranslate(transform, self.frame.size.width/2, 0);
            break;
    }
    transform = CGAffineTransformScale(transform, 0.01, 0.01);
    return transform;
}

#pragma mark - 懒加载
- (UIView *)contentView {
    if (_contentView == nil) {
        CGRect rect = CGRectZero;
        switch (self.arrowPosition) {
            case SYSelectBoxArrowPositionTopLeft:
            case SYSelectBoxArrowPositionTopCenter:
            case SYSelectBoxArrowPositionTopRight:
                rect = CGRectMake(0, SYArrowHeight, SelfWidth, SelfHeight - SYArrowHeight);
                break;
            case SYSelectBoxArrowPositionLeftTop:
            case SYSelectBoxArrowPositionLeftCenter:
            case SYSelectBoxArrowPositionLeftBottom:
                rect = CGRectMake(SYArrowHeight, 0, SelfWidth - SYArrowHeight, SelfHeight);
                break;
            case SYSelectBoxArrowPositionBottomLeft:
            case SYSelectBoxArrowPositionBottomCenter:
            case SYSelectBoxArrowPositionBottomRight:
                rect = CGRectMake(0, 0, SelfWidth, SelfHeight - SYArrowHeight);
                break;
            case SYSelectBoxArrowPositionRightTop:
            case SYSelectBoxArrowPositionRightCenter:
            case SYSelectBoxArrowPositionRightBottom:
                rect = CGRectMake(0, 0, SelfWidth - SYArrowHeight, SelfHeight);
                break;
        }
        _contentView = [[UIView alloc] initWithFrame:rect];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        _backgroundView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [_backgroundView addGestureRecognizer:tap];
        _backgroundView.tag = 9999;
    }
    return _backgroundView;
}

- (UIBezierPath *)borderPath {
    if (_borderPath == nil) {
        _borderPath = [[UIBezierPath alloc] init];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        CGPoint arrorRight = CGPointZero;
        CGPoint arrorTop = CGPointZero;
        CGPoint arrorLeft = CGPointZero;
        
        NSInteger index = 0;
        
        switch (self.arrowPosition) {
                
            case SYSelectBoxArrowPositionTopLeft:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius + SYArrowHeight) isVertical:NO];
                arrorRight = CGPointMake(SYCornerRodius + SYArrowBorderMargin + SYArrowWidth, SYArrowHeight);
                arrorTop = CGPointMake(arrorRight.x - SYArrowWidth * 0.5, 0);
                arrorLeft = CGPointMake(arrorRight.x - SYArrowWidth, arrorRight.y);
                index = 7;
                break;
            case SYSelectBoxArrowPositionTopCenter:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius + SYArrowHeight) isVertical:NO];
                arrorRight = CGPointMake((SelfWidth + SYArrowWidth)*0.5, SYArrowHeight);
                arrorTop = CGPointMake(arrorRight.x - SYArrowWidth * 0.5, 0);
                arrorLeft = CGPointMake(arrorRight.x - SYArrowWidth, arrorRight.y);
                index = 7;
                break;
            case SYSelectBoxArrowPositionTopRight:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius + SYArrowHeight) isVertical:NO];
                arrorRight = CGPointMake(SelfWidth - SYCornerRodius - SYArrowBorderMargin, SYArrowHeight);
                arrorTop = CGPointMake(arrorRight.x - SYArrowWidth * 0.5, 0);
                arrorLeft = CGPointMake(arrorRight.x - SYArrowWidth, arrorRight.y);
                index = 7;
                break;
                
            case SYSelectBoxArrowPositionLeftTop:
                tempArray = [self basePointsByStartPoints:CGPointMake(SYArrowHeight, SYCornerRodius ) isVertical:YES];
                arrorRight = CGPointMake(SYArrowHeight, SYCornerRodius + SYArrowBorderMargin);
                arrorTop = CGPointMake(0,arrorRight.y + SYArrowWidth * 0.5);
                arrorLeft = CGPointMake(arrorRight.x, arrorRight.y + SYArrowWidth);
                index = 1;
                break;
            case SYSelectBoxArrowPositionLeftCenter:
                tempArray = [self basePointsByStartPoints:CGPointMake(SYArrowHeight, SYCornerRodius ) isVertical:YES];
                arrorRight = CGPointMake(SYArrowHeight, (SelfHeight - SYArrowWidth) *0.5);
                arrorTop = CGPointMake(0,arrorRight.y + SYArrowWidth * 0.5);
                arrorLeft = CGPointMake(arrorRight.x, arrorRight.y + SYArrowWidth);
                 index = 1;
                break;
            case SYSelectBoxArrowPositionLeftBottom:
                tempArray = [self basePointsByStartPoints:CGPointMake(SYArrowHeight, SYCornerRodius ) isVertical:YES];
                arrorRight = CGPointMake(SYArrowHeight, SelfHeight - SYCornerRodius - SYArrowBorderMargin - SYArrowWidth);
                arrorTop = CGPointMake(0,arrorRight.y + SYArrowWidth * 0.5);
                arrorLeft = CGPointMake(arrorRight.x, arrorRight.y + SYArrowWidth);
                index = 1;
                break;
                
            case SYSelectBoxArrowPositionBottomLeft:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius) isVertical:NO];
                arrorRight = CGPointMake(SYCornerRodius + SYArrowBorderMargin, SelfHeight-SYArrowHeight);
                arrorTop = CGPointMake(arrorRight.x + SYArrowWidth * 0.5, SelfHeight);
                arrorLeft = CGPointMake(arrorRight.x + SYArrowWidth, arrorRight.y);
                index = 3;
                break;
            case SYSelectBoxArrowPositionBottomCenter:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius) isVertical:NO];
                arrorRight = CGPointMake((SelfWidth - SYArrowWidth)*0.5, SelfHeight-SYArrowHeight);
                arrorTop = CGPointMake(arrorRight.x + SYArrowWidth * 0.5, SelfHeight);
                arrorLeft = CGPointMake(arrorRight.x + SYArrowWidth, arrorRight.y);
                index = 3;
                break;
            case SYSelectBoxArrowPositionBottomRight:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius) isVertical:NO];
                arrorRight = CGPointMake(SelfWidth - SYCornerRodius - SYArrowBorderMargin - SYArrowWidth, SelfHeight-SYArrowHeight);
                arrorTop = CGPointMake(arrorRight.x + SYArrowWidth * 0.5, SelfHeight);
                arrorLeft = CGPointMake(arrorRight.x + SYArrowWidth, arrorRight.y);
                index = 3;
                break;
                
            case SYSelectBoxArrowPositionRightTop:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius) isVertical:YES];
                arrorRight = CGPointMake(SelfWidth - SYArrowHeight, SYCornerRodius + SYArrowBorderMargin + SYArrowWidth);
                arrorTop = CGPointMake(SelfWidth,arrorRight.y - SYArrowWidth * 0.5);
                arrorLeft = CGPointMake(arrorRight.x, arrorRight.y - SYArrowWidth);
                index = 5;
                break;
            case SYSelectBoxArrowPositionRightCenter:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius) isVertical:YES];
                arrorRight = CGPointMake(SelfWidth - SYArrowHeight, (SelfHeight + SYArrowWidth)*0.5);
                arrorTop = CGPointMake(SelfWidth,arrorRight.y - SYArrowWidth * 0.5);
                arrorLeft = CGPointMake(arrorRight.x, arrorRight.y - SYArrowWidth);
                index = 5;
                break;
            case SYSelectBoxArrowPositionRightBottom:
                tempArray = [self basePointsByStartPoints:CGPointMake(0, SYCornerRodius) isVertical:YES];
                arrorRight = CGPointMake(SelfWidth - SYArrowHeight, SelfHeight - SYArrowBorderMargin - SYCornerRodius);
                arrorTop = CGPointMake(SelfWidth,arrorRight.y - SYArrowWidth * 0.5);
                arrorLeft = CGPointMake(arrorRight.x, arrorRight.y - SYArrowWidth);
                index = 5;
                break;
        }
        
        SYBezierModel *arrorRightModel = [[SYBezierModel alloc] initWithPoint:arrorRight controlPoint:CGPointZero andDrawType:SYBezierDrawTypeLine];
        [tempArray insertObject:arrorRightModel atIndex:index];
        SYBezierModel *arrorTopModel = [[SYBezierModel alloc] initWithPoint:arrorTop controlPoint:CGPointZero andDrawType:SYBezierDrawTypeLine];
        [tempArray insertObject:arrorTopModel atIndex:index + 1];
        SYBezierModel *arrorLeftModel = [[SYBezierModel alloc] initWithPoint:arrorLeft controlPoint:CGPointZero andDrawType:SYBezierDrawTypeLine];
        [tempArray insertObject:arrorLeftModel atIndex:index + 2];
        
        for (SYBezierModel *model in tempArray) {
            if (model.type == SYBezierDrawTypeStart) {
                 [_borderPath moveToPoint:model.point];
            }else if (model.type == SYBezierDrawTypeLine) {
                [_borderPath addLineToPoint:model.point];
            }else {
                [_borderPath addQuadCurveToPoint:model.point controlPoint:model.controlPoint];
            }
        }
    }
    return _borderPath;
}

- (NSMutableArray *)basePointsByStartPoints:(CGPoint)startPoint isVertical:(BOOL )vertical{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    SYBezierModel *startModel = [[SYBezierModel alloc] initWithPoint:startPoint controlPoint:CGPointZero andDrawType:SYBezierDrawTypeStart];
    [tempArray addObject:startModel];
    
    CGPoint point = CGPointZero;
    CGPoint controlPoint = CGPointZero;
    
    CGFloat marginV = vertical?(self.frame.size.height - 2 *SYCornerRodius):(self.frame.size.height - SYArrowHeight - 2 *SYCornerRodius);
    CGFloat marginH = vertical?(self.frame.size.width - SYArrowHeight):self.frame.size.width;
    
    for (int i = 0; i < 8; i++) {
        switch (i) {
            case 0:
                point = CGPointMake(startPoint.x, startPoint.y + marginV);
                controlPoint = CGPointZero;
                break;
            case 1:
                point = CGPointMake(startPoint.x + SYCornerRodius, startPoint.y + marginV  + SYCornerRodius);
                controlPoint = CGPointMake(startPoint.x, startPoint.y + marginV + SYCornerRodius);
                break;
            case 2:
                point = CGPointMake(startPoint.x + marginH - SYCornerRodius, startPoint.y + marginV  + SYCornerRodius);
                controlPoint = CGPointZero;
                break;
            case 3:
                point = CGPointMake(startPoint.x + marginH, startPoint.y + marginV);
                controlPoint = CGPointMake(startPoint.x + marginH, startPoint.y + marginV + SYCornerRodius);
                break;
            case 4:
                point = CGPointMake(startPoint.x + marginH, startPoint.y);
                controlPoint = CGPointZero;
                break;
            case 5:
                point = CGPointMake(startPoint.x + marginH - SYCornerRodius, startPoint.y - SYCornerRodius);
                controlPoint = CGPointMake(startPoint.x + marginH, startPoint.y - SYCornerRodius);
                break;
            case 6:
                point = CGPointMake(startPoint.x + SYCornerRodius, startPoint.y - SYCornerRodius);
                controlPoint = CGPointZero;
                break;
            case 7:
                point = startPoint;
                controlPoint = CGPointMake(startPoint.x, startPoint.y - SYCornerRodius);
                break;
            default:
                break;
        }
        SYBezierModel *model = [[SYBezierModel alloc] initWithPoint:point controlPoint:controlPoint andDrawType:i%2 == 0?SYBezierDrawTypeLine:SYBezierDrawTypeCurve];
        [tempArray addObject:model];
    }
    return tempArray;
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




