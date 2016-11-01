//
//  SYBezierModel.h
//  SYSelectBox
//
//  Created by leju_esf on 16/11/1.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYBezierDrawType) {
    SYBezierDrawTypeStart,
    SYBezierDrawTypeLine,
    SYBezierDrawTypeCurve
};

@interface SYBezierModel : NSObject
@property (nonatomic, assign) CGPoint point;
/**
 *  基准点，画曲线时候用
 */
@property (nonatomic, assign) CGPoint controlPoint;
@property (nonatomic, assign) SYBezierDrawType type;
- (instancetype)initWithPoint:(CGPoint)point controlPoint:(CGPoint)control andDrawType:(SYBezierDrawType)type;
@end
