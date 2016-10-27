//
//  SYSlideSelectedView.h
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/6/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYSlideSelectedView.h"

@interface SYSlideSelectedView ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, assign) NSInteger selectedTag;
@end

@implementation SYSlideSelectedView

- (instancetype)initWithTitles:(NSArray *)titles frame:(CGRect)frame normalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor {
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _selectedColor = selectedColor;
        _normalColor = normalColor;
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)slideLineOffset:(CGFloat)offset {
    self.line.transform = CGAffineTransformMakeTranslation(offset, 0);
    CGFloat itemW = self.frame.size.width/self.titles.count;
    
    NSInteger currentIndex = (NSInteger)(offset/itemW);
    double scale = offset/itemW - currentIndex;
    self.selectedTag = currentIndex + 100;
    
    UIButton *currentBtn = [self viewWithTag:currentIndex + 100];
    UIButton *nextBtn = [self viewWithTag:currentIndex +101];
    
    CGFloat red = (1-scale)*(self.selectedColor.sy_red -self.normalColor.sy_red)+self.normalColor.sy_red;
    CGFloat green = (1-scale)*(self.selectedColor.sy_green -self.normalColor.sy_green)+self.normalColor.sy_green;
    CGFloat blue = (1-scale)*(self.selectedColor.sy_blue -self.normalColor.sy_blue)+self.normalColor.sy_blue;
    
    CGFloat nextRed = scale*(self.selectedColor.sy_red -self.normalColor.sy_red)+self.normalColor.sy_red;
    CGFloat nextGreen = scale*(self.selectedColor.sy_green -self.normalColor.sy_green)+self.normalColor.sy_green;
    CGFloat nextBlue = scale*(self.selectedColor.sy_blue -self.normalColor.sy_blue)+self.normalColor.sy_blue;
    
    [currentBtn setTitleColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithRed:nextRed green:nextGreen blue:nextBlue alpha:1.0] forState:UIControlStateNormal];

}

- (void)setUpUI {
    
    for (int i = 0; i< self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i+100;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat w = self.bounds.size.width/self.titles.count;
        btn.frame = CGRectMake(i*w, 0, w, self.bounds.size.height);
        
        if (i == 0) {
            [btn setTitleColor:self.selectedColor forState:UIControlStateNormal];
            self.selectedTag = btn.tag;
        }

        [self addSubview:btn];
    }
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
    bottomLine.backgroundColor = [UIColor lineDefaultColor];
    [self addSubview:bottomLine];
    
    [self addSubview:self.line];
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == self.selectedTag) {
        return;
    }else {
        UIButton *lastBtn = [self viewWithTag:self.selectedTag];
        [self exchangeStatusWithButton:sender andButton:lastBtn];
        self.selectedTag = sender.tag;
        if (self.buttonAciton) {
            self.buttonAciton(sender.tag-100);
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.transform = CGAffineTransformMakeTranslation(sender.frame.origin.x, 0);
    }];
}

- (void)exchangeStatusWithButton:(UIButton *)sender1 andButton:(UIButton *)sender2 {
    [sender1 setTitleColor:self.selectedColor forState:UIControlStateNormal];
    [sender2 setTitleColor:self.normalColor forState:UIControlStateNormal];
}

- (void)changeTitle:(NSString *)title atIndex:(NSInteger)index {
    UIButton *btn = [self viewWithTag:index + 100];
    if (btn) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

- (UIView *)line {
    if (_line == nil) {
        CGFloat w = self.bounds.size.width/self.titles.count;
        CGFloat y = self.bounds.size.height - 2;
        _line = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width/self.titles.count - w)*0.5, y, w, 2)];
        _line.backgroundColor = self.selectedColor;
    }
    return _line;
}

- (NSInteger)selectedIndex {
    return self.selectedTag - 100;
}

- (CGFloat)lineWidthWithTitle:(NSString *)title {
    return [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
}

@end
