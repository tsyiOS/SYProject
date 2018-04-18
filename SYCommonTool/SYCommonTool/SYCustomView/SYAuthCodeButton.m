//
//  SYAuthCodeButton.m
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import "SYAuthCodeButton.h"
#import "SYCommonTool.h"

@interface SYAuthCodeButton ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SYAuthCodeButton
@dynamic active;
- (void)awakeFromNib {
    [super awakeFromNib];
    _totalCount = 30;
    _lastCount = 0;
    _hightLightColor = [UIColor blueColor];
    [self setTitleColor:_hightLightColor forState:UIControlStateNormal];
    self.layer.borderColor = _hightLightColor.CGColor;
    [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _totalCount = 30;
        _lastCount = 0;
        _hightLightColor = [UIColor blueColor];
        [self setTitleColor:_hightLightColor forState:UIControlStateNormal];
        self.layer.borderColor = _hightLightColor.CGColor;
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickAction {
    if (self.sendCodeAction && self.lastCount == 0) {
        self.sendCodeAction();
        self.lastCount = self.totalCount;
        
        
    }
}

- (void)remainTime {
    if ((self.lastCount <= 0) != self.active) {
        self.active = self.lastCount <= 0;
    }
    if (self.lastCount <= 0) {
        [self stopTimer];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    }else {
        [self setTitle:[NSString stringWithFormat:@"已发送(%02zds)",self.lastCount] forState:UIControlStateNormal];
        _lastCount --;
    }
}

- (BOOL)active {
    return self.userInteractionEnabled;
}

- (void)setActive:(BOOL)active {
    if (active && self.lastCount == 0) {
        [self setTitleColor:_hightLightColor forState:UIControlStateNormal];
        self.layer.borderColor = _hightLightColor.CGColor;
        self.userInteractionEnabled = YES;
    }else {
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.userInteractionEnabled = NO;
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    self.lastCount = 0;
}

- (void)setLastCount:(NSInteger)lastCount {
    _lastCount = lastCount;
    if (lastCount > 0) {
        [self.timer fire];
    }
}

- (void)setHightLightColor:(UIColor *)hightLightColor {
    _hightLightColor = hightLightColor;
    [self setTitleColor:_hightLightColor forState:UIControlStateNormal];
    self.layer.borderColor = _hightLightColor.CGColor;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(remainTime) userInfo:nil repeats:YES];
    }
    return _timer;
}



@end
