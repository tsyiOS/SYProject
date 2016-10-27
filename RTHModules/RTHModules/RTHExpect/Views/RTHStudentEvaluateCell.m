//
//  RTHStudentEvaluateCell.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/9/23.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHStudentEvaluateCell.h"

@interface RTHStudentEvaluateCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation RTHStudentEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius = self.headImageView.sy_height * 0.5;
    self.headImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
