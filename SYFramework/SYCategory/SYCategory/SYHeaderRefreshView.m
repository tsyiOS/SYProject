//
//  SYHeaderRefreshView.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/6/21.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "SYHeaderRefreshView.h"
#import "UIView+SYExtension.h"
#import "NSDate+SYExtension.h"
#import "UIColor+SYExtension.h"

#define SYRefreshSrcName(file) [@"SYRefreshSource.bundle" stringByAppendingPathComponent:file]
#define SYTextFont 14
#define SYTextColor 0x5A5A5A
static NSString *const SYRefreshTimeKey = @"SYRefreshTimeKey";

@interface SYHeaderRefreshView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation SYHeaderRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.iconImageView];
    [self addSubview:self.indicatorView];
}

- (void)setStatus:(SYRefreshStatus)status {
    _status = status;
    NSString *title;
    switch (status) {
        case SYRefreshPullDown:{
            title = @"下拉可以刷新";
            [self.indicatorView stopAnimating];
            self.iconImageView.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                self.iconImageView.transform = CGAffineTransformIdentity;
            }];
        }
            
            break;
        case SYRefreshReady: {
            title = @"松开立即刷新";
            [self.indicatorView stopAnimating];
            self.iconImageView.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                self.iconImageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            
            break;
        case SYRefreshing:
            title = @"正在获取数据...";
            self.iconImageView.hidden = YES;
            [self.indicatorView startAnimating];
            [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:SYRefreshTimeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
    }
    self.titleLabel.text = title;
     self.timeLabel.text = [NSString stringWithFormat:@"最后更新:%@",[self lastRefreshTime]];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:SYTextFont];
        _titleLabel.textColor = [UIColor sy_colorWithRGB:SYTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = CGRectMake(0, 0, self.sy_width, self.sy_height * 0.5);
        _titleLabel.text = @"下拉可以刷新";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont boldSystemFontOfSize:SYTextFont];
        _timeLabel.textColor = [UIColor sy_colorWithRGB:SYTextColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.frame = CGRectMake(0, 25, self.sy_width, self.sy_height * 0.5);
        _timeLabel.text = [NSString stringWithFormat:@"最后更新:%@",[self lastRefreshTime]];
    }
    return _timeLabel;
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SYRefreshSrcName(@"sy_arrow")]];
        _iconImageView.frame = CGRectMake((self.sy_width - 200)*0.5, (self.sy_height - 40)*0.5, 15, 40);
    }
    return _iconImageView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.center = self.iconImageView.center;
    }
    return _indicatorView;
}

- (NSString *)lastRefreshTime {
    NSDate *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:SYRefreshTimeKey];
    lastDate = lastDate?:[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    return [NSString stringWithFormat:@" %@ %@",[self dateString:lastDate],[formatter stringFromDate:lastDate]];
}

- (NSString *)dateString:(NSDate *)day {
    if ([day sy_isToday]) {
        return @"今天";
    }else if([day sy_isYesterday]){
       return @"昨天";
    }else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM/dd";
        return [formatter stringFromDate:day];
    }
}


@end
