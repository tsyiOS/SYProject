//
//  UIImage+SYExtension.h
//  SYCategory
//
//  Created by 唐绍禹 on 16/10/26.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYExtension)
/**
 *  将图片压缩到指定大小
 *
 *  @param size  指定大小
 *
 *  @return 压缩后的图片
 */
- (UIImage *)sy_scaleToSize:(CGSize)size;
/**
 *  将图片按照指定尺寸剪切
 *
 *  @param rect  指定尺寸和起始位置
 *
 *  @return 剪切后的图片
 */
- (UIImage *)sy_clipByRect:(CGRect)rect;
/**
 *  将图片旋转成正立图片
 *
 *  @return 旋转后的图片
 */
- (UIImage *)sy_erected;
@end
