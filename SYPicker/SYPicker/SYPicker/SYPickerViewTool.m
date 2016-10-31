//
//  SYPickerViewTool.m
//  SYDatePicker
//
//  Created by leju_esf on 16/7/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYPickerViewTool.h"

@interface SYPickerViewTool ()
@property (nonatomic, strong) UIToolbar *pickerViewToolbar;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *shadow;
@end

@implementation SYPickerViewTool

- (void)doneBtnClick {
    if (self.doneAction) {
        self.doneAction();
    }
    [self dismiss];
}
- (void)cancelBtnClick {
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self dismiss];
}

- (void)dismiss {
    [self.textField resignFirstResponder];
    [self.shadow removeFromSuperview];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self.shadow];
    [[UIApplication sharedApplication].keyWindow addSubview:self.textField];
    [self.textField becomeFirstResponder];
}

#pragma mark - 懒加载
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self.delegate;
        _pickerView.delegate = self.delegate;
    }
    return _pickerView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.inputAccessoryView = self.pickerViewToolbar;
        _textField.inputView = self.pickerView;
    }
    return _textField;
}

- (UIView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _shadow.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnClick)];
        [_shadow addGestureRecognizer:tap];
    }
    return _shadow;
}

- (UIToolbar *)pickerViewToolbar {
    if (_pickerViewToolbar == nil) {
        _pickerViewToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _pickerViewToolbar.barStyle = UIBarStyleDefault;
        _pickerViewToolbar.backgroundColor = [UIColor whiteColor];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneBtnClick)];
        [doneButton setTintColor:[UIColor blackColor]];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick)];
        [cancelButton setTintColor:[UIColor blackColor]];
        [_pickerViewToolbar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    }
    return _pickerViewToolbar;
}
@end
