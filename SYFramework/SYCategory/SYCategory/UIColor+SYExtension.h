
#import <UIKit/UIKit.h>

@interface UIColor (SYExtension)
@property (nonatomic,readonly) CGFloat sy_red;
@property (nonatomic,readonly) CGFloat sy_green;
@property (nonatomic,readonly) CGFloat sy_blue;
@property (nonatomic,readonly) CGFloat sy_alpha;

+ (UIColor *)sy_colorWithRGB:(u_int32_t)rgb;
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
