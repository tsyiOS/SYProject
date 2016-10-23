//
//  SYImagePickerViewController.h
//  SYImagePicker
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYImagePickerControllerDelegate <NSObject>

@required
/**
 * 点击完成后选择的照片回调
 */
- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info;

@end


@interface SYImagePickerViewController : UIViewController
/**
 * 导航栏的背景颜色
 */
@property (nonatomic, strong) UIColor *sy_barTintColor;
/**
 * 导航栏的标题颜色
 */
@property (nonatomic, strong) UIColor *sy_tintColor;
/**
 *  行间距
 */
@property (nonatomic, assign) CGFloat sy_lineSpacing;
/**
 *  列间距
 */
@property (nonatomic, assign) CGFloat sy_rowSpacing;
/**
 *  列数
 */
@property (nonatomic, assign) NSInteger sy_columns;


@property (nonatomic, weak) id <SYImagePickerControllerDelegate>delegate;
@end

extern NSString *const SYSelectedImages;

extern NSString *const SYSelectedAssets;