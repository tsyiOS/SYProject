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
@property (nonatomic, strong) SYImagePickerViewController *imagePicker;
@property (nonatomic, weak) UIViewController <SYImagePickerDelegate>*delegate;
+ (instancetype)shareImageManager;
- (void)sy_OpenImagePicker;
- (void)sy_OpenCamera;
@end
