//
//  RTHCicleDynamicHeaderView.m
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/13.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHCicleDynamicHeaderView.h"

@implementation RTHCicleDynamicHeaderView

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

@end
