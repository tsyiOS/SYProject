//
//  RPAttributedStringModel.m
//  RoomPrice
//
//  Created by leju_esf on 16/5/3.
//  Copyright © 2016年 leju. All rights reserved.
//

#import "ERAttributedStringModel.h"

@interface ERAttributedStringModel ()
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, strong) UIColor *deleteLineColor;
@property (nonatomic, assign) BOOL underLine;
@end

@implementation ERAttributedStringModel
- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string {
    return [[ERAttributedStringModel alloc] initWithFont:font Color:color String:string deleteLineColor:nil];
}

- (instancetype)initWithImageName:(NSString *)imageName andImageFrame:(CGRect)rect {
    return [self initWithImageName:imageName andImageFrame:rect deleteLineColor:nil];
}

- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string deleteLineColor:(UIColor *)lineColor {
    if (self = [super init]) {
        self.font = font;
        self.color = color;
        self.string = string;
        self.deleteLineColor = lineColor;
        self.reacts = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithFont:(UIFont *)font Color:(UIColor *)color String:(NSString *)string hadUnderLine:(BOOL)underLine {
    if (self = [super init]) {
        self.font = font;
        self.color = color;
        self.string = string;
        self.underLine = underLine;
        self.reacts = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName andImageFrame:(CGRect)rect deleteLineColor:(UIColor *)lineColor {
    if (self = [super init]) {
        self.imageName = imageName;
        self.imageFrame = rect;
        self.deleteLineColor = lineColor;
        self.reacts = [NSMutableArray array];
    }
    return self;
}

- (NSAttributedString *)attributedString {
    return [[NSAttributedString alloc] initWithString:self.string attributes:@{NSForegroundColorAttributeName:self.color,NSFontAttributeName:self.font}];
}

+ (NSMutableAttributedString *)setPartString:(NSString *)partString WithFont:(CGFloat)font Color:(UIColor *)color inString:(id)string {
    
    NSMutableAttributedString *mutableAttri;
    if ([string isKindOfClass:[NSString class]]) {
        mutableAttri = [[NSMutableAttributedString alloc] initWithString:string];
    }else if([string isKindOfClass:[NSMutableAttributedString class]]) {
        mutableAttri = string;
    }else if ([string isKindOfClass:[NSAttributedString class]]) {
        mutableAttri = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    }else {
        return nil;
    }
    
    if (partString.length == 0 || mutableAttri.length == 0) {
        return nil;
    }
    
    NSRange range = [mutableAttri.string rangeOfString:partString];
    [mutableAttri addAttribute:NSForegroundColorAttributeName value:color range:range];
    [mutableAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    return mutableAttri;
}

+ (NSMutableAttributedString *)setPartString:(NSString *)partString WithBoldFont:(CGFloat)font Color:(UIColor *)color inString:(id)string {
    NSMutableAttributedString *mutableAttri;
    if ([string isKindOfClass:[NSString class]]) {
        mutableAttri = [[NSMutableAttributedString alloc] initWithString:string];
    }else if([string isKindOfClass:[NSMutableAttributedString class]]) {
        mutableAttri = string;
    }else if ([string isKindOfClass:[NSAttributedString class]]) {
        mutableAttri = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    }else {
        return nil;
    }
    NSRange range = [mutableAttri.string rangeOfString:partString];
    [mutableAttri addAttribute:NSForegroundColorAttributeName value:color range:range];
    [mutableAttri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font] range:range];
    return mutableAttri;
}

+ (CGSize)sizeForAttributedString:(NSAttributedString *)attributedStr withLabelWidth:(CGFloat)width {
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [attributedStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil].size;
}

+ (NSAttributedString *)attributedStringWithModels:(NSArray *)models {
    if (models.count == 0) {
        return nil;
    }
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] init];
    for (ERAttributedStringModel *model in models) {
        if(model.imageName.length > 0){
            NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            attach.bounds = model.imageFrame;
            attach.image = [UIImage imageNamed:model.imageName];
            if (model.deleteLineColor) {
                NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
                [strAtt addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, strAtt.length)];
                [strAtt addAttribute:NSStrikethroughColorAttributeName value:model.deleteLineColor range:NSMakeRange(0, strAtt.length)];
                 [attriStr appendAttributedString:strAtt];
            }else {
                NSAttributedString *strAtt = [NSAttributedString attributedStringWithAttachment:attach];
                 [attriStr appendAttributedString:strAtt];
            }
           
        }else {
            NSMutableDictionary *attri = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                         NSForegroundColorAttributeName:model.color,
                                                                                         NSFontAttributeName:model.font,
                                                                                         NSStrikethroughStyleAttributeName:model.deleteLineColor?@(NSUnderlinePatternSolid | NSUnderlineStyleSingle):@(NSUnderlineStyleNone),
                                                                                         NSUnderlineStyleAttributeName:model.underLine?@(NSUnderlineStyleSingle):@(NSUnderlineStyleNone)
                                                                                         }];
            if (model.deleteLineColor) {
                [attri setValue:model.deleteLineColor forKey:NSStrikethroughColorAttributeName];
            }
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:model.string attributes:attri];
            [attriStr appendAttributedString:str];
        }
    }
    return attriStr;
}

+ (NSArray *)searchRangesWithString:(NSString *)string inString:(NSString *)longString {
    NSMutableArray *ranges = [NSMutableArray array];
    NSRange startRange = NSMakeRange(0, longString.length);
    
    while (startRange.length != 0) {
        NSRange range = [longString rangeOfString:string?:@"" options:NSCaseInsensitiveSearch range:startRange];
        if (range.location != NSNotFound) {
            [ranges addObject:[NSValue valueWithRange:range]];
            startRange = NSMakeRange(range.length + range.location, longString.length - range.length - range.location);
        }else {
            startRange = NSMakeRange(0, 0);
        }
    }
    
    return ranges;
}

+ (NSAttributedString *)attributedStringWithModels:(NSArray *)models andHeigthMultiple:(CGFloat)multiple {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedStringWithModels:models]];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineHeightMultiple = multiple;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    return attriStr;
}

+ (NSAttributedString *)attributedStringWithModels:(NSArray *)models andLineHeight:(CGFloat)lineHeight {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedStringWithModels:models]];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = lineHeight;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    return attriStr;
    
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string andHeigthMultiple:(CGFloat)multiple {
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

+ (NSAttributedString *)attributedStringWithString:(NSString *)string andLineHeight:(CGFloat)lineHeight {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = lineHeight;
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    return attriStr;
}

+ (CGSize)sizeForString:(NSString *)string withLabelWidth:(CGFloat)width andFont:(CGFloat)font{
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName :[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName : style };
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
}

+ (CGSize)sizeOnSingleRowForString:(NSString *)string withFont:(CGFloat)font{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}

@end
