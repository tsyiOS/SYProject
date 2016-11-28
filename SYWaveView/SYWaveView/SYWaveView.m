//
//  SYWaveView.m
//  SYCATextLayer
//
//  Created by leju_esf on 16/11/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYWaveView.h"

@interface SYWaveView ()
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) CGFloat lastValue;
@property (nonatomic, assign) CGFloat valueMargin;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CAShapeLayer *backLayer;
@end

@implementation SYWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _waveAmplitude = 10.0;
        _waveCycle = 100.0;
        _waveSpeed = 0.2;
        _waveColor = [UIColor orangeColor];
        _lastValue =  0.5;
        _value = 0.5;
        _valueMargin = 0;
        _valueChangeAnimation = YES;
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height*0.5;
       
        [self.layer addSublayer:self.waveLayer];
        [self.layer addSublayer:self.textLayer];
        [self.layer addSublayer:self.backLayer];
        
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startWave)];
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setWaveColor:(UIColor *)waveColor {
    _waveColor = waveColor;
    self.waveLayer.fillColor = waveColor.CGColor;
}

- (void)setValue:(CGFloat)value {
    self.lastValue = value >= 0?(value>1.0?1.0:value):0;
    self.valueMargin = _valueChangeAnimation?(self.lastValue - self.value)/100:(self.lastValue - self.value);
}

- (void)startWave {
    self.offsetX += self.waveSpeed;
    
    if (self.value != self.lastValue) {
        _value += self.valueMargin;
    }
    
    if ((self.value - self.lastValue)*self.valueMargin > 0) {
        _value = self.lastValue;
    }
    
    self.textLayer.string = [NSString stringWithFormat:@"%.1f%%",self.value*100];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int x = 0; x <= self.frame.size.width; x++) {
        CGFloat y = self.waveAmplitude*sin(2*M_PI*x/self.waveCycle - self.offsetX) + self.frame.size.height*(1-self.value) - (ceil(self.value*100)/100 == 0 ? -1:1)*self.waveAmplitude;
        if (x == 0) {
            [path moveToPoint:CGPointMake(x, y)];
        }else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    self.waveLayer.path = path.CGPath;
    self.backLayer.path = path.CGPath;
}


- (CAShapeLayer *)waveLayer {
    if (_waveLayer == nil) {
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = self.waveColor.CGColor;
    }
    return _waveLayer;
}

- (CAShapeLayer *)backLayer {
    if (_backLayer == nil) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.frame = self.bounds;
        _backLayer.fillColor = [UIColor yellowColor].CGColor;
        _backLayer.backgroundColor = [UIColor blackColor].CGColor;
        _backLayer.mask = self.textLayer;
    }
    return _backLayer;
}

- (CATextLayer *)textLayer {
    if (_textLayer == nil) {
        _textLayer = [CATextLayer layer];
        _textLayer = [CATextLayer layer];
        _textLayer.alignmentMode =kCAAlignmentCenter;
        _textLayer.wrapped =YES;
        
        _textLayer.frame = CGRectMake(0, (self.frame.size.height - 30)*0.5, self.frame.size.width, 30);
        UIFont *font = [UIFont systemFontOfSize:30];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef =CGFontCreateWithFontName(fontName);
        _textLayer.font = fontRef;
        _textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _textLayer;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.waveDisplaylink invalidate];
    self.waveDisplaylink = nil;
}

@end
