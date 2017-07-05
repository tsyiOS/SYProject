//
//  SYDatePicker.m
//  SYDatePicker
//
//  Created by leju_esf on 16/7/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYDatePickerTool.h"

@interface SYDatePickerTool ()
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *pickerViewToolbar;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *shadow;
@end

@implementation SYDatePickerTool
- (instancetype)initWithDatePickerMode:(UIDatePickerMode)mode {
    if (self = [super init]) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = mode;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    }
    return self;
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = maximumDate;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = minimumDate;
}

- (void)doneBtnClick {
    if (self.doneAction) {
        self.doneAction(self.datePicker.date);
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
    [self.textField removeFromSuperview];
    [self.shadow removeFromSuperview];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self.shadow];
    [[UIApplication sharedApplication].keyWindow addSubview:self.textField];
    [self.textField becomeFirstResponder];
}

#pragma mark - 懒加载

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.inputAccessoryView = self.pickerViewToolbar;
        _textField.inputView = self.datePicker;
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
