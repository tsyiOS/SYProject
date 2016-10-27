//
//  NSAttributedString+SYExtension.h
//  SYSlideDemo
//
//  Created by leju_esf on 16/10/9.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (SYExtension)
- (CGSize)sy_sizeWithLabelWidth:(CGFloat)width;
- (CGSize)sy_sizeOnSingleRow;
@end
