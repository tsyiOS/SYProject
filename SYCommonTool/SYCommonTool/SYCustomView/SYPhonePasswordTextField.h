//
//  SYPhonePasswordTextField.h
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 输入框类型

 - SYTextFieldTypePhoneNumber: 手机号输入
 - SYTextFieldTypePassword: 密码输入
 - SYTextFieldTypeCode: 验证码输入
 */
typedef NS_ENUM(NSUInteger, SYTextFieldType) {
    SYTextFieldTypePhoneNumber = 1,
    SYTextFieldTypePassword,
    SYTextFieldTypeCode
};

@interface SYPhonePasswordTextField : UITextField
@property (nonatomic, assign) SYTextFieldType type;
@property (nonatomic, assign) NSInteger codeLength;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, copy) void(^textChange)(BOOL status);
@end
