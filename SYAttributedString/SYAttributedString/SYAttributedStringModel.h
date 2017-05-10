//
//  SYAttributedStringModel.h
//  SYAttributedString
//
//  Created by leju_esf on 16/10/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYAttributedStringModel : NSObject
/**
 *  实例化对象
 *
 *  @param font   文字大小
 *  @param color  文字颜色
 *  @param string 文字字符串
 *
 *  @return SYAttributedStringModel
 */
- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string;
+ (instancetype)attributedStringModelWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string;

/**
 获取富文本

 @return 富文本
 */
- (NSAttributedString *)attributedString ;
/**
 *  设置部分文字颜色字体
 *
 *  @param partString 要设置的文字
 *  @param fontSize    字体大小
 *  @param color          颜色
 *  @param string        文字串内容或者是NSMutableAttributedString
 *
 *  @return 设置后的文字
 */
+ (NSMutableAttributedString *)sy_setPartString:(NSString *)partString WithFontSize:(CGFloat)fontSize Color:(UIColor *)color inString:(id)string;
/**
 *  设置部分文字颜色字体
 *
 *  @param partString 要设置的文字
 *  @param font           字体大小(UIFont对象)
 *  @param color          颜色
 *  @param string        文字串内容或者是NSMutableAttributedString
 *
 *  @return 设置后的文字
 */
+ (NSMutableAttributedString *)sy_setPartString:(NSString *)partString WithFont:(UIFont *)font Color:(UIColor *)color inString:(id)string;
/**
 *  根据字体模型获得 NSAttributedString
 *
 *  @param models 模型数组
 *
 */
+ (NSAttributedString *)sy_attributedStringWithModels:(NSArray <SYAttributedStringModel *>*)models;
/**
 *  根据字体模型获得 NSAttributedString并设置文字行间距
 *
 *  @param models   模型数组
 *  @param multiple 行高倍数
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)sy_attributedStringWithModels:(NSArray <SYAttributedStringModel *>*)models andHeightMultiple:(CGFloat)multiple;
/**
 *  根据字体模型获得 NSAttributedString并设置文字行间距
 *
 *  @param models   模型数组
 *  @param lineHeight 行高
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)sy_attributedStringWithModels:(NSArray <SYAttributedStringModel *>*)models andLineHeight:(CGFloat)lineHeight;
/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param multiple 行高倍数
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)sy_attributedStringWithString:(NSString *)string andHeigthMultiple:(CGFloat)multiple;
/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param lineHeight 行间距
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)sy_attributedStringWithString:(NSString *)string andLineHeight:(CGFloat)lineHeight;


@end
