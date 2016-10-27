//
//  NSString+SYExtension.h
//  SYSlideDemo
//
//  Created by leju_esf on 16/9/29.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SYExtension)
- (CGSize)sy_sizeOnSingleRowWithFont:(CGFloat)font;
- (CGSize)sy_sizeWithLabelWidth:(CGFloat)width andFont:(CGFloat)font;
@end
