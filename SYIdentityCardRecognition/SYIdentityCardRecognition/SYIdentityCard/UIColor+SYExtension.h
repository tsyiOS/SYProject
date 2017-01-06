
#import <UIKit/UIKit.h>

@interface UIColor (SYExtension)
@property (nonatomic,readonly) CGFloat sy_red;
@property (nonatomic,readonly) CGFloat sy_green;
@property (nonatomic,readonly) CGFloat sy_blue;
@property (nonatomic,readonly) CGFloat sy_alpha;

/**
 *  十六进制色值
 *
 *  @param rgb 十六进制
 *
 *  @return 颜色
 */
+ (UIColor *)sy_colorWithRGB:(u_int32_t)rgb;
/**
 *  默认的分割线颜色
 *
 *  @return 0xdddddd十六进制色
 */
+ (UIColor *)lineDefaultColor;
/**
 *  随机色
 *
 *  @return 随机色
 */
+ (UIColor *)sy_randomColor;
/**
 *  @brief  渐变颜色
 *
 *  @param startColor     开始颜色
 *  @param endColor     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)sy_gradientFromColor:(UIColor*)startColor toColor:(UIColor*)endColor withHeight:(CGFloat)height;

@end
