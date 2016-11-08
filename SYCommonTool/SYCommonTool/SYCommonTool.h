//
//  SYCommonTool.h
//  SYCommonTool
//
//  Created by leju_esf on 16/11/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYCommonTool : NSObject
/**
 *  实例化对象
 *
 *  @return 常用工具单例
 */
+ (instancetype)shareCommonTool;

#pragma mark - 应用信息
/**
 *  当前应用版本号
 *
 *  @return 应用版本号
 */
+ (NSString *)sy_AppBuild;

#pragma mark - 设备信息
/**
 *  设备信息
 *
 *  @return 设备唯一标识符
 */
+ (NSString *)sy_UUID;


#pragma mark - 校验信息
/**
 *  判断手机号正确性
 *
 *  @param mobileNum 手机号码
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkMobileNumber:(NSString *)mobileNum;

/**
 *  判断是否为汉字
 *
 *  @param textStr 待验证文字
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkChineseText:(NSString *)textStr;

/**
 *  判断是否为汉字 英文 数字 组合
 *
 *  @param textStr 待验证文字
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkChineseOrEnglishText:(NSString *)textStr;

/**
 *  只能输入数字或两位小数
 *
 *  @param number 数字
 *
 *  @return YES：正确 NO：错误
 */
+ (BOOL)sy_checkTwoPointNumber:(NSString *)number;

#pragma mark - 提示信息
/**
 *  提示信息
 *
 *  @param message    信息
 *  @param completion 完成回调
 */
- (void)sy_showNotice:(NSString *)message completion:(void (^)())completion;
/**
 *  提示错误信息
 *
 *  @param message 错误信息
 */
+ (void)sy_showErrorWithMessage:(NSString *)message;
/**
 *  打电话
 *
 *  @param phone 电话号码
 */
+ (void)sy_callWithPhoneNumber:(NSString *)phone;
/**
 *  打电话
 *
 *  @param phone 电话号码
 *  @param title 标题
 */
- (void)sy_callWithPhoneNumber:(NSString *)phone andTitle:(NSString *)title;

#pragma mark - 截图
/**
 *  截取某个view上的图像
 *
 *  @param view 被截view
 *
 *  @return 截图
 */
+ (UIImage *)sy_screenShotImageByView:(UIView *)view;
@end
