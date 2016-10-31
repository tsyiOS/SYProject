//
//  SYPickerViewTool.h
//  SYDatePicker
//
//  Created by leju_esf on 16/7/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYPickerViewTool : NSObject
/**
 *  点击完成后的回调
 */
@property (nonatomic, copy) void (^doneAction)();
/**
 *  点击取消后的回调
 */
@property (nonatomic, copy) void (^cancelAction)();
/**
 *  选择pickerView
 */
@property (nonatomic, strong) UIPickerView *pickerView;
/**
 *  代理
 */
@property (nonatomic, weak) id<UIPickerViewDataSource,UIPickerViewDelegate>delegate;
/**
 *  从底部弹起
 */
- (void)show;
@end
