//
//  SYCommonTool.m
//  SYCommonTool
//
//  Created by leju_esf on 16/11/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYCommonTool.h"
#import <AdSupport/AdSupport.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SYCommonTool ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy) void (^imagePickCompletion)(UIImage *image);
@property (nonatomic, assign) BOOL isCalling;
@end

@implementation SYCommonTool

static SYCommonTool *instance;
+ (instancetype)shareCommonTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SYCommonTool alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark - 应用信息
/**
 *  当前应用版本号
 *
 *  @return 应用版本号
 */
+ (NSString *)sy_AppBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

#pragma mark - 设备信息
/**
 *  设备信息
 *
 *  @return 设备唯一标识符
 */
+ (NSString *)sy_UUID {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (void)sy_openAppSystemSetting {
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    if ([phoneVersion integerValue] >= 10) {
        NSString *appId = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"App-Prefs:root=%@", appId]];
        [[UIApplication sharedApplication] openURL:setUrl];
    }else {
        NSString *appId = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIdentifier"];
        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@", appId]];
        [[UIApplication sharedApplication] openURL:setUrl];
    }
}

#pragma mark - 校验信息
/**
 *  判断手机号正确性
 *
 *  @param mobileNum 手机号码
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkMobileNumber:(NSString *)mobile {
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }

}

/**
 *  判断是否为汉字
 *
 *  @param textStr 待验证文字
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkChineseText:(NSString *)textStr {
    BOOL isRight;
    NSString *ChineseCheck = @"[\u4E00-\u9FFF]+";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ChineseCheck];
    
    if ([regextestmobile evaluateWithObject:textStr]) {
        if (textStr.length < 2 || textStr.length > 11) {
            isRight = NO;
        } else {
            isRight = YES;
        }
    } else {
        isRight = NO;
    }
    
    return isRight;
}

/**
 *  判断是否为汉字 英文 数字
 *
 *  @param textStr 待验证文字
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkChineseOrEnglishText:(NSString *)textStr {
    BOOL isRight;
    NSString *ChineseEnglishCheck = @"[a-zA-Z0-9\u4E00-\u9FFF-_]+";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ChineseEnglishCheck];
    
    if ([regextestmobile evaluateWithObject:textStr]) {
        isRight = YES;
    } else {
        isRight = NO;
    }
    
    return isRight;
}

/**
 *  只能输入数字或两位小数
 *
 *  @param number 数字
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkTwoPointNumber:(NSString *)number {
    
    NSString *regex = @"^\\d+(\\.\\d{0,2})?$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regextestmobile evaluateWithObject:number];
}

+ (NSString *)sy_encryptMobileNumber:(NSString *)mobile {
    if ([self sy_checkMobileNumber:mobile]) {
        NSString *userTitle1 = [mobile substringToIndex:3];
        NSString *userTitle2 = [mobile substringFromIndex:7];
        return [NSString stringWithFormat:@"%@****%@",userTitle1,userTitle2];
    }else {
        return mobile;
    }
}

#pragma mark - 提示信息
/*
 UIAlertActionStyleDefault = 0,
 UIAlertActionStyleCancel,
 UIAlertActionStyleDestructive
 */

+ (void)sy_showNotice:(NSString *)message completion:(void (^ __nullable)(UIAlertAction *action))completion {
    [self sy_showNoticeWithTitle:nil message:message completion:completion];
}

+ (void)sy_showNoticeWithTitle:(NSString *)title message:(NSString *)message completion:(void (^ __nullable)(UIAlertAction *action))completion {
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertvc addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:completion];
    [alertvc addAction:action2];
    [[self getCurrentViewController] presentViewController:alertvc animated:YES completion:nil];
}

+ (void)sy_showErrorWithMessage:(NSString *)message {
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alertvc addAction:action];
    [[self getCurrentViewController] presentViewController:alertvc animated:YES completion:nil];
}

+ (void)sy_callWithPhoneNumber:(NSString *)phone {
    [self sy_callWithPhoneNumber:phone andTitle:@"呼叫"];
}

+ (void)sy_callWithPhoneNumber:(NSString *)phone andTitle:(NSString *)title {
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    if ([SYCommonTool shareCommonTool].isCalling == YES) {
        return;
    }else {
        [SYCommonTool shareCommonTool].isCalling = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SYCommonTool shareCommonTool].isCalling = NO;
        });
    }
    if ([phoneVersion integerValue] >= 10) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://+86%@",phone]]];
    }else {
        [self sy_showNoticeWithTitle:title message:phone completion:^(UIAlertAction *action){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://+86%@",phone]]];
        }];
    }
}

+ (UIImage *)sy_screenShotImageByView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (void)sy_openCameraTakePhoto:(void (^)(UIImage *))completion {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您没有设置权限访问相机，请去设置->隐私进行设置！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alertView show];
        
        [SYCommonTool sy_showNotice:@"您没有设置权限访问相机，请去设置->隐私进行设置！" completion:^(UIAlertAction *action){
            [SYCommonTool sy_openAppSystemSetting];
        }];
        
    }else{
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        self.imagePickCompletion = completion;
        [[SYCommonTool getCurrentViewController] presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)sy_openPhotoPicker:(void (^)(UIImage *))completion {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您没有设置权限访问相册，请去设置->隐私进行设置！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alertView show];
        [SYCommonTool sy_showNotice:@"您没有设置权限访问相册，请去设置->隐私进行设置！" completion:^(UIAlertAction *action){
            [SYCommonTool sy_openAppSystemSetting];
        }];
    }else {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        self.imagePickCompletion = completion;
        [[SYCommonTool getCurrentViewController] presentViewController:ipc animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (self.imagePickCompletion) {
        self.imagePickCompletion(image);
    }
    self.imagePickCompletion = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    self.imagePickCompletion = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

+ (UIViewController *)getCurrentViewController {
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBar = (UITabBarController *)result;
        UIViewController *baseVc = tabBar.selectedViewController;
        if ([baseVc isKindOfClass:[UINavigationController class]]) {
            return baseVc.childViewControllers.lastObject;
        }else {
            return baseVc;
        }
    }else {
        return result;
    }
}

@end
