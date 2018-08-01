
#import <Foundation/Foundation.h>

@interface NSDate (SYExtension)
- (BOOL)sy_isToday;
- (BOOL)sy_isYesterday;

- (NSInteger)sy_year;
- (NSInteger)sy_month;
- (NSInteger)sy_day;
- (NSInteger)sy_hour;
- (NSInteger)sy_minute;
- (NSInteger)sy_second;

- (NSInteger)sy_secondsFrom:(NSDate *)date;
- (NSInteger)sy_daysFrom:(NSDate *)date;

- (NSString *)sy_weekday;
- (NSString *)sy_stringWithFormat:(NSString*)format;

- (NSDate *)sy_yesterday;
- (NSDate *)sy_tomorrow;
+ (NSDate *)sy_dateWithString:(NSString *)str formate:(NSString *)formate;

- (NSString *)sy_showTimeFrom:(NSDate *)date;
+ (NSString *)sy_showTimeFromNowTime:(NSString *)nowTime toCreateTime:(NSString *)createTime;
@end
