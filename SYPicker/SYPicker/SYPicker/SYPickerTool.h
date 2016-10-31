//
//  SYPickerTool.h
//  SYPicker
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYPickerTool : NSObject
/**
 *  点击完成后的回调
 */
@property (nonatomic, copy) void (^doneAction)(NSInteger selectedIndex,NSString *selectedString);
/**
 *  点击取消后的回调
 */
@property (nonatomic, copy) void (^cancelAction)();
/**
 *  数据源，字符串数组
 */
@property (nonatomic, strong) NSArray *dataSource;
/**
 *  从底部弹起
 */
- (void)show;
@end
