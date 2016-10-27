//
//  RTHImageContentView.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/9/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHImageContentView.h"

#define itemMargin 4
#define itemW ([UIScreen mainScreen].bounds.size.width - 88 - itemMargin * 2)/3

@interface RTHImageContentView ()

@end

@implementation RTHImageContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor redColor];
        imageView.tag = 1000+i;
        [self addSubview:imageView];
    }
}

- (CGFloat)setUpImages:(NSInteger)count {
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [self viewWithTag:1000+i];
        imageView.frame = CGRectZero;
    }
    
    if (count == 0) {
        return 0;
    }else if(count == 1) {
        UIImageView *imageView = [self viewWithTag:1000];
        imageView.frame = CGRectMake(0, 0, 192, 192);
        return 192;
    }else if(count == 4) {
        for (int i = 0; i < count; i++) {
            NSInteger col = i % 2;
            NSInteger row = i / 2;
            UIImageView *imageView = [self viewWithTag:1000+i];
            imageView.frame = CGRectMake(col*(itemW+itemMargin),row*(itemW+itemMargin), itemW, itemW);
        }
        return 2*itemW + itemMargin;
    }else {
        
        for (int i = 0; i < count; i++) {
            NSInteger col = i % 3;
            NSInteger row = i / 3;
            UIImageView *imageView = [self viewWithTag:1000+i];
            if (imageView != nil) {
                imageView.frame = CGRectMake(col*(itemW+itemMargin),row*(itemW+itemMargin), itemW, itemW);
            }
        }
        
        return ((count-1)/3 + 1 )*itemW+((count-1)/3)*itemMargin;
    }
}

@end
