//
//  SYAuthCodeButton.h
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYAuthCodeButton : UIButton
/**
 倒计时时长
 */
@property (nonatomic, assign) NSInteger totalCount;
/**
 剩余时长
 */
@property (nonatomic, assign) NSInteger lastCount;
/**
 发送验证码回调
 */
@property (nonatomic, copy) void(^sendCodeAction)(void);
/**
 按钮高亮颜色
 */
@property (nonatomic, strong) UIColor *hightLightColor;
/**
 是否可点
 */
@property (nonatomic, assign) BOOL active;
/**
 停止计时
 */
- (void)stopTimer;
@end
