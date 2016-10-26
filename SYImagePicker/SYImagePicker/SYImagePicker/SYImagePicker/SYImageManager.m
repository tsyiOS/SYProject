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

- (void)sy_OpenImagePicker {
     ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusAuthorized) {
        [self.delegate presentViewController:self.imagePicker animated:YES completion:nil];
    }else {
         [self showErrorWithType:SYImageManagerTypePhoto];
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
    
    image = [self fixOrientationWithImage:image];
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    [self.delegate sy_didFinishedPickingMediaWithInfo:@{SYSelectedImages:@[image],SYSelectedAssets:@[]}];
}

- (UIImage *)fixOrientationWithImage:(UIImage *)image {

    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
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
