
#import "NSAttributedString+SYExtension.h"

@implementation NSAttributedString (SYExtension)
- (CGSize)sy_sizeWithWidth:(CGFloat)width {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil].size;
}

- (CGSize)sy_sizeOnSingleRow {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:options context:nil].size;
}
@end
