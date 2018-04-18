//
//  SYSwitchView.m
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/18.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import "SYSwitchView.h"

#define BaseTag 100

@interface SYSwitchView ()
@property (nonatomic, strong) UIView *line;
@end

@implementation SYSwitchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _selectedColor = [UIColor blueColor];
        _normalColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    for (UIView *sub in self.subviews) {
        if (sub.tag >= BaseTag) {
            [sub removeFromSuperview];
        }
    }
    
    NSInteger count = 0;
    for (int i = 0; i< self.titles.count; i++) {
        NSString *title = self.titles[i];
        count += title.length;
    }
    
    CGFloat lastX = 0;
    CGFloat marginX = (self.bounds.size.width - (count * 15) - 10 * self.titles.count)/(self.titles.count + 1) ;
    
    for (int i = 0; i< self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i+BaseTag;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(lastX + marginX, 0, title.length * 15 + 10, self.bounds.size.height);
        [self addSubview:btn];
        
        if (i == 0) {
            [btn setTitleColor:self.selectedColor forState:UIControlStateNormal];
            self.selectedIndex = i;
        }
        lastX = CGRectGetMaxX(btn.frame);
    }
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == self.selectedIndex) {
        return;
    }else {
        UIButton *lastBtn = [self viewWithTag:self.selectedIndex + BaseTag];
        [self exchangeStatusWithButton:sender andButton:lastBtn];
        self.selectedIndex = sender.tag - BaseTag;
        if (self.touchAction) {
            self.touchAction(sender.tag - BaseTag);
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    UIButton *lastBtn = [self viewWithTag:selectedIndex + BaseTag];
    [self addSubview:self.line];
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake(lastBtn.frame.origin.x, lastBtn.frame.size.height - 3, lastBtn.frame.size.width, 3);
    }];
}

- (void)exchangeStatusWithButton:(UIButton *)sender1 andButton:(UIButton *)sender2 {
    [sender1 setTitleColor:self.selectedColor forState:UIControlStateNormal];
    [sender2 setTitleColor:self.normalColor forState:UIControlStateNormal];
}

- (UIView *)line {
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = self.selectedColor;
    }
    return _line;
}
@end
