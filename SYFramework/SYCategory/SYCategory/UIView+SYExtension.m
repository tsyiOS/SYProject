
#import "UIView+SYExtension.h"

@implementation UIView (SYExtension)
@dynamic sy_x, sy_y, sy_left, sy_right, sy_top, sy_bottom, sy_origin, sy_size, sy_width, sy_height, sy_centerX, sy_centerY;

- (CGFloat)sy_x {
    return self.frame.origin.x;
}

- (void)setSy_x:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)sy_y {
    return self.frame.origin.y;
}

- (void)setSy_y:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)sy_left {
    return self.frame.origin.x;
}

- (void)setSy_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)sy_top {
    return self.frame.origin.y;
}

- (void)setSy_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)sy_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSy_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)sy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSy_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sy_centerX {
    return self.center.x;
}

- (void)setSy_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)sy_centerY {
    return self.center.y;
}

- (void)setSy_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)sy_width {
    return self.frame.size.width;
}

- (void)setSy_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)sy_height {
    return self.frame.size.height;
}

- (void)setSy_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)sy_origin {
    return self.frame.origin;
}

- (void)setSy_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)sy_size {
    return self.frame.size;
}

- (void)setSy_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end
