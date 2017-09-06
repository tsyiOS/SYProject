//
//  RPAttributedStringModel.h
//  RoomPrice
//
//  Created by leju_esf on 16/5/3.
//  Copyright © 2016年 leju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ERAttributedStringModel : NSObject

@property (nonatomic, strong) NSMutableArray *reacts;
@property (nonatomic, strong) NSAttributedString *attributedString;
@property (nonatomic, copy) void(^hrefAction)();

/**
 初始化富文本图片模型

 @param imageName 图片名称
 @param rect 图片大小
 @return 富文本模型对象
 */
- (instancetype)initWithImageName:(NSString *)imageName andImageFrame:(CGRect)rect;
/**
 初始化富文本文字

 @param font 字体
 @param color 颜色
 @param string 文字内容
 @return 富文本模型对象
 */
- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string;
/**
 初始化带删除线富文本文字
 
 @param font 字体
 @param color 颜色
 @param string 文字内容
 @param lineColor 删除线颜色
 @return 富文本模型对象
 */
- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string deleteLineColor:(UIColor *)lineColor;

- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string hadUnderLine:(BOOL)underLine;
/***************获取富文本******************/
/**
 *  根据字体模型获得 NSAttributedString
 *
 *  @param models 模型数组
 *
 */
+ (NSAttributedString *)attributedStringWithModels:(NSArray *)models;
/**
 *  根据字体模型获得 NSAttributedString并设置文字行间距
 *
 *  @param models   模型数组
 *  @param multiple 行高倍数
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)attributedStringWithModels:(NSArray *)models andHeigthMultiple:(CGFloat)multiple;

+ (NSAttributedString *)attributedStringWithModels:(NSArray *)models andLineHeight:(CGFloat)lineHeight;
/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param multiple 行高倍数
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)attributedStringWithString:(NSString *)string andHeigthMultiple:(CGFloat)multiple;
/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param lineHeight 行间距
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)attributedStringWithString:(NSString *)string andLineHeight:(CGFloat)lineHeight;
/**
 *  设置部分文字颜色字体
 *
 *  @param partString 要设置的文字
 *  @param font       大小
 *  @param color      颜色
 *  @param string     总文字
 *
 *  @return 设置后的文字
 */
+ (NSMutableAttributedString *)setPartString:(NSString *)partString WithFont:(CGFloat)font Color:(UIColor *)color inString:(id)string;
/**
 *  字体加粗
 */
+ (NSMutableAttributedString *)setPartString:(NSString *)partString WithBoldFont:(CGFloat)font Color:(UIColor *)color inString:(id)string;

/**
 *  根据NSAttributedString计算label大小
 *
 *  @param attributedStr 副文本
 *  @param width         label的宽度
 *
 *  @return 文本大小
 */
+ (CGSize)sizeForAttributedString:(NSAttributedString *)attributedStr withLabelWidth:(CGFloat)width;

/**
 *  根据NSString计算label大小
 *
 *  @param string 文本
 *  @param width  label的宽度
 *
 *  @return 文本大小
 */
+ (CGSize)sizeForString:(NSString *)string withLabelWidth:(CGFloat)width andFont:(CGFloat)font;
/**
 *  根据NSString计算单行label大小
 *
 *  @param string 文本
 *
 *  @return 文本大小
 */
+ (CGSize)sizeOnSingleRowForString:(NSString *)string withFont:(CGFloat)font;

@end
