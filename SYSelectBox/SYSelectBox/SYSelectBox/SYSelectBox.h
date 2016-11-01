//
//  SYSelectBox.h
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

//箭头的朝向
typedef NS_ENUM(NSUInteger, SYSelectBoxArrowPosition) {
    SYSelectBoxArrowPositionTopLeft,            //上左
    SYSelectBoxArrowPositionTopCenter,        //上中
    SYSelectBoxArrowPositionTopRight,          //上右
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
 *  自定义view
 */
@property (nonatomic, strong,readonly) UIView *customView;
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
/**
 *  依赖展开
 *
 *  @param dependentView 依赖的view
 */
- (void)showDependentOnView:(UIView *)dependentView;
/**
 *  依赖某点展开
 *
 *  @param point 依赖的点,改点必须是相对于UIScreen屏幕上的点
 */
- (void)showDependentOnPoint:(CGPoint)point;
@end




