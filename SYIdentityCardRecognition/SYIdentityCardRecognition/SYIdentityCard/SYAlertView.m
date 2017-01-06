//
//  SYAlertView.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/5.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYAlertView.h"
#import "SYIdentityModel.h"
#import "SYAttributedStringModel.h"
#import "UIColor+SYExtension.h"

@interface SYAlertView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) SYIdentityModel *model;
@property (nonatomic, copy) void(^completion)();
@property (nonatomic, strong) UIView *shadow;
@end

@implementation SYAlertView

+ (instancetype) alertViewWithModel:(SYIdentityModel *)model andComplete:(void(^)())completion {
    SYAlertView *alertView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
    alertView.layer.cornerRadius = 5;
    alertView.clipsToBounds = YES;
    alertView.model = model;
    alertView.completion = completion;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:alertView action:@selector(clickAction)];
    [alertView addGestureRecognizer:tap];
    return alertView;
}

- (void)clickAction {
    if (self.completion) {
        self.completion();
    }
    [self.shadow removeFromSuperview];
    [self removeFromSuperview];
}

- (void)setModel:(SYIdentityModel *)model {
    self.nameLabel.text = model.name;
    self.sexLabel.text = model.gender;
    self.nationLabel.text = model.nation;
    self.addressLabel.text =  model.address;
    self.numberLabel.text = model.code;
    
    self.birthdayLabel.text = [NSString stringWithFormat:@""];
    
    if (model.code) {
        
        NSArray *strs = @[model.year,@" 年 ",model.month,@" 月 ",model.day,@" 日 "];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i = 0; i < strs.count; i++) {
            if (i%2 == 0) {
                SYAttributedStringModel *numModel = [SYAttributedStringModel attributedStringModelWithFont:[UIFont systemFontOfSize:15] Color:self.nameLabel.textColor String:strs[i]];
                [tempArray addObject:numModel];
            }else {
                SYAttributedStringModel *strModel = [SYAttributedStringModel attributedStringModelWithFont:[UIFont systemFontOfSize:13] Color:self.titleLabel.textColor String:strs[i]];
                [tempArray addObject:strModel];
            }
        }
        self.birthdayLabel.attributedText = [SYAttributedStringModel sy_attributedStringWithModels:tempArray];
    }
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.frame = CGRectMake((ScreenW - self.frame.size.width) *0.5, (ScreenH - self.frame.size.height) * 0.5, self.frame.size.width, self.frame.size.height);
    if (![[window subviews] containsObject:self]) {
        [window addSubview:self.shadow];
        [window addSubview:self];
    }
    [window bringSubviewToFront:self];
}

- (UIView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _shadow;
}

@end
