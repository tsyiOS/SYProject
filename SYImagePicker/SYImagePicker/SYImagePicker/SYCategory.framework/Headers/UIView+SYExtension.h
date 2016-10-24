//
//  UIView+SYExtension.h
//  SYCategory
//
//  Created by 唐绍禹 on 16/10/13.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface UIView (SYExtension)
@property (nonatomic) CGFloat sy_x;

@property (nonatomic) CGFloat sy_y;

@property (nonatomic) CGFloat sy_left;

@property (nonatomic) CGFloat sy_top;

@property (nonatomic) CGFloat sy_right;

@property (nonatomic) CGFloat sy_bottom;

@property (nonatomic) CGFloat sy_width;

@property (nonatomic) CGFloat sy_height;

@property (nonatomic) CGFloat sy_centerX;

@property (nonatomic) CGFloat sy_centerY;

@property (nonatomic) CGPoint sy_origin;

@property (nonatomic) CGSize sy_size;
@end
