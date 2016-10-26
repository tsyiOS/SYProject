//
//  SYImagePicker.m
//  SYImagePicker
//
//  Created by leju_esf on 16/10/26.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+SYExtension.h"

typedef NS_ENUM(NSUInteger, SYImageManagerType) {
    SYImageManagerTypePhoto,
    SYImageManagerTypeCamera
};

@interface SYImageManager ()<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation SYImageManager

static SYImageManager *manager;
+ (instancetype)shareImageManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SYImageManager alloc] init];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

- (void)setDelegate:(UIViewController <SYImagePickerDelegate>*)delegate {
    _delegate = delegate;
    _imagePicker = [[SYImagePickerViewController alloc] init];
    _imagePicker.delegate = delegate;
}
/*
 ALAuthorizationStatusNotDetermined = 0, 用户尚未做出了选择这个应用程序的问候
 ALAuthorizationStatusRestricted,        此应用程序没有被授权访问的照片数据。可能是家长控制权限。
 ALAuthorizationStatusDenied,            用户已经明确否认了这一照片数据的应用程序访问.
 ALAuthorizationStatusAuthorized         用户已授权应用访问照片数据.
 */

- (void)sy_OpenImagePicker {
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied) {
        [self showErrorWithType:SYImageManagerTypePhoto];
    }else {
        [self.delegate presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

- (void)sy_OpenCamera {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied) {
        [self showErrorWithType:SYImageManagerTypeCamera];
    }else {
        if (TARGET_IPHONE_SIMULATOR) {
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"请使用真机调试" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
            [alertview show];
        }else {
            UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
            pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerVC.delegate = self;
            [self.delegate presentViewController:pickerVC animated:NO completion:nil];
            return;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    image = [image sy_erected];
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    [self.delegate sy_didFinishedPickingMediaWithInfo:@{SYSelectedImages:@[image],SYSelectedAssets:@[]}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)showErrorWithType:(SYImageManagerType)type {
    NSString *message = [NSString stringWithFormat:@"您没有设置权限访问%@，请去设置->隐私进行设置！" ,type ==SYImageManagerTypePhoto?@"相册":@"相机"];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *appId = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@", appId ]];
        [[UIApplication sharedApplication] openURL:setUrl];
    }
}

@end
