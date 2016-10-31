//
//  ERPullDownMenu.h
//  ESFManager
//
//  Created by leju_esf on 16/5/27.
//  Copyright © 2016年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERPullDownCell.h"

typedef NS_ENUM(NSUInteger, ERPullDownMenuPointDirection) {
    ERPullDownMenuPointDirectionLeft,
    ERPullDownMenuPointDirectionRight,
    ERPullDownMenuPointDirectionTopCenter
    
};

@interface ERPullDownMenu : UIView
/**
 *  实例方法
 *
 *  @param frame        大小
 *  @param dataSrcArray 显示的数据源
 *  @param direction    箭头方向
 *
 *  @return 下拉菜单
 */
- (instancetype)initWithSize:(CGSize)size withData:(NSArray *) dataSrcArray AndDirection:(ERPullDownMenuPointDirection) direction;
- (void)showDependentOn:(UIView *)dependentView;
- (void)dismiss;
/**
 *  选项回调，index是选择的索引
 */
@property (nonatomic, strong) void(^selectedAction)(NSInteger index);
@property (nonatomic, assign) NSInteger selectedIndex;
@end
