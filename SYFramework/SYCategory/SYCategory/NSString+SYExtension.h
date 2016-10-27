
#import <UIKit/UIKit.h>

@interface NSString (SYExtension)

#pragma mark - 计算大小
/**
 *  计算一行文字的大小
 *
 *  @param font  字体大小
 *
 *  @return CGSize
 */
- (CGSize)sy_sizeOnSingleRowWithFont:(CGFloat)font;
/**
 *  根据字体大小计算多行行文字的size
 *
 *  @param font  字体大小
 *  @param width 文字显示的宽度
 *
 *  @return CGSize
 */
- (CGSize)sy_sizeWithWidth:(CGFloat)width andFont:(CGFloat)font;

#pragma mark - 富文本
/**
 *  将NSString 转换成 NSAttributedString
 *
 *  @param color 颜色
 *  @param font  字体大小
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)sy_attributeStringWithColor:(UIColor *)color andFont:(UIFont *)font;
/**
 *  将NSString 转换成 NSAttributedString 并且设置行间距
 *
 *  @param color 颜色
 *  @param font  字体大小
 *  @param multiple  行间距倍数
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)sy_attributeStringWithColor:(UIColor *)color andFont:(UIFont *)font andHeightMultiple:(CGFloat)multiple;
/**
 *  将NSString 转换成 NSAttributedString 并且设置行间距
 *
 *  @param color 颜色
 *  @param font  字体大小
 *  @param lineHeight  额外增加的行高
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)sy_attributeStringWithColor:(UIColor *)color andFont:(UIFont *)font andLineHeight:(CGFloat)lineHeight;
@end
