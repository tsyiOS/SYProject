//
//  SYBezierModel.m
//  SYSelectBox
//
//  Created by leju_esf on 16/11/1.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYBezierModel.h"


@implementation SYBezierModel

- (instancetype)initWithPoint:(CGPoint)point controlPoint:(CGPoint)control andDrawType:(SYBezierDrawType)type {
    if (self = [super init]) {
        self.point = point;
        self.controlPoint = control;
        self.type = type;
    }
    return self;
}

@end
