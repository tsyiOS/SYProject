//
//  SYPhonePasswordTextField.m
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import "SYPhonePasswordTextField.h"
#import "SYCommonTool.h"

@interface SYPhonePasswordTextField () <UITextFieldDelegate>

@end

@implementation SYPhonePasswordTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    _codeLength = 6;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        _codeLength = 6;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)textDidChange {
    __weak typeof(self) weakSelf = self;
    if (self.textChange) {
        self.textChange(weakSelf.checked);
    }
}

- (BOOL)checked {
    BOOL status = NO;
    if (self.type == SYTextFieldTypePhoneNumber) {
        if (self.text.length >= 12) {
            self.text = [self.text substringToIndex:11];
        }
        status = [SYCommonTool sy_checkMobileNumber:self.text];
    }else if (self.type == SYTextFieldTypeCode) {
        status = self.text.length >= self.codeLength;
    }else if (self.type == SYTextFieldTypePassword) {
        status = self.text.length >= self.codeLength;
    }
    _checked = status;
    return _checked;
}

- (void)setType:(SYTextFieldType)type {
    _type = type;
    if (type == SYTextFieldTypePhoneNumber||type == SYTextFieldTypeCode) {
        self.keyboardType = UIKeyboardTypePhonePad;
    }else if (type == SYTextFieldTypePassword) {
        self.keyboardType = UIKeyboardTypeDefault;
        self.secureTextEntry = YES;
    }
}

#pragma mark - textField的代理方法，不让输入小数点和文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.type == SYTextFieldTypePhoneNumber || self.type == SYTextFieldTypeCode) {
        if ([string isEqualToString:@"."] || ![self validateNumber:string]) {
            return NO;
        }
        return YES;
    }else {
        return YES;
    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


@end
