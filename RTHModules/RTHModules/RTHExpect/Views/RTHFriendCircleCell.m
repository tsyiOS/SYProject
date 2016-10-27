//
//  RTHFriendCircleCell.m
//  SYSlideDemo
//
//  Created by 唐绍禹 on 16/9/24.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHFriendCircleCell.h"
#import "RTHImageContentView.h"

@interface RTHFriendCircleCell ()
@property (weak, nonatomic) IBOutlet RTHImageContentView *imageContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageContentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@end

@implementation RTHFriendCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius = self.headImageView.sy_height * 0.5;
    self.headImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageCount:(NSInteger)imageCount {
    _imageCount = imageCount;
    self.imageContentViewHeight.constant = [self.imageContentView setUpImages:imageCount];
}

@end
