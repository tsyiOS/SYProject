//
//  RTHChatCell.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/10/8.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHChatCell.h"

@interface RTHChatCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLeftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textRightMargin;
@property (weak, nonatomic) IBOutlet UIImageView *leftHeadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightHeadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftBg;
@property (weak, nonatomic) IBOutlet UIImageView *rightBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBgRightMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBgLeftMargin;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@end

@implementation RTHChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(RTHChatMessage *)message {
    if (message.isMyself) {
        self.textLeftMargin.constant = 95;
        self.textRightMargin.constant = 80;
        self.rightBgLeftMargin.constant = 85;
        self.leftHeadImageView.hidden = YES;
        self.rightHeadImageView.hidden = NO;
        self.leftBg.hidden = YES;
        self.rightBg.hidden = NO;
        self.textView.textColor = [UIColor blackColor];
    }else {
        self.textLeftMargin.constant = 85;
        self.textRightMargin.constant = 90;
        self.leftBgRightMargin.constant = 85;
        self.leftHeadImageView.hidden =  NO;
        self.rightHeadImageView.hidden = YES;
        self.leftBg.hidden = NO;
        self.rightBg.hidden = YES;
        self.textView.textColor = [UIColor whiteColor];
    }
    
    if ([message.message sy_sizeWithLabelWidth:self.textView.sy_width].height < 25) {
        //一行
        if (message.isMyself) {
            self.rightBgLeftMargin.constant = ScreenW - [message.message sy_sizeOnSingleRow].width - 70 - 20;
            self.textLeftMargin.constant = ScreenW - [message.message sy_sizeOnSingleRow].width - 85;
        }else {
            self.leftBgRightMargin.constant = ScreenW - [message.message sy_sizeOnSingleRow].width - 70 - 20;
            self.textRightMargin.constant = ScreenW - [message.message sy_sizeOnSingleRow].width - 85;
        }
    }
    self.textView.attributedText = message.message;
}

@end
