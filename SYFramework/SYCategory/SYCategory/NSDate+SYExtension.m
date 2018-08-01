
#import "NSDate+SYExtension.h"

@implementation NSDate (SYExtension)
- (BOOL)sy_isToday {
    NSUInteger flags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *currentComponent = [[NSCalendar currentCalendar]components:flags fromDate:[NSDate date]];
    NSDateComponents *lastComponent = [[NSCalendar currentCalendar]components:flags fromDate:self];
    return  currentComponent.year == lastComponent.year && currentComponent.month == lastComponent.month && currentComponent.day == lastComponent.day;
}
- (BOOL)sy_isYesterday {
    return  [[self sy_yesterday] sy_isToday];
}

- (NSInteger)sy_year {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSInteger)sy_month {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)sy_day {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)sy_hour {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitHour fromDate:self];
    return components.hour;
}

- (NSInteger)sy_minute {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitMinute fromDate:self];
    return components.minute;
}

- (NSInteger)sy_second {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitSecond fromDate:self];
    return components.second;
}

- (NSInteger)sy_secondsFrom:(NSDate *)date {
    return [self timeIntervalSince1970] - [date timeIntervalSince1970];
}

- (NSInteger)sy_daysFrom:(NSDate *)date {
    return (NSInteger)[self sy_secondsFrom:date]/(24*60*60);
}

- (NSString *)sy_weekday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *weekdayStr = nil;
    [formatter setDateFormat:@"c"];
    NSInteger weekday = [[formatter stringFromDate:self] integerValue];
    if( weekday==1 ){
        weekdayStr = @"星期日";
    }else if( weekday==2 ){
        weekdayStr = @"星期一";
    }else if( weekday==3 ){
        weekdayStr = @"星期二";
    }else if( weekday==4 ){
        weekdayStr = @"星期三";
    }else if( weekday==5 ){
        weekdayStr = @"星期四";
    }else if( weekday==6 ){
        weekdayStr = @"星期五";
    }else if( weekday==7 ){
        weekdayStr = @"星期六";
    }
    return weekdayStr;
}

- (NSString *)sy_stringWithFormat:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:self];
    return string;
}

- (NSDate *)sy_yesterday {
    return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self];
}

- (NSDate *)sy_tomorrow {
    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:self];
}

+ (NSDate *)sy_dateWithString:(NSString *)str formate:(NSString *)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:str];
    return date;
}

- (NSString *)sy_showTimeFrom:(NSDate *)date {
    NSInteger time = (-1)*[self timeIntervalSinceDate:date];
    if ([self sy_isToday]) {
        if ( time < 3600) {
            return [NSString stringWithFormat:@"%zd分钟前",(time/60) + 1];
        }else  {
            return [NSString stringWithFormat:@"%zd小时前发布",time/3600];
        }
    }else if ([self sy_isYesterday]) {
        return @"昨天";
    }else {
        return [self sy_stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
}

+ (NSString *)sy_showTimeFromNowTime:(NSString *)nowTime toCreateTime:(NSString *)createTime {
    NSDate *now = [NSDate sy_dateWithString:nowTime formate:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *creat = [NSDate sy_dateWithString:createTime formate:@"yyyy-MM-dd HH:mm:ss"];
    return [now sy_showTimeFrom:creat];
}

@end
