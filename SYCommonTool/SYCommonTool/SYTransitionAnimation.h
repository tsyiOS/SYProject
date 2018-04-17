//
//  SYTransitionAnimation.h
//  SYCommonTool
//
//  Created by leju_esf on 2018/4/17.
//  Copyright © 2018年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 转场动画类型

 - SYAnimationTypePresent: 底部弹起
 - SYAnimationTypeDismiss: 消失
 */
typedef NS_ENUM(NSUInteger, SYAnimationType) {
    SYAnimationTypePresent,
    SYAnimationTypeDismiss
};

@interface SYTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SYAnimationType animationType;

@property (nonatomic, strong) UIView *shadow;

@end
