//
//  SYSelectBox.h
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYSelectBoxArrowPosition) {
    SYSelectBoxArrowPositionTopLeft,            //上左
    SYSelectBoxArrowPositionTopCenter,        //上中
    SYSelectBoxArrowPositionTopRight,
    SYSelectBoxArrowPositionLeftTop,
    SYSelectBoxArrowPositionLeftCenter,
    SYSelectBoxArrowPositionLeftBottom,
    SYSelectBoxArrowPositionBottomLeft,
    SYSelectBoxArrowPositionBottomCenter,
    SYSelectBoxArrowPositionBottomRight,
    SYSelectBoxArrowPositionRightTop,
    SYSelectBoxArrowPositionRightCenter,
    SYSelectBoxArrowPositionRightBottom
};

@interface SYSelectBox : UIView
/**
 *  实例方法
 *
 *  @param frame        大小
 *  @param dataSrcArray 显示的数据源
 *  @param direction    箭头方向
 *
 *  @return 下拉菜单
 */
- (instancetype)initWithSize:(CGSize)size direction:(SYSelectBoxArrowPosition) position andCustomView:(UIView *)customView;
- (void)showDependentOn:(UIView *)dependentView;
@end

typedef NS_ENUM(NSUInteger, SYBezierDrawType) {
    SYBezierDrawTypeStart,
    SYBezierDrawTypeLine,
    SYBezierDrawTypeCurve
};

@interface SYBezierModel : NSObject
@property (nonatomic, assign) CGPoint point;
/**
 *  基准点，画曲线时候用
 */
@property (nonatomic, assign) CGPoint controlPoint;
@property (nonatomic, assign) SYBezierDrawType type;
- (instancetype)initWithPoint:(CGPoint)point controlPoint:(CGPoint)control andDrawType:(SYBezierDrawType)type;
@end


