
#import <UIKit/UIKit.h>

@interface NSAttributedString (SYExtension)
#pragma mark - 计算大小
/**
 *  根据宽度计算多行文字的大小
 *
 *  @param width  文字总宽度
 *
 *  @return CGSize
 */
- (CGSize)sy_sizeWithWidth:(CGFloat)width;
/**
 *  计算一行文字的大小
 *
 *  @return CGSize
 */
- (CGSize)sy_sizeOnSingleRow;
@end
