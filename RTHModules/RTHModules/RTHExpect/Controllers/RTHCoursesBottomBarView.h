//
//  RTHCoursesBottomBarView.h
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/28.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RTHCoursesBottomClickType) {
    RTHCoursesBottomClickTypeDownLoad = 0,
    RTHCoursesBottomClickTypeCollection,
    RTHCoursesBottomClickTypeShare,
    RTHCoursesBottomClickTypeReward
};

@class RTHCoursesButton;
@interface RTHCoursesBottomBarView : UIView
@property (nonatomic, strong) RTHCoursesButton *collectionBtn;
@property (nonatomic, copy) void (^bottomBtnClick)(RTHCoursesBottomClickType type);
- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andImageNames:(NSArray *)images;
@end

@interface RTHCoursesButton : UIControl
@property (nonatomic, assign) BOOL btnSelected;
- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andImageName:(NSString *)image;
@end