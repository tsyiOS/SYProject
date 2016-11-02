//
//  SYBubbleBox.h
//  SYBubbleBox
//
//  Created by leju_esf on 16/11/2.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBubbleBox : UIView
/**
 *  小按钮的点击的事件
 */
@property (nonatomic, copy) void (^action)(NSInteger index);
/**
 *  起始角度 0°~360° 默认90
 */
@property (nonatomic, assign) CGFloat startAngle;
/**
 *  终止角度 0°~360° 默认180
 */
@property (nonatomic, assign) CGFloat endAngle;
/**
 *  是否允许旋转 默认 NO
 */
@property (nonatomic, assign) BOOL allowRotation;
/**
 *  中心按钮点击之后旋转的角度，默认旋转45°
 */
@property (nonatomic, assign) CGFloat centerRotateAngle;
/**
 *  展开后的半径 默认150
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  小按钮直径 默认比中心按钮小10
 */
@property (nonatomic, assign) CGFloat itemDiam;
/**
 *  小按钮的颜色
 */
@property (nonatomic, strong) UIColor *itemColor;
/**
 *  小按钮的字体大小
 */
@property (nonatomic, strong) UIFont *itemFont;
/**
 *  小按钮的文字颜色
 */
@property (nonatomic, strong) UIColor *itemTextColor;
/**
 *  中心按钮的图片
 */
@property (nonatomic, strong) UIImage *centerImage;
/**
 *  中心按钮的文字
 */
@property (nonatomic, copy) NSString *centerTitle;
/**
 *  中心按钮的颜色
 */
@property (nonatomic, strong) UIColor *centerColor;
/**
 *  中心按钮的字体大小
 */
@property (nonatomic, strong) UIFont *centerFont;
/**
 *  中心按钮的文字颜色
 */
@property (nonatomic, strong) UIColor *centerTextColor;

/**
 *  构造方法
 *
 *  @param titles 小按钮的标题数组
 *  @param frame  大按钮的frame
 *
 *  @return 浮层View
 */
- (instancetype)initWithTitles:(NSArray *)titles andFrame:(CGRect)frame;

/**
 *  展开按钮
 */
- (void)show;
/**
 *  收回按钮
 */
- (void)dismiss;
@end
