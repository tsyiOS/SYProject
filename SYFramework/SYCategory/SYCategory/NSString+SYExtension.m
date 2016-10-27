
#import "NSString+SYExtension.h"

@implementation NSString (SYExtension)

- (CGSize)sy_sizeWithWidth:(CGFloat)width andFont:(CGFloat)font{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName :[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName : style };
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
}

- (CGSize)sy_sizeOnSingleRowWithFont:(CGFloat)font{
    return [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}

- (NSAttributedString *)sy_attributeStringWithColor:(UIColor *)color andFont:(UIFont *)font {
    return [[NSAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
}

- (NSAttributedString *)sy_attributeStringWithColor:(UIColor *)color andFont:(UIFont *)font andHeightMultiple:(CGFloat)multiple {
    NSAttributedString *attributeStr = [self sy_attributeStringWithColor:color andFont:font];
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineHeightMultiple = multiple;
    [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, mutableStr.length)];
    return mutableStr;
}

- (NSAttributedString *)sy_attributeStringWithColor:(UIColor *)color andFont:(UIFont *)font andLineHeight:(CGFloat)lineHeight {
    NSAttributedString *attributeStr = [self sy_attributeStringWithColor:color andFont:font];
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = lineHeight;
    [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, mutableStr.length)];
    return mutableStr;
}
@end
