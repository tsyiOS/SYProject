//
//  SYAuthCodeButton.h
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYAuthCodeButton : UIButton
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger lastCount;
@property (nonatomic, copy) void(^sendCodeAction)();
@property (nonatomic, strong) UIColor *hightLightColor;
@property (nonatomic, assign) BOOL active;
- (void)stopTimer;
@end
