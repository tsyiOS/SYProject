//
//  SYSelectBox.h
//  SYSelectBox
//
//  Created by leju_esf on 16/10/31.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYSelectBoxArrowPosition) {
    SYSelectBoxArrowPositionLeft,
    SYSelectBoxArrowPositionRight,
    SYSelectBoxArrowPositionCenter
    
};

@interface SYSelectBox : UIView
/**
 *  实例方法
 *
 *  @param frame        大小
 *  @param dataSrcArray 显示的数据源
 *  @param direction    箭头方向
 *
 *  @return 下拉菜单
 */
- (instancetype)initWithSize:(CGSize)size direction:(SYSelectBoxArrowPosition) position andCustomView:(UIView *)customView;
- (void)showDependentOn:(UIView *)dependentView;
@end
