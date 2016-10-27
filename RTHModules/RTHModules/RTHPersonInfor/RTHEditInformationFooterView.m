//
//  RTHEditInformationFooterView.m
//  RTHModules
//
//  Created by leju_esf on 16/10/27.
//  Copyright © 2016年 唐绍禹. All rights reserved.
//

#import "RTHEditInformationFooterView.h"

@implementation RTHEditInformationFooterView

+ (instancetype)viewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

@end
