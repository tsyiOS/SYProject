//
//  SYImageEditViewController.h
//  SYImageManager
//
//  Created by leju_esf on 16/11/4.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYImageEditDelegate <NSObject>

@required
- (void)sy_didFinishedEditingPhoto:(UIImage *)image;

@end

@interface SYImageEditViewController : UIViewController
/**
 * 导航栏的背景颜色
 */
@property (nonatomic, strong) UIColor *sy_barTintColor;
/**
 * 导航栏的标题颜色
 */
@property (nonatomic, strong) UIColor *sy_tintColor;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGSize clipSize;
@property (nonatomic, weak) id<SYImageEditDelegate> delegate;
@end

@interface SYImageMaskView : UIView
/**
 *  裁剪的区域大小
 */
@property (nonatomic, assign) CGSize clipSize;
@end
