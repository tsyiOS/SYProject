//
//  SYImagePicker.h
//  SYImagePicker
//
//  Created by leju_esf on 16/10/26.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYImagePickerViewController.h"

@interface SYImageManager : NSObject
/**
 *  设置当前控制器为manager的代理
 */
@property (nonatomic, weak) UIViewController <SYImagePickerDelegate>*delegate;
/**
 *  实例方法
 *
 *  @return 相册拍照manager管理拍照和去相册
 */
+ (instancetype)shareImageManager;
/**
 *  打开相机
 */
- (void)sy_OpenImagePicker;
/**
 *  打开相册
 */
- (void)sy_OpenCamera;
@end
