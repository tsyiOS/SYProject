//
//  SYImageRenderViewController.h
//  SYImageManager
//
//  Created by leju_esf on 16/11/7.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYImageRenderViewController : UIViewController
/**
 * 导航栏的背景颜色
 */
@property (nonatomic, strong) UIColor *sy_barTintColor;
/**
 * 导航栏的标题颜色
 */
@property (nonatomic, strong) UIColor *sy_tintColor;
/**
 *  渲染的图片
 */
@property (nonatomic, strong) UIImage *image;
@end


@interface SYImageRenderCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end