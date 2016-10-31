//
//  SYDatePicker.h
//  SYDatePicker
//
//  Created by leju_esf on 16/7/18.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYDatePickerTool: NSObject
/**
 *  点击完成后的回调
 */
@property (nonatomic, copy) void (^doneAction)(NSDate *date);
/**
 *  点击取消后的回调
 */
@property (nonatomic, copy) void (^cancelAction)();
/**
 *  最小滚动时间范围
 */
@property (nonatomic, strong) NSDate *minimumDate;
/**
 *  最大滚动时间范围
 */
@property (nonatomic, strong) NSDate *maximumDate;
/**
 *  实例化方法
 *
 *  @param mode datepicker 的类型
 *
 *  @return SYDatePickerTool 对象
 */
- (instancetype)initWithDatePickerMode:(UIDatePickerMode)mode;
/**
 *  从底部弹起
 */
- (void)show;
@end
