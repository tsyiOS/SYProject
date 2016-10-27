//
//  RTHExpertTagsView.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/9/25.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHExpertTagsView.h"

#define LABEL_MARGIN 13.0f

@implementation RTHExpertTagsView

- (void)setTags:(NSArray *)tags {
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }

    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    for (NSString *text in tags) {
        CGSize textSize = [self sizeWithFont:[UIFont systemFontOfSize:12] andString:text];
        textSize.width += 20;
        textSize.height += 8;
        UILabel *tagLabel = [self getTagWithText:text];
        if (!gotPreviousFrame) {
            tagLabel.frame = CGRectMake(0, (self.frame.size.height - textSize.height)*0.5, textSize.width, textSize.height);
 
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN <= self.frame.size.width) {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            } else {
                break;
            }
            newRect.size = textSize;
            tagLabel.frame = newRect;
        }
        previousFrame = tagLabel.frame;
        gotPreviousFrame = YES;
        [self addSubview:tagLabel];
    }
}

- (UILabel  *)getTagWithText:(NSString *)text {
    UILabel *markLabel = [[UILabel alloc] init];
    markLabel.textColor = [UIColor sy_colorWithRGB:0x272727];
    markLabel.layer.borderColor = [UIColor sy_colorWithRGB:0x272727].CGColor;
    markLabel.layer.borderWidth = 0.5;
    markLabel.layer.cornerRadius = 5;
    markLabel.clipsToBounds = YES;
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.font = [UIFont systemFontOfSize:12];
    markLabel.text = text;
    return markLabel;
}

- (CGSize)sizeWithFont:(UIFont *)font andString:(NSString *)string{
    return [string sizeWithAttributes:@{NSFontAttributeName:font}];
}

@end
