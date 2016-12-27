
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

@end
