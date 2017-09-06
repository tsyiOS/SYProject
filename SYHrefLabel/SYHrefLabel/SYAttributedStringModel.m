//
//  SYAttributedStringModel.m
//  SYAttributedString
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYAttributedStringModel.h"

@interface SYAttributedStringModel ()
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *string;
@end

@implementation SYAttributedStringModel
- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string {
    if (self = [super init]) {
        self.font = font;
        self.color = color;
        self.string = string;
    }
    return self;
}

+ (instancetype)attributedStringModelWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string {
    return [[self alloc] initWithFont:font Color:color String:string];
}

- (NSAttributedString *)attributedString {
    return [[NSAttributedString alloc] initWithString:self.string attributes:@{NSForegroundColorAttributeName:self.color,NSFontAttributeName:self.font}];
}

+ (NSMutableAttributedString *)sy_setPartString:(NSString *)partString WithFontSize:(CGFloat)fontSize Color:(UIColor *)color inString:(id)string;{
    return  [self sy_setPartString:partString WithFont:[UIFont systemFontOfSize:fontSize] Color:color inString:string];
}

+ (NSMutableAttributedString *)sy_setPartString:(NSString *)partString WithFont:(UIFont *)font Color:(UIColor *)color inString:(id)string; {
    NSMutableAttributedString *attributeStr;
    if ([string isKindOfClass:[NSString class]]) {
        attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    }else if ([string isKindOfClass:[NSAttributedString class]]) {
        attributeStr = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    }else {
        return nil;
    }
    
    if (partString.length == 0 || attributeStr.length == 0) {
        return nil;
    }
    NSRange range = [attributeStr.string rangeOfString:partString];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributeStr addAttribute:NSFontAttributeName value:font range:range];
    return attributeStr;
}

+ (NSAttributedString *)sy_attributedStringWithModels:(NSArray <SYAttributedStringModel *>*)models {
    if (models.count == 0) {
        return nil;
    }
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] init];
    for (SYAttributedStringModel *model in models) {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:model.string attributes:@{NSForegroundColorAttributeName:model.color,NSFontAttributeName:model.font}];
        [attriStr appendAttributedString:str];
    }
    
    return attriStr;
}

+ (NSAttributedString *)sy_attributedStringWithModels:(NSArray <SYAttributedStringModel *>*)models andHeightMultiple:(CGFloat)multiple {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self sy_attributedStringWithModels:models]];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineHeightMultiple = multiple;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    return attriStr;
}

+ (NSAttributedString *)sy_attributedStringWithModels:(NSArray <SYAttributedStringModel *>*)models andLineHeight:(CGFloat)lineHeight {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self sy_attributedStringWithModels:models]];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = lineHeight;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    return attriStr;
    
}

+ (NSAttributedString *)sy_attributedStringWithString:(NSString *)string andHeigthMultiple:(CGFloat)multiple {
    if (string == nil) {
        return nil;
    }else {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineHeightMultiple = multiple;
        [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
        return attriStr;
    }
}

+ (NSAttributedString *)sy_attributedStringWithString:(NSString *)string andLineHeight:(CGFloat)lineHeight {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = lineHeight;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    return attriStr;
}

@end
