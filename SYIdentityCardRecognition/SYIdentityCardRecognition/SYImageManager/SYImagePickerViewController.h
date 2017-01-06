//
//  SYImagePickerViewController.h
//  SYImagePicker
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol SYImagePickerDelegate <NSObject>

@required
/**
 * 点击完成后选择的照片回调，@{SYSelectedImages:选择的图片数组(小图),SYSelectedAssets:选择图片的Assets数组}
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
/**
 *  一次性最多选择的张数
 */
@property (nonatomic, assign) NSInteger sy_maxCount;

@property (nonatomic, weak) id <SYImagePickerDelegate>delegate;
@end

extern NSString *const SYSelectedImages;

extern NSString *const SYSelectedAssets;

