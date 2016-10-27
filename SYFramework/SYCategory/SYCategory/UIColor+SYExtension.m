
#import "UIColor+SYExtension.h"

@implementation UIColor (SYExtension)
+ (UIColor *)sy_colorWithRGB:(u_int32_t)rgb {
    return [UIColor colorWithRed:((rgb&0xff0000)>>16)/255.0 green:((rgb&0xff00)>>8)/255.0 blue:(rgb&0xff)/255.0 alpha:1.0];
}

+ (UIColor *)lineDefaultColor {
    return  [self sy_colorWithRGB:0xdddddd];
}

+ (UIColor *)appMainColor {
    return [self sy_colorWithRGB:0xde2418];
}

+ (UIColor *)textLightGrayColor {
    return [self sy_colorWithRGB:0x999999];
}

- (CGFloat)sy_red {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[0];
}

- (CGFloat)sy_green {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[1];
}

- (CGFloat)sy_blue {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[2];
}

- (CGFloat)sy_alpha {
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return alpha;
}
@end
