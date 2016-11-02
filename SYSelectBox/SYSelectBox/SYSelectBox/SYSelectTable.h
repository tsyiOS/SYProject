//
//  SYSelectTable.h
//  SYSelectBox
//
//  Created by leju_esf on 16/11/1.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYSelectBox.h"

@interface SYSelectTable : SYSelectBox
/**
 *  初始化下拉菜单
 *
 *  @param titles    标题
 *  @param direction 方向
 *
 *  @return 下拉菜单
 */
- (instancetype)initWithDatas:(NSArray *)titles andDirection:(SYSelectBoxArrowPosition)direction;
@end
