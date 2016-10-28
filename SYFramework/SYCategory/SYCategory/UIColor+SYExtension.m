
#import "UIColor+SYExtension.h"

@implementation UIColor (SYExtension)

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

+ (UIColor *)sy_colorWithRGB:(u_int32_t)rgb {
    return [UIColor colorWithRed:((rgb&0xff0000)>>16)/255.0 green:((rgb&0xff00)>>8)/255.0 blue:(rgb&0xff)/255.0 alpha:1.0];
}

+ (UIColor *)lineDefaultColor {
    return  [self sy_colorWithRGB:0xdddddd];
}

+ (UIColor *)sy_randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

+ (UIColor*)sy_gradientFromColor:(UIColor*)startColor toColor:(UIColor*)endColor withHeight:(CGFloat)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}
@end
