//
//  SYAlertView.h
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/5.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@class SYIdentityModel;
@interface SYAlertView : UIView
+ (instancetype) alertViewWithModel:(SYIdentityModel *)model andComplete:(void(^)())completion;
- (void)show;
@end
