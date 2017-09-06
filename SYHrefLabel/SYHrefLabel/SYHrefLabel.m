//
//  SYHrefLabel.m
//  SYHrefLabel
//
//  Created by leju_esf on 2017/9/5.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYHrefLabel.h"
#import <CoreText/CoreText.h>

@interface SYHrefLabel ()
@property (nonatomic, strong) UIView *shadow;
@end

@implementation SYHrefLabel

- (NSAttributedString *)linkString {
    return [ERAttributedStringModel attributedStringWithModels:self.models andLineHeight:6];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setUpLabel];
}

- (void)setUpLabel {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextConcatCTM(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height));
    NSAttributedString *content = [self linkString];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPathAddRect(paths, NULL, self.bounds);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, content.length), paths, NULL);
    CTFrameDraw(frame, ctx);
    CFArrayRef lines = CTFrameGetLines(frame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    
    NSInteger index = 0;
    CGFloat drawWidth = 0;
    for (int idx = 0; idx < CFArrayGetCount(lines); idx++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, idx);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        
        for (int i = 0; i < CFArrayGetCount(runs); i++) {
            
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[idx];
            CTRunRef run = CFArrayGetValueAtIndex(runs, i);
            CGFloat runWidth = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);
            CGRect runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), self.bounds.size.height - lineOrigin.y - runAscent, runWidth, runAscent + runDescent);
            ERAttributedStringModel *model = self.models[index];
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGFloat totalWidth = [model.attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,runRect.size.height) options:options context:nil].size.width;
            if (roundf((runWidth + drawWidth)*100)/100 < roundf(totalWidth*100)/100) {
                drawWidth += runWidth;
            }else {
                index ++;
                drawWidth = 0;
            }
            [model.reacts addObject:NSStringFromCGRect(runRect)];
            
        }
    }
    
    CFRelease(paths);
    CFRelease(frame);
    CFRelease(framesetter);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    for (ERAttributedStringModel *model in self.models) {
        for (NSString *rectStr in model.reacts) {
            CGRect rect = CGRectFromString(rectStr);
            if (CGRectContainsPoint(rect,touchPoint) && CGRectEqualToRect(rect, self.shadow.frame)) {
                if (model.hrefAction) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.shadow.frame = CGRectZero;
                    });
                    model.hrefAction();
                }
                return;
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    for (ERAttributedStringModel *model in self.models) {
        for (NSString *rectStr in model.reacts) {
            CGRect rect = CGRectFromString(rectStr);
            if (CGRectContainsPoint(rect,touchPoint)) {
                if (model.hrefAction) {
                    self.shadow.frame = rect;
                    [self addSubview:self.shadow];
                }
                return;
            }
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    if (!CGRectEqualToRect(self.shadow.frame, CGRectZero)) {
        if (!CGRectContainsPoint(self.shadow.frame, touchPoint)) {
            self.shadow.frame = CGRectZero;
        }
    }
}

- (UIView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIView alloc] init];
        _shadow.backgroundColor = [UIColor grayColor];
        _shadow.alpha = 0.3;
    }
    return _shadow;
}
@end
