//
//  UIColor+SYExtension.h
//  SYCategory
//
//  Created by 唐绍禹 on 16/10/13.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SYExtension)
@property (nonatomic,readonly) CGFloat sy_red;
@property (nonatomic,readonly) CGFloat sy_green;
@property (nonatomic,readonly) CGFloat sy_blue;
@property (nonatomic,readonly) CGFloat sy_alpha;

+ (UIColor *)sy_colorWithRGB:(u_int32_t)rgb;
+ (UIColor *)lineDefaultColor;
+ (UIColor *)appMainColor;
+ (UIColor *)textLightGrayColor;
@end
