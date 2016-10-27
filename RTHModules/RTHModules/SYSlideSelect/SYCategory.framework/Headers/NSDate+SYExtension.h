//
//  NSDate+SYExtension.h
//  SYSlideDemo
//
//  Created by leju_esf on 16/6/23.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SYExtension)
- (BOOL)sy_today;
- (BOOL)sy_yesterday;
- (NSInteger)sy_year;
- (NSInteger)sy_month;
- (NSInteger)sy_day;
- (NSInteger)sy_hour;
- (NSInteger)sy_minute;
- (NSInteger)sy_second;
- (NSString *)sy_weekday;
- (NSString *)sy_stringWithFormat:(NSString*)format;

+ (NSDate *)sy_dateWithString:(NSString *)str formate:(NSString *)formate;
@end
