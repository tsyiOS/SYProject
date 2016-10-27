//
//  RTHdynamicsCell.m
//  SYSlideDemo
//
//  Created by yjc on 16/10/12.
//  Copyright © 2016年 tsy. All rights reserved.
//

#import "RTHdynamicsCell.h"
#import "RTHImageContentView.h"

@interface RTHdynamicsCell ()
@property (weak, nonatomic) IBOutlet RTHImageContentView *imageContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageContentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation RTHdynamicsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius = self.headImageView.sy_height;
    self.headImageView.clipsToBounds = YES;
}

- (void)setImageCounts:(NSInteger)imageCounts {
    _imageCounts = imageCounts;
    self.imageContentViewHeight.constant = [self.imageContentView setUpImages:imageCounts];
}

@end
