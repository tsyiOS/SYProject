//
//  SYCommonTool.m
//  SYCommonTool
//
//  Created by leju_esf on 16/11/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYCommonTool.h"
#import <AdSupport/AdSupport.h>

@interface SYCommonTool ()<UIAlertViewDelegate>
@property (nonatomic, copy) void(^completion)();
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

#pragma mark - 提示信息
- (void)sy_showNotice:(NSString *)message completion:(void (^)())completion{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.completion = completion;
    alertView.tag = 1000;
    [alertView show];
}

+ (void)sy_showErrorWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)sy_callWithPhoneNumber:(NSString *)phone {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"呼叫" message:phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 1001;
    alertView.delegate = [SYCommonTool shareCommonTool];
    [alertView show];
}

- (void)sy_callWithPhoneNumber:(NSString *)phone andTitle:(NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 1001;
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.tag == 1001) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",alertView.message]]];
        }else if (alertView.tag == 1000){
            if (self.completion) {
                self.completion();
            }
        }
    }
}

+ (UIImage *)sy_screenShotImageByView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
