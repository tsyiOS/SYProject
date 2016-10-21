//
//  SYImagePickerRootViewController.m
//
//  Created by 唐绍禹 on 16/2/26.
//  Copyright © 2016年 tsy. All rights reserved.

#import <UIKit/UIKit.h>

@interface SYBottomView : UIView

@property (nonatomic, assign) NSInteger selectedNumber;
/**
 *  选择完成照片后的Block回调
 */
@property (nonatomic, copy) void (^finishedChooseImages)();
/**
 *  允许选择完成照片后裁剪的Block回调，
 */
@property (nonatomic, copy) void (^finishedChooseImagesAndAllowsEditing)();
/**
 *  预览选择照片的Block回调
 */
@property (nonatomic, copy) void (^previewSelectedImages)();
/**
 *  选择照片后是否编辑
 */
@property (nonatomic, assign) BOOL allowsEditing;
@end
