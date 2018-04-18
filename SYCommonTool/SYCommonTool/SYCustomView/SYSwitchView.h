//
//  SYSwitchView.h
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/18.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYSwitchView : UIView
@property (nonatomic, copy) void(^touchAction)(NSInteger index);
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, assign) NSInteger selectedIndex;
@end
