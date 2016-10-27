//
//  SYSlideSelectedView.h
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/6/19.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface SYSlideSelectedView : UIView
@property (nonatomic, assign,readonly) NSInteger selectedIndex;
@property (nonatomic, copy) void(^buttonAciton)(NSInteger tag);
@property (nonatomic, strong,readonly) NSArray *titles;
- (instancetype)initWithTitles:(NSArray *)titles frame:(CGRect)frame normalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor;
- (void)slideLineOffset:(CGFloat)offset;
- (void)changeTitle:(NSString *)title atIndex:(NSInteger)index;
@end
